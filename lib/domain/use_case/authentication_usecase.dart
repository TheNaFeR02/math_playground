import 'package:math_playground/domain/repositories/repository.dart';
import 'package:get/get.dart';

class AuthenticationUseCase {
  final Repository _repository = Get.find();

  Future<bool> login(String email, String password) async =>
      await _repository.login(email, password);

  Future<bool> signUp(String email, String password) async =>
      await _repository.signUp(email, password);

  Future<bool> checkIsFirstTime() async => await _repository.checkIsFirstTime();

  Future<bool> logOut() async => await _repository.logOut();
} 