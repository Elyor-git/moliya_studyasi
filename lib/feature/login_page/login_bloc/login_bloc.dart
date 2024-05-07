import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../login_repository/login_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<LogInRequired>((event, emit) async {
      emit(LoginProcess());
      try {
        await loginRepository.loginUser(event.employeeId, event.password);
       emit(LoginSuccess());
      }  catch (e) {
        emit(const LoginFailure());
      }
    });
  }
}
