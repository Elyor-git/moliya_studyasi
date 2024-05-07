part of 'login_bloc.dart';

@immutable
sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String? error;
  const LoginFailure({this.error});
}

class LoginProcess extends LoginState {}
