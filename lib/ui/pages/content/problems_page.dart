import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:math_playground/ui/controller/math_controller.dart';
import 'package:math_playground/ui/controller/user_controller.dart';

class ProblemsPage extends StatefulWidget {
  const ProblemsPage({super.key});

  @override
  State<ProblemsPage> createState() => _ProblemsPageState();
}

class _ProblemsPageState extends State<ProblemsPage> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    await getInfo(); // Wait for user data to be fetched
    MathController mathController = Get.find();
    mathController.startSession();
  }

  Future<void> getInfo() async {
    UserController userController = Get.find();
    await userController.getUser(); // Wait for user data to be fetched
  }

  @override
  Widget build(BuildContext context) {
    MathController mathController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('${mathController.score}/6')),
      ),
      // One centered colum Widget with 3 rows,
      body: const Center(
        child: CalculatorWidget(),
      ),
    );
  }
}

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  // set response(int value) {
  //   setState(() {
  //     response = value;
  //   });
  // }
  String input = '';
  MathController mathController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 400.0,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Obx(() => Text(
                      '${mathController.operation}',
                      style: TextStyle(fontSize: 48.0),
                    )),
                Text(
                  '$input',
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                final buttonText = index < 9
                    ? '${index + 1}'
                    : index == 9
                        ? '0'
                        : index == 10
                            ? 'C'
                            : '=';
                return ElevatedButton(
                  onPressed: () {
                    handleButtonClick(buttonText);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    textStyle: const TextStyle(fontSize: 24.0),
                  ),
                  child: Text(buttonText),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleButtonClick(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        // Handle the 'C' (Clear) button press
        input = ''; // Clear the input
      } else if (buttonText == '=') {
        // Handle the '=' button press
        // You can implement logic here to evaluate the expression and update the response accordingly.
        mathController.checkAnswer(input);
      } else {
        // Concatenate the input when a number or operator button is pressed
        input += buttonText;
      }
    });
  }
}
