import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:math_playground/domain/models/operation_level.dart';

class User {
  User({
    this.id,
    required this.username,
    required this.email,
    required this.operationLevel,
    this.firstName,
    this.lastName,
  });

  int? id;
  String username; // Make username a reactive variable
  String email; // Make email a reactive variable
  List<OperationLevel> operationLevel;
  String? firstName;
  String? lastName;

  String get name => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        operationLevel: json["operation_level"] ?? '',
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "username": username,
        "email": email,
        "operation_level": operationLevel,
        "firstName": firstName,
        "lastName": lastName,
      };

  // toString
  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, level: $operationLevel, firstName: $firstName, lastName: $lastName}';
  }
}
