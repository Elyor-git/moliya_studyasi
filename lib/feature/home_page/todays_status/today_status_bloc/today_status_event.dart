part of 'today_status_bloc.dart';


sealed class TodayStatusEvent extends Equatable {
  const TodayStatusEvent();
}

class TodayStatus extends TodayStatusEvent {

  @override
  List<Object?> get props => [];

}
