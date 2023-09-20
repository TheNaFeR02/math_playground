import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:math_playground/domain/models/operation_level.dart';
import 'package:math_playground/domain/use_case/math_usecase.dart';
import 'package:math_playground/ui/controller/user_controller.dart';

class MathController extends GetxController {
  final UserController userController = Get.find();
  final MathUseCase mathUseCase = Get.find();
  final session = 0.obs;
  final score = 0.obs;
  final questionNumber = 0.obs;
  final time = 0.obs;
  final _operation = ''.obs;
  final questions = <String>[].obs;

  String get operation => _operation.value;

  void startSession() {
    session.value = 1;
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

  void checkAnswer(String input) {
    if (mathUseCase.checkAnswer(input, _operation.value)) {
      score.value++;
      print(score.value);
    }
    questionNumber.value++;
    _operation.value = questions[questionNumber.value];
    update();
  }
}
