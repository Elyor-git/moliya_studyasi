class MyUser {
  final String name;
  final String surname;
  final String employeeId;
  final String password;
  final String firebaseId;

  const MyUser({
    required this.name,
    required this.surname,
    required this.employeeId,
    required this.password,
    required this.firebaseId,
  });

  factory MyUser.fromJson(Map<String, Object?> json) {
    return MyUser(
      name: json["name"].toString(),
      surname: json["surname"].toString(),
      employeeId: json["id"].toString(),
      password: json["password"].toString(),
      firebaseId: json["firebaseId"].toString(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      "name": name,
      "surname": surname,
      "employeeId": employeeId,
      "password": password,
    };
  }

  MyUser copyWith({
    String? name,
    String? surname,
    String? employeeId,
    String? password,
    String? firebaseId,
  }) {
    return MyUser(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      employeeId: employeeId ?? this.employeeId,
      password: password ?? this.password,
      firebaseId: firebaseId ?? this.firebaseId,
    );
  }
}
