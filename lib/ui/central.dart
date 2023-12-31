import 'package:math_playground/domain/models/user.dart';
import 'package:math_playground/ui/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_playground/ui/controller/user_controller.dart';
import 'package:math_playground/ui/menu.dart';
import 'package:math_playground/ui/pages/content/introductory_form.dart';
import 'package:math_playground/ui/pages/content/operation_list.dart';
import 'package:math_playground/ui/pages/content/problems_page.dart';
import 'package:math_playground/ui/pages/content/profile_page.dart';
import 'pages/authentication/login_page.dart';

class Central extends StatelessWidget {
  const Central({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController authenticationController = Get.find();
    UserController userController = Get.find();
    
    return Obx(() {
      if (authenticationController.isLogged) {
        
        // return const ProblemsPage(); // Show ProblemsPage for returning users.
        // return const ProfilePage();
        if (userController.user.firstTimeUser == true) {
          return const IntroductoryForm();
        } else {
          return const SelectOperation();
        }
      } else {
        return const LoginPage(); // Show LoginPage for not logged in users.
      }
    });
  }
}
