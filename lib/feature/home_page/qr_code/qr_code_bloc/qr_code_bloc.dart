import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../qr_code_repository/qr_code_repository.dart';

part 'qr_code_event.dart';

part 'qr_code_state.dart';

class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  final QRCodeRepository qrCodeRepository;

  QrCodeBloc({required this.qrCodeRepository}) : super(QrCodeInitial()) {
    on<QrCodeRequired>((event, emit) async {
      emit(QrCodeLoadingState());
      try {
       await qrCodeRepository.setAndUpdateDateTime(barcodeRes: event.barcodeRes);
        emit(QrCodeSuccessState());
      } catch (e) {
        emit(QrCodeFailedState());
      }
    });
  }
}
