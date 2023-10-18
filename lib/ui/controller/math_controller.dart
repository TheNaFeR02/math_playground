import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:loggy/loggy.dart';
import 'package:math_playground/domain/models/operation_level.dart';
import 'package:math_playground/domain/use_case/math_usecase.dart';
import 'package:math_playground/ui/controller/user_controller.dart';
import 'package:math_playground/ui/pages/content/operation_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart'; // Import the Dio package

class MathController extends GetxController {
  final UserController userController = Get.find();
  final MathUseCase mathUseCase = Get.find();
  final session = 1.obs;
  final score = 0.obs;
  final questionNumber = 0.obs;
  final time = 0.obs;
  final _operation = ''.obs;
  final questions = <String>[].obs;
  final _operationSession = ''.obs;
  Timer? timer;

  String get operation => _operation.value;
  String get operationSession => _operationSession.value;

  Future<void> printLocalStorage() async {
    final SharedPreferences userInfo = await SharedPreferences.getInstance();
    log("-----Printing the LOCAL user data-----");
    log("${userInfo.getString('username')}");
    log("${userInfo.getString('email')}");
    log("${userInfo.getInt('addition')}");
    log("${userInfo.getInt('subtraction')}");
    log("${userInfo.getInt('multiplication')}");
    log("${userInfo.getInt('division')}");
    log("-----End of the LOCAL user data-----");
    // use log
  }

  Future<void> startSession(String sessionMathOperation) async {
    // Initialize the session.
    initializeSession(sessionMathOperation);

    // Start the timer.
    startTimer();

    // Create the questions depending the operation and the user level.
    fetchQuestions(sessionMathOperation);

    // Update the number of the question to display. 0/6 -> 1/6...
    updateQuestionDisplay();
  }

  void initializeSession(String sessionMathOperation) {
    score.value = 0;
    questionNumber.value = 0;
    time.value = 0;
    _operationSession.value = sessionMathOperation;
  }

  void fetchQuestions(String sessionMathOperation) {
    final List<OperationLevel> userLevel = userController.user.operationLevel;
    questions.value = mathUseCase.startSession(userLevel, sessionMathOperation);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentTime = time.value;
      time.value = currentTime + 1;
    });
  }

  void updateQuestionDisplay() {
    _operation.value = questions[questionNumber.value];
    questionNumber.value++;
    update();
  }

  Future<void> checkAnswer(String input) async {
    // Check if the answer is correct.
    if (mathUseCase.checkAnswer(input, _operation.value)) {
      score.value++;
      print(score.value);
    }

    // Check if there are more questions.
    if (!moveToNextQuestion()) {
      handleSessionEnd();
    }

    update();
  }

  bool moveToNextQuestion() {
    if (questionNumber.value < questions.length) {
      _operation.value = questions[questionNumber.value];
      questionNumber.value++;
      return true;
    }
    return false;
  }

  void handleSessionEnd() async {
    if (questionNumber.value == questions.length) {
      session.value += 1;

      // End the timer.
      endTimer();

      // Get the index of the operation. 1 -> addition, 2 -> subtraction...
      log("operationSession: ${_operationSession.value}");
      int indexOperation = getIndexOperation(_operationSession.value);

      // Check if the user level should be updated.
      int levelUpdate = mathUseCase.checkPerformance(
          score.value, questions.length, time.value);

      // Check if the user level can be updated.
      // (if the user is not in the max or min level. In max level can't go up,...)
      if (shouldUpdateLevel(levelUpdate, indexOperation)) {
        final newLevel =
            userController.user.operationLevel[indexOperation].level +
                levelUpdate;

        try {
          await updateUserLevelInLocalStorage(
              newLevel, _operationSession.value);

          //level before
          final int oldLevel =
              userController.user.operationLevel[indexOperation].level;
          await saveSessionInfoInLocalStorage(
              _operationSession.value, newLevel, oldLevel, time.value, score.value);
        } catch (error) {
          logError('An error occurred: $error');
        }

        showLevelUpdatedSnackbar();
      }

      // Start another session right away.
      // await startSession(_operationSession.value);

      Get.to(const SelectOperation());
    }
  }

  int getIndexOperation(String operationSession) {
    switch (operationSession) {
      case 'addition':
        return 0;
      case 'subtraction':
        return 1;
      case 'multiplication':
        return 2;
      case 'division':
        return 3;
      default:
        throw ArgumentError("Invalid operationSession: $operationSession");
    }
  }

  bool shouldUpdateLevel(int levelUpdate, int indexOperation) {
    if (levelUpdate != 0) {
      if (!(userController.user.operationLevel[indexOperation].level == 3 &&
              levelUpdate == 1) &&
          !(userController.user.operationLevel[indexOperation].level == 1 &&
              levelUpdate == -1)) {
        return true;
      }
    }
    return false;
  }

  Future<void> updateUserLevelInLocalStorage(
      int newLevel, String operationSession) async {
    final SharedPreferences userInfo = await SharedPreferences.getInstance();
    // Save the new level in the local storage.
    userInfo.setInt(operationSession, newLevel);

    // await userController.updateUserLevel(
    //     newLevel, userController.user.username, operationSession);
    // await userController.getUserLocalInfo();
  }

  void endTimer() {
    timer?.cancel();
  }

  void showLevelUpdatedSnackbar() {
    Get.snackbar(
      "Level Updated. Your time was: ${time.value} seconds.",
      'OK',
      icon: const Icon(Icons.person, color: Colors.green),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> saveSessionInfoInLocalStorage(
      String operation, int newLevel, int oldLevel, int time, int score) async {
    final SharedPreferences userInfo = await SharedPreferences.getInstance();

    int maxSessions = 3; // Maximum number of sessions to store.
    final sessionNumber = getNextSessionNumber(userInfo, maxSessions);

    if (sessionNumber == maxSessions) {
      // You've reached the maximum number of sessions, remove the oldest session
      removeOldestSession(userInfo);
    }

    final sessionKeyPrefix = 'session$sessionNumber';

    userInfo.setInt('$sessionKeyPrefix-time', time);
    userInfo.setInt('$sessionKeyPrefix-newLevel', newLevel);
    userInfo.setInt('$sessionKeyPrefix-oldLevel', oldLevel);
    userInfo.setInt('$sessionKeyPrefix-score', score);
    userInfo.setString('$sessionKeyPrefix-operation', operation);
  }

  int getNextSessionNumber(SharedPreferences userInfo, int maxSessions) {
    int sessionNumber = 1;
    while (sessionNumber <= maxSessions) {
      if (!userInfo.containsKey('session$sessionNumber-time')) {
        return sessionNumber;
      }
      sessionNumber++;
    }
    return 1; // Wrap around and overwrite the oldest session
  }

  void removeOldestSession(SharedPreferences userInfo) {
    int sessionNumber = 1;
    while (userInfo.containsKey('session$sessionNumber-time')) {
      final sessionKeyPrefix = 'session$sessionNumber';
      userInfo.remove('$sessionKeyPrefix-time');
      userInfo.remove('$sessionKeyPrefix-newLevel');
      userInfo.remove('$sessionKeyPrefix-oldLevel');
      userInfo.remove('$sessionKeyPrefix-operation');
      userInfo.remove('$sessionKeyPrefix-score');
      sessionNumber++;
    }
  }
}
