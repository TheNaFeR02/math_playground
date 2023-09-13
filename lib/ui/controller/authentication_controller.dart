import 'package:math_playground/domain/use_case/authentication_usecase.dart';
import 'package:get/get.dart';

import 'package:loggy/loggy.dart';

class AuthenticationController extends GetxController {
  final logged = false.obs;
  final firstTime = true.obs;

  bool get isLogged => logged.value;
  bool get isFirstTime => firstTime.value;

  Future<void> login(email, password) async {
    final AuthenticationUseCase authentication = Get.find();
    await authentication.login(email, password);
    logged.value = true;
  }

  Future<bool> signUp(email, password) async {
    final AuthenticationUseCase authentication = Get.find();
    logInfo('Controller Sign Up');
    await authentication.signUp(email, password);
    return true;
  }

  Future<void> logOut() async {
    logged.value = false;
  }

  // check if logging for the first time
  Future<void> checkIsFirstTime() async {
    final AuthenticationUseCase authentication = Get.find();
    //change firstTime value
    firstTime.value = await authentication.checkIsFirstTime();
  }
}
