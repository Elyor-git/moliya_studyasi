import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppCheckEvent extends AppEvent {}

class AppUserFoundEvent extends AppEvent {}

class AppUserNotFoundEvent extends AppEvent {}
