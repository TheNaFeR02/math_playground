import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:math_playground/domain/models/operation_level.dart';
import 'package:math_playground/domain/use_case/math_usecase.dart';
import 'package:math_playground/ui/controller/user_controller.dart';

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

  String get operation => _operation.value;
  String get operationSession => _operationSession.value;

  Future<void> startSession(String operationSession) async {
    score.value = 0;
    questionNumber.value = 0;
    time.value = 0;

    //run the time
    // startTime();

    print("The session started");
    final List<OperationLevel> userLevel = userController.user.operationLevel;
    print("${userLevel} here!");
    questions.value = mathUseCase.startSession(userLevel,
        operationSession); // Create the list of problems and pass it to the controller.
    _operationSession.value = operationSession; // Set the operation of the current session.

    print(questions);
    _operation.value = questions[questionNumber.value];
    questionNumber.value++;
    update();
  }

  Future<void> checkAnswer(String input) async {
    if (mathUseCase.checkAnswer(input, _operation.value)) {
      score.value++;
      print(score.value);
    }
    if (questionNumber.value < questions.length) {
      _operation.value = questions[questionNumber.value];
      questionNumber.value++;
    }
    // Check if the session is over.
    if (questionNumber.value == questions.length) {
      session.value += 1;

      // Check if the user perfomance is good enough to level up.
      int levelUpdate =
          mathUseCase.checkPerformance(score.value, questions.length);

      int indexOperation = -1;
      print(operationSession);
      switch (_operationSession.value) {
        case 'addition':
          indexOperation = 0;
          break;
        case 'subtraction':
          indexOperation = 1;
          break;
        case 'multiplication':
          indexOperation = 2;
          break;
        case 'division':
          indexOperation = 3;
          break;
      }
      print('index operation: $indexOperation');
      // Update user level based on performance.
      if (levelUpdate != 0) {
        if (!(userController.user.operationLevel[indexOperation].level == 3 &&
                levelUpdate == 1) &&
            !(userController.user.operationLevel[indexOperation].level == 1 &&
                levelUpdate == -1)) {
          int newLevel =
              userController.user.operationLevel[indexOperation].level +
                  levelUpdate; // Update the level
          print("level updated to $newLevel!!!!!");
          await userController.updateUserLevel(
              newLevel, userController.user.id, _operationSession.value);
        }
      }

      // Get the updated user data.
      await userController.getUser();

      // Reset the session.
      await startSession(_operationSession.value);
    }

    update();
  }

  // void startTime() async {
  //   Future.delayed(const Duration(seconds: 1), () {
  //     time.value++;
  //     startTime();
  //   });
  // }
}
