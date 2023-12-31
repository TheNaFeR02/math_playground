import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../models/user.dart';
import '../repositories/repository.dart';

class UserUseCase {
  final Repository _repository = Get.find();

  UserUseCase();

  Future<User> getUser() async {
    logInfo("Getting users details from repository");
    return await _repository.getUser();
  }

  Future<void> updateUserLevel(int newLevel, String username) async {
    logInfo("Updating User Level");
    await _repository.updateUserLevel(newLevel, username);
  }

  Future<void> updateAllUserInfoInAPI(String username, int additionLevel, int subtractionLevel, int multiplicationLevel, int divisionLevel) async {
    await _repository.updateAllUserInfoInAPI(username, additionLevel, subtractionLevel, multiplicationLevel, divisionLevel);
  }

  Future<void> updateStudentInfo(String username, String school, String grade, String datebirth) async {
    await _repository.updateStudentInfo(username, school, grade, datebirth);
  }

  Future<void> updateUserSessionInfoInAPI(String username) async {
    await _repository.updateUserSessionInfoInAPI(username);
  }

  // Future<List<User>> getUsers() async {
  //   logInfo("Getting users  from UseCase");
  //   return await _repository.getUsers();
  // }

  // Future<void> addUser(User user) async => await _repository.addUser(user);

  // Future<void> updateUser(User user) async =>
  //     await _repository.updateUser(user);

  // deleteUser(int id) async => await _repository.deleteUser(id);

  // simulateProcess() async => await _repository.simulateProcess();
}
