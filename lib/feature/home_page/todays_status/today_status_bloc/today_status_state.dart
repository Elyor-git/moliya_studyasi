part of 'today_status_bloc.dart';

sealed class TodayStatusState extends Equatable {
  const TodayStatusState();
}

final class TodayStatusInitial extends TodayStatusState {
  @override
  List<Object> get props => [];
}

final class TodayLoadingState extends TodayStatusState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class TodayLoadedState extends TodayStatusState {
  final  String checkIn;
 final  String checkOut;
 const TodayLoadedState({required this.checkIn, required this.checkOut});
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class TodayErrorState extends TodayStatusState {
  @override

  List<Object?> get props => throw UnimplementedError();
}