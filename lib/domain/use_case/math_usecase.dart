import 'dart:math';

import 'package:math_playground/domain/models/operation_level.dart';

class MathUseCase {
  int add(int a, int b) => a + b;
  int subtract(int a, int b) => a - b;
  int multiply(int a, int b) => a * b;
  double divide(int a, int b) => a / b;

  MathUseCase();

  List<String> startSession(List<OperationLevel> opLevel) {
    // check if opLevel is empty
    if (opLevel.isNotEmpty) {
      final String operation = opLevel[0].name;
      final int level = opLevel[0].level;
      switch (operation) {
        case 'addition':
          return createAdditionQuestions(level);
          break;
        case 'subtraction':
          print('subtraction');
          return [];
          break;
        case 'multiplication':
          print('multiplication');
          return [];
          break;
        case 'division':
          print('division');
          return [];
          break;
        default:
          print('default');
          return [];
      }
    }
    return [];
  }

  List<String> createAdditionQuestions(int operationLevel) {
    final Random random = Random();
    List<String> questions = [];

    for (int i = 0; i < 6; i++) {
      int num1;
      int num2;

      if (operationLevel == 1) {
        // Addition with one-digit numbers (0-9)
        num1 = random.nextInt(10);
        num2 = random.nextInt(10);
      } else if (operationLevel == 2) {
        // Addition with two-digit numbers (10-99)
        num1 = random.nextInt(90) + 10;
        num2 = random.nextInt(90) + 10;
      } else if (operationLevel == 3) {
        // Addition with three-digit numbers (100-999)
        num1 = random.nextInt(900) + 100;
        num2 = random.nextInt(900) + 100;
      } else {
        throw ArgumentError('Invalid operationLevel');
      }

      questions.add('$num1 + $num2');
    }

    return questions;
  }

  bool checkAnswer(String input, String operation) {
    print("input: $input");
    print("operation: $operation");
    try {
      // Split the operation into operands and operator
      final parts = operation
          .split(' '); // Assuming there's a space between operands and operator

      if (parts.length != 3) {
        // Invalid operation format
        return false;
      }

      final num1 =
          double.parse(parts[0]); // Parse the first operand as a double
      final operator = parts[1]; // Get the operator as a string
      final num2 =
          double.parse(parts[2]); // Parse the second operand as a double

      double result;

      // Perform the operation based on the operator
      switch (operator) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '*':
          result = num1 * num2;
          break;
        case '/':
          result = num1 / num2;
          break;
        default:
          // Invalid operator
          return false;
      }

      double inputAnswer = double.parse(input);
      return result == inputAnswer;
    } catch (e) {
      // Error occurred while parsing or calculating
      return false;
    }
  }

  // did levelup?
  int checkPerformance(int score, int questions) {
    final double percentage = score / questions;
    if (percentage >= 0.8) {
      // Level up
      return 1;
    } else if (percentage <= 0.2) {
      // Level down
      return -1;
    } else {
      // Stay at the same level
      return 0;
    }
  }
}
