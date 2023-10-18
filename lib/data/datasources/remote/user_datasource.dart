import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:loggy/loggy.dart';
import 'package:math_playground/domain/models/operation_level.dart';
import '../../../domain/models/user.dart';
import 'package:http/http.dart' as http;

class UserDataSource {
  final String apiKey = 'ZtyTgh';

  // -------------------------------------------------------------------------

  Future<User> getUser(String baseUrl, String token) async {
    User user = User(username: '', email: '', operationLevel: []);
    final response = await http.get(
      Uri.parse("$baseUrl/user"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final userData = data[0];
        user.id = userData['id'];
        user.username = userData['username'];
        user.email = userData['email'];
        final operationList = userData['operation_level'];
        for (final operation in operationList) {
          user.operationLevel.add(OperationLevel(
            level: operation['level'],
            name: operation['name'],
          ));
        }
        user.firstName = userData['firstName'];
        user.lastName = userData['lastName'];
        return Future.value(user);
      } else {
        // Handle the case where the response is an empty array
        return Future.error('No data found');
      }
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
  }

  Future<void> updateUserLevel(
      String baseUrl, String token, int newLevel, String username) async {
    // User user = User(username: '', email: '', operationLevel: []);
    // print("operacion de la $sesionoperationSession");

    final additionResponse = await http.put(
        Uri.parse("$baseUrl/operation_level/$username/addition/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(
            {"name": "addition", "level": newLevel, "user": username}));

    // Check the response status code
    if (additionResponse.statusCode == 200) {
      print('Addition updated successfully');
    } else {
      print('Error updating operation level: ${additionResponse.statusCode}');
      print('Response body: ${additionResponse.body}');
    }

    final subtractionResponse = await http.put(
        Uri.parse("$baseUrl/operation_level/$username/subtraction/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(
            {"name": "subtraction", "level": newLevel, "user": username}));

    // Check the response status code
    if (subtractionResponse.statusCode == 200) {
      print('Subtraction updated successfully');
    } else {
      print('Error updating operation level: ${subtractionResponse.statusCode}');
      print('Response body: ${subtractionResponse.body}');
    }

    final multiplicationResponse = await http.put(
        Uri.parse("$baseUrl/operation_level/$username/multiplication/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(
            {"name": "multiplication", "level": newLevel, "user": username}));

    // Check the response status code
    if (multiplicationResponse.statusCode == 200) {
      print('Multiplication updated successfully');
    } else {
      print('Error updating operation level: ${multiplicationResponse.statusCode}');
      print('Response body: ${multiplicationResponse.body}');
    }

    final divisionResponse = await http.put(
        Uri.parse("$baseUrl/operation_level/$username/division/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(
            {"name": "division", "level": newLevel, "user": username}));

    // Check the response status code
    if (divisionResponse.statusCode == 200) {
      print('Division updated successfully');
    } else {
      print('Error updating operation level: ${divisionResponse.statusCode}');
      print('Response body: ${divisionResponse.body}');
    }
  }

  Future<void> updateAllUserInfoInAPI(String baseUrl, String token, String username, int additionLevel, int subtractionLevel, int multiplicationLevel, int divisionLevel) async {
    final additionResponse = await http.put(
        Uri.parse("$baseUrl/operation_level/$username/addition/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(
            {"name": "addition", "level": additionLevel, "user": username}));

    // Check the response status code
    if (additionResponse.statusCode == 200) {
      print('Addition updated successfully');
    } else {
      print('Error updating operation level: ${additionResponse.statusCode}');
      print('Response body: ${additionResponse.body}');
    }

    final subtractionResponse = await http.put(
        Uri.parse("$baseUrl/operation_level/$username/subtraction/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(
            {"name": "subtraction", "level": subtractionLevel, "user": username}));

    // Check the response status code
    if (subtractionResponse.statusCode == 200) {
      print('Subtraction updated successfully');
    } else {
      print('Error updating operation level: ${subtractionResponse.statusCode}');
      print('Response body: ${subtractionResponse.body}');
    }

    final multiplicationResponse = await http.put(
        Uri.parse("$baseUrl/operation_level/$username/multiplication/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(
            {"name": "multiplication", "level": multiplicationLevel, "user": username}));

    // Check the response status code
    if (multiplicationResponse.statusCode == 200) {
      print('Multiplication updated successfully');
    } else {
      print('Error updating operation level: ${multiplicationResponse.statusCode}');
      print('Response body: ${multiplicationResponse.body}');
    }

    final divisionResponse = await http.put(
        Uri.parse("$baseUrl/operation_level/$username/division/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(
            {"name": "division", "level": divisionLevel, "user": username}));

    // Check the response status code
    if (divisionResponse.statusCode == 200) {
      print('Division updated successfully');
    } else {
      print('Error updating operation level: ${divisionResponse.statusCode}');
      print('Response body: ${divisionResponse.body}');
    }
  }

  // -------------------------------------------------------------------------

  // Future<List<User>> getUsers() async {
  //   List<User> users = [];
  //   var request = Uri.parse("https://retoolapi.dev/$apiKey/data")
  //       .resolveUri(Uri(queryParameters: {
  //     "format": 'json',
  //   }));

  //   var response = await http.get(request);

  //   if (response.statusCode == 200) {
  //     //logInfo(response.body);
  //     final data = jsonDecode(response.body);

  //     users = List<User>.from(data.map((x) => User.fromJson(x)));
  //   } else {
  //     logError("Got error code ${response.statusCode}");
  //     return Future.error('Error code ${response.statusCode}');
  //   }

  //   return Future.value(users);
  // }

  // Future<bool> addUser(User user) async {
  //   logInfo("Web service, Adding user");

  //   final response = await http.post(
  //     Uri.parse("https://retoolapi.dev/$apiKey/data"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(user.toJson()),
  //   );

  //   if (response.statusCode == 201) {
  //     //logInfo(response.body);
  //     return Future.value(true);
  //   } else {
  //     logError("Got error code ${response.statusCode}");
  //     return Future.value(false);
  //   }
  // }

  // Future<bool> updateUser(User user) async {
  //   final response = await http.put(
  //     Uri.parse("https://retoolapi.dev/$apiKey/data/${user.id}"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(user.toJson()),
  //   );

  //   if (response.statusCode == 201) {
  //     //logInfo(response.body);
  //     return Future.value(true);
  //   } else {
  //     logError("Got error code ${response.statusCode}");
  //     return Future.value(false);
  //   }
  // }

  // Future<bool> deleteUser(int id) async {
  //   final response = await http.delete(
  //     Uri.parse("https://retoolapi.dev/$apiKey/data/$id"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );

  //   if (response.statusCode == 201) {
  //     //logInfo(response.body);
  //     return Future.value(true);
  //   } else {
  //     logError("Got error code ${response.statusCode}");
  //     return Future.value(false);
  //   }
  // }

  // Future<bool> simulateProcess(String baseUrl, String token) async {
  //   final response = await http.get(
  //     Uri.parse("$baseUrl/me"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer $token'
  //     },
  //   );

  //   logInfo(response.statusCode);
  //   if (response.statusCode == 200) {
  //     logInfo('simulateProcess access ok');
  //     return Future.value(true);
  //   } else {
  //     logError("Got error code ${response.statusCode}");
  //     return Future.error('Error code ${response.statusCode}');
  //   }
  // }

  // Future<bool> checkIsFirstTime() async {
  //   List<User> users = [];
  //   var request = Uri.parse("https://retoolapi.dev/$apiKey/data")
  //       .resolveUri(Uri(queryParameters: {
  //     "format": 'json',
  //   }));

  //   var response = await http.get(request);

  //   if (response.statusCode == 200) {
  //     //logInfo(response.body);
  //     final data = jsonDecode(response.body);

  //     users = List<User>.from(data.map((x) => User.fromJson(x)));
  //     final firstTime = users[1].firstTime;
  //     print(firstTime);
  //     print("usuarios: ${users} ---------------------");
  //     print("El Usuario: ${users[1]} ----------------");
  //     // [UPDATE] call a function to make a POST and change the firstTime to false.
  //     return firstTime ? Future.value(true) : Future.value(false);
  //   } else {
  //     logError("Got error code ${response.statusCode}");
  //     return Future.error('Error code ${response.statusCode}');
  //   }
  // }
}
