import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../todays_status_repository/todays_status_repository.dart';

part 'today_status_event.dart';

part 'today_status_state.dart';

class TodayStatusBloc extends Bloc<TodayStatusEvent, TodayStatusState> {
  final TodayStatusRepository repository;

  TodayStatusBloc({required this.repository}) : super(TodayStatusInitial()) {
    on<TodayStatus>((event, emit) async {
      emit(TodayLoadingState());
      try {
        (String, String) info = await repository.todayInfo();

        emit(TodayLoadedState(checkIn: info.$1, checkOut: info.$2));
      } catch (e) {
        emit(TodayErrorState());
      }
    });
  }
}
