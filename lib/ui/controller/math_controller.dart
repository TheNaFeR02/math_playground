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

  String get operation => _operation.value;

  Future<void> startSession() async {
    score.value = 0;
    questionNumber.value = 0;
    time.value = 0;

    print("The session started");
    final List<OperationLevel> userLevel = userController.user.operationLevel;
    print("${userLevel} here!");
    questions.value = mathUseCase.startSession(userLevel);

    print(questions);
    _operation.value = questions[questionNumber.value];
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

      // Update user level based on performance.
      if (levelUpdate != 0) {
        if (!(userController.user.operationLevel[0].level == 3 &&
                levelUpdate == 1) &&
            !(userController.user.operationLevel[0].level == 1 &&
                levelUpdate == -1)) {
          int newLevel = userController.user.operationLevel[0].level +
              levelUpdate; // Update the level
          print("level updated to $newLevel!!!!!");
          await userController.updateUserLevel(
              newLevel, userController.user.id);
        }
      }

      // Get the updated user data.
      await userController.getUser();

      // Reset the session.
      await startSession();
    }

    update();
  }
}
