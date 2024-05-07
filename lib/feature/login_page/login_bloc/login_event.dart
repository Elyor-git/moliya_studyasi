part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {
  const LoginEvent();
}

class LogInRequired extends LoginEvent {
  final String employeeId;
  final String password;

  const LogInRequired({
    required this.employeeId,
    required this.password,
  });
}
