import 'package:math_playground/ui/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_playground/ui/pages/content/problems_page.dart';
import 'package:math_playground/ui/pages/content/profile_page.dart';

import 'pages/authentication/login_page.dart';
import 'pages/content/user_list_page.dart';
import 'pages/content/entry_level_page.dart';

class Central extends StatelessWidget {
  const Central({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController authenticationController = Get.find();
    return Obx(() {
      if (authenticationController.isLogged) {
        // if (authenticationController.isFirstTime) {
        //   return const EntryLevelPage(); // Show EntryLevel page for the first-time user.
        // } else {
        //   return const ProblemsPage(); // Show ProblemsPage for returning users.
        // }
        return const ProblemsPage(); // Show ProblemsPage for returning users.
        // return const ProfilePage();
      } else {
        return const LoginPage(); // Show LoginPage for not logged in users.
      }
    });
  }
}
