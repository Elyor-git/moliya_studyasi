import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../common/style/app_colors.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key});

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final ValueNotifier<bool> _flashOn = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    foregroundColor: MaterialStatePropertyAll(AppColors.white),
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
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    double scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 350.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 40,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
