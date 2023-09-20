import 'package:math_playground/domain/use_case/math_usecase.dart';
import 'package:math_playground/domain/use_case/user_usecase.dart';
import 'package:math_playground/ui/central.dart';
import 'package:math_playground/ui/controller/authentication_controller.dart';
import 'package:math_playground/ui/controller/math_controller.dart';
import 'package:math_playground/ui/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'domain/repositories/repository.dart';
import 'domain/use_case/authentication_usecase.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  Get.put(Repository());

  Get.put(UserUseCase());
  Get.put(UserController());

  Get.put(MathUseCase());
  Get.put(MathController());
  
  Get.put(AuthenticationUseCase());

  Get.put(AuthenticationController());

  Get.put(MathUseCase());
  Get.put(MathController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Central(),
    );
  }
}
