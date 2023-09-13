class User {
  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email, 
    required this.firstTime,
  });

  int? id;
  String firstName;
  String lastName;
  String email;
  bool firstTime;

  String get name => '$firstName $lastName';

  String get emailAddress => email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"] ?? "somefirstName",
        lastName: json["lastName"] ?? "someLastName",
        email: json["email"] ?? "someemail",
        firstTime: json["firstTime"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "firstTime": firstTime,
      };

  // toString
  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, email: $email, firstTime: $firstTime}';
  }
}
