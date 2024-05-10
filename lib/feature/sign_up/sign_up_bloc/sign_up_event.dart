part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {
 const SignUpEvent();
}

class SignUpRequired extends SignUpEvent {
  final String employeeId;
  final String password;
  final String name;
  final String surname;

  const SignUpRequired({
    required this.employeeId,
    required this.password,
    required this.name,
    required this.surname,
  });
}
