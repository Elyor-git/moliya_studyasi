import 'package:bloc/bloc.dart';
import '../app_reposetory/app_repository.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository appRepository;

  AppBloc({required this.appRepository}) : super(AppInitial()) {
    on<AppCheckEvent>(_onAppCheck);
  }

  Future<void> _onAppCheck(AppCheckEvent event, Emitter<AppState> emit) async {
    emit(AppLoadingState());
    try {
      final userExists = await appRepository.checkUserInFireStore();
      if (userExists) {
        emit(AppUserFoundState());
      } else {
        emit(AppUserNotFoundState());
      }
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }
}
