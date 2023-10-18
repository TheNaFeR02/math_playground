import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:math_playground/ui/controller/user_controller.dart';
import 'package:math_playground/ui/pages/content/introductory_form.dart';
import 'package:math_playground/ui/pages/content/operation_list.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // @override
  // void initState() {
  //   super.initState();
  //   initialize();
  // }

  // Future<void> initialize() async {
  //   UserController userController =
  //       Get.find(); // Wait for user data to be fetched
  //   try {
  //     await userController.getUser();
  //     await userController.setUserLocalInfo();
  //   } catch (e) {
  //     logError('Error al Obtener la información del Usuario', e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'MENU',
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (userController.user.firstTimeUser == true) {
                  Get.to(const IntroductoryForm());
                } else {
                  Get.to(const SelectOperation());
                }
              },
              child: const Text('Select Operation'),
            ),
          ],
        ),
      ),
    );
  }
}
