part of 'qr_code_bloc.dart';

@immutable
sealed class QrCodeEvent {
 const QrCodeEvent();
}

class QrCodeRequired extends QrCodeEvent {
  final String barcodeRes;

const  QrCodeRequired({required this.barcodeRes});
}
