import 'package:donative_scanner/services/donative_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../utils/color_constants.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({
    super.key,
  });

  @override
  State<QRScanner> createState() => QRScannerState();
}

class QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;
  @override
  void initState() {
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: ClipRect(
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.transparent,
            borderRadius: 40,
            borderLength: 40,
            borderWidth: 10,
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        controller.pauseCamera();
        showResultDialog(result!.code!);
      });
    });
  }

  void showResultDialog(String code) {
    List<String> stuff = code.split('-');
    String brand = stuff[0];
    String content = stuff[1];
    String description = stuff[2];
    String key = stuff[4];
    String message = "$description, marca $brand.";
    var data = {
      "brand": brand,
      "category": {"name": key, "additional": content},
      "description": description,
      "quantity": 0
    };
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Donativo identificado',
          ),
          content: Text(
            message,
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: red),
              onPressed: () {
                Navigator.of(context).pop();
                controller!.resumeCamera();
              },
              child: Text(
                'Cancelar',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: teal),
              onPressed: () async {
                Navigator.of(context).pop();
                controller!.resumeCamera();
                DonativeService.postDonatives(data);
              },
              child: Text(
                'Registrar',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
