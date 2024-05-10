
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moliya_studyasi/feature/sign_up/sign_up_repository/sign_up_repository.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  late final SignUpRepository signUpRepository;

  SignUpBloc({required this.signUpRepository}) : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpLoadingState());
      try {
        await signUpRepository.signUpUser(
          employeeId: event.employeeId,
          password: event.password,
          name: event.name,
          surname: event.surname,
        );
        emit(SignUpSuccessState());
      } catch (e) {
        emit(const SignUpFailureState());
      }
    });
  }
}
