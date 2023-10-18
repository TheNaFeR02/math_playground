import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:math_playground/domain/models/operation_level.dart';
import 'package:math_playground/ui/controller/math_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/user.dart';
import '../../domain/use_case/user_usecase.dart';

class UserController extends GetxController {
  // final RxList<User> _users = <User>[].obs;
  Rx<User> _user = User(username: '', email: '', operationLevel: []).obs;
  final UserUseCase userUseCase = Get.find();

  // List<User> get users => _users;
  User get user => _user.value;
  //setter for user

  Future<void> getUser() async {
    logInfo("Getting User Details");
    final userData = await userUseCase.getUser();
    _user.value = userData;
    logInfo("User Details: ${_user.value}");
    update();
  }

  Future<void> updateUserLevel(
      int newLevel, String username, String operationSession) async {
    logInfo("Updating User Level");
    SharedPreferences userInfo = await SharedPreferences.getInstance();
    List<OperationLevel> userOperationList = _user.value.operationLevel;
    for (var element in userOperationList) {
      if (element.name == operationSession) {
        userInfo.setInt(element.name, newLevel);
      }
    }
    await userUseCase.updateUserLevel(newLevel, username);
    await getUserLocalInfo();
  }

  Future<void> setUserLocalInfo() async {
    logInfo("Setting User Local Info");
    SharedPreferences userInfo = await SharedPreferences.getInstance();
    userInfo.setString('username', _user.value.username);
    userInfo.setString('email', _user.value.email);
    userInfo.setBool('firstTimeUser', false);
    for (var element in _user.value.operationLevel) {
      userInfo.setInt(element.name, element.level);
    }
  }

  Future<void> getUserLocalInfo() async {
    SharedPreferences userInfo = await SharedPreferences.getInstance();
    final String username = userInfo.getString('username') ?? '';
    final String email = userInfo.getString('email') ?? '';
    final int additionLevel = userInfo.getInt('addition') ?? 1;
    final int subtractionLevel = userInfo.getInt('subtraction') ?? 1;
    final int multiplicationLevel = userInfo.getInt('multiplication') ?? 1;
    final int divisionLevel = userInfo.getInt('division') ?? 1;
    final List<OperationLevel> operationLevelList = [
      OperationLevel(name: 'addition', level: additionLevel),
      OperationLevel(name: 'subtraction', level: subtractionLevel),
      OperationLevel(name: 'multiplication', level: multiplicationLevel),
      OperationLevel(name: 'division', level: divisionLevel)
    ];

    // _user.value.username = username;
    // _user.value.email = email;
    _user.value.operationLevel = operationLevelList;

    update();
  }

  Future<void> updateAllUserInfoInAPI() async {
    SharedPreferences userInfo = await SharedPreferences.getInstance();
    final String username = userInfo.getString('username') ?? '';
    final int additionLevel = userInfo.getInt('addition') ?? 1;
    final int subtractionLevel = userInfo.getInt('subtraction') ?? 1;
    final int multiplicationLevel = userInfo.getInt('multiplication') ?? 1;
    final int divisionLevel = userInfo.getInt('division') ?? 1;

    await userUseCase.updateAllUserInfoInAPI(username, additionLevel,
        subtractionLevel, multiplicationLevel, divisionLevel);
  }

  Future<void> updateStudentInfo(String school, String grade, String datebirth) async {
    await userUseCase.updateStudentInfo(user.username, school, grade, datebirth);
  }

  Future<void> updateUserSessionInfoInAPI() async {
    await userUseCase.updateUserSessionInfoInAPI(user.username);
  }

  
}
