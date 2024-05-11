import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moliya_studyasi/feature/home_page/qr_code/qr_code_bloc/qr_code_bloc.dart';
import 'package:moliya_studyasi/feature/home_page/qr_code/qr_code_repository/qr_code_repository.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../common/style/app_colors.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key});

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late final QrCodeBloc bloc;

  final ValueNotifier<bool> _flashOn = ValueNotifier(false);

  @override
  void initState() {
    bloc = QrCodeBloc(qrCodeRepository: QRCodeRepository());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    controller?.dispose();
    super.dispose();
  }

  bool _changeColor = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QrCodeBloc>(
      create: (context) => bloc,
      child: BlocListener<QrCodeBloc, QrCodeState>(
        bloc: bloc,
        listener: (_, state) {
          if (state is QrCodeSuccessState) {
            setState(() {
              _changeColor = false;
            });
            Navigator.pop(context);
          } else if (state is QrCodeFailedState) {
           setState(() {
             _changeColor = true;
           });
          }

        },
        child: Stack(
          children: [
            _buildQrView(context),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStatePropertyAll(AppColors.white),
                      ),
                      onPressed: () {
                        controller?.stopCamera();
                        Navigator.pop(context);
                      },
                    ),
                    ValueListenableBuilder(
                        valueListenable: _flashOn,
                        builder: (context, value, child) {
                          return IconButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll(AppColors.white),
                            ),
                            onPressed: () async {
                              await controller?.toggleFlash();
                              _flashOn.value = !_flashOn.value;
                            },
                            icon: value
                                ? const Icon(Icons.flash_off)
                                : const Icon(Icons.flash_on),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 350.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: _changeColor ? AppColors.red : AppColors.blue,
          borderRadius: 10,
          borderLength: 40,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
     _changeColor ?   controller.resumeCamera() : controller.pauseCamera();
      if (result?.code != null) {
        bloc.add(QrCodeRequired(barcodeRes: result!.code!));
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
