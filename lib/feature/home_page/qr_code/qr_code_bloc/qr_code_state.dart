part of 'qr_code_bloc.dart';

@immutable
sealed class QrCodeState {}

final class QrCodeInitial extends QrCodeState {}

final class QrCodeLoadingState extends QrCodeState {}


final class QrCodeSuccessState extends QrCodeState {}

final class QrCodeFailedState extends QrCodeState {
  final String? message;
   QrCodeFailedState({this.message});
}
