import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:math_playground/ui/controller/math_controller.dart';
import 'package:math_playground/ui/controller/user_controller.dart';

class ProblemsPage extends StatefulWidget {
  const ProblemsPage({super.key, required this.operationSession});

  final String operationSession;

  @override
  State<ProblemsPage> createState() => _ProblemsPageState();
}

class _ProblemsPageState extends State<ProblemsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialize();
    });
  }

  Future<void> initialize() async {
    // Obtain the latest information about the level of the user.
    // UserController userController = Get.find();
    // await userController.getUserLocalInfo();

    // Start the session. (It starts the session knowing the last level of the user.)
    MathController mathController = Get.find();
    await mathController.startSession(widget.operationSession);
  }

  @override
  Widget build(BuildContext context) {
    MathController mathController = Get.find();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Obx(() => Text(
            '${mathController.score}/6 | Session: ${mathController.session} | Time: ${mathController.time} | LevelAdd:')),
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
                      mathController.operation,
                      style: const TextStyle(fontSize: 48.0),
                    )),
                Text(
                  input,
                  style: const TextStyle(
                      fontSize: 32.0, fontWeight: FontWeight.bold),
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
        mathController.checkAnswer(
          input,
        );
        input = '';
      } else {
        // Concatenate the input when a number or operator button is pressed
        input += buttonText;
      }
    });
  }
}
