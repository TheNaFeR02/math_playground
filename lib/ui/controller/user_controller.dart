import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:math_playground/ui/controller/math_controller.dart';

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
    update();
  }

  Future<void> updateUserLevel(int newLevel, String username, String operationSession) async{
    logInfo("Updating User Level");
    await userUseCase.updateUserLevel(newLevel, username, operationSession);
    getUser();
  }
}
