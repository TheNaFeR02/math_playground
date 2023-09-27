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
    print("This is the TOKEN ----->${token}");
    User user = User(username: '', email: '', operationLevel: []);
    final response = await http.get(
      Uri.parse("$baseUrl/user"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token'
      },
    );

    print("Antes de tomar los details------${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final userData = data[0];
        print(userData);
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
        print("Se realizó bien la petición de getUser()--------------> $user");
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

  Future<void> updateUserLevel(String baseUrl, String token, int newLevel,
      int userId, String operationSession) async {
    // User user = User(username: '', email: '', operationLevel: []);
    // print("operacion de la $sesionoperationSession");
    print("put:$operationSession");
    final response = await http.put(
        Uri.parse("$baseUrl/operation_level/$operationSession/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(
            {"name": operationSession, "level": newLevel, "user": "fernando"}));

    // Check the response status code
    if (response.statusCode == 200) {
      print('Operation level updated successfully');
    } else {
      print('Error updating operation level: ${response.statusCode}');
      print('Response body: ${response.body}');
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
