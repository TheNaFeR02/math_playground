import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:math_playground/ui/controller/user_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    userController.getUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfilePage: User Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('Username: ${userController.user.username}')),
            Obx(() => Text('Email: ${userController.user.email}')),
            Obx(() => Text('Level: ${userController.user.operationLevel}')),
          ],
        ),
      ),
    );
  }
}
