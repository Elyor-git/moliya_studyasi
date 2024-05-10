part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {
 const SignUpState();
}

final class SignUpInitial extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState{}

class SignUpFailureState extends SignUpState{
  final String? error;
   const SignUpFailureState({this.error});
}