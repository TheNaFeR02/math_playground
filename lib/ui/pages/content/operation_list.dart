import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:math_playground/ui/controller/math_controller.dart';
import 'package:math_playground/ui/controller/user_controller.dart';
import 'package:math_playground/ui/pages/content/card_option.dart';
import 'package:math_playground/ui/pages/content/problems_page.dart';

class SelectOperation extends StatefulWidget {
  const SelectOperation({super.key});

  @override
  State<SelectOperation> createState() => _SelectOperationState();
}

class _SelectOperationState extends State<SelectOperation> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    UserController userController =
        Get.find(); // Wait for user data to be fetched
    try {
      await userController.getUserLocalInfo();
      await userController.updateAllUserInfoInAPI();

      await userController.updateUserSessionInfoInAPI();
    } catch (e) {
      logError('Error al Obtener la información del Usuario', e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Choose an operation')),
        body: const Center(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Spacer(),
                  OperationList(),
                  Spacer(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OperationList extends StatefulWidget {
  const OperationList({super.key});

  @override
  State<OperationList> createState() => _OperationListState();
}

class _OperationListState extends State<OperationList> {
  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Row(children: [
        ElevatedCard(
          operationSession: "addition",
        ),
      ]),
      Row(children: [
        ElevatedCard(
          operationSession: "subtraction",
        ),
      ]),
      Row(children: [
        ElevatedCard(
          operationSession: "multiplication",
        ),
      ]),
      Row(children: [
        ElevatedCard(
          operationSession: "division",
        ),
      ]),
    ]);
  }
}
