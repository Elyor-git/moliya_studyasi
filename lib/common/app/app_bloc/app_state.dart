import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class AppLoadingState extends AppState {}

class AppUserFoundState extends AppState {}

class AppUserNotFoundState extends AppState {}

class AppErrorState extends AppState {
  final String message;

  const AppErrorState(this.message);

  @override
  List<Object> get props => [message];
}
