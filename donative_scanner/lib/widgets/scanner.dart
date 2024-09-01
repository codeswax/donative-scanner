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
      width: 250,
      height: 250,
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
        // validateQR(result!.code!);
        controller.pauseCamera();
        showResultDialog(result!.code!);
      });
    });
  }

  void showResultDialog(String code) {
    List<String> stuff = code.split(',');
    String idk = stuff.join("\n");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Donativo identificado',
              style: Theme.of(context).textTheme.bodyMedium),
          content: Text(
            'Datos: $idk',
            style: Theme.of(context).textTheme.bodySmall,
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
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: teal),
              onPressed: () async {
                Navigator.of(context).pop();
                controller!.resumeCamera();
              },
              child: Text('Registrar',
                  style: Theme.of(context).textTheme.labelMedium),
            ),
            // TextButton(
            //   style: TextButton.styleFrom(
            //       backgroundColor: Theme.of(context).primaryColor),
            //   onPressed: () async {
            //     Navigator.of(context).pop();
            //     controller!.resumeCamera();
            //     var completeItemName = "BATERIA $modelName $modelCode";
            //     var r = await receiptsList;
            //     var matchingReceipt = r.firstWhere(
            //       (receipt) => receipt.itemName == completeItemName,
            //     );
            //     final userData = await secureStorageService.loadUserData();
            //     String user = userData['username']!.toString();
            //     String token = userData['token']!.toString();
            //     SerialAssignmentData serialAssignmentData =
            //         SerialAssignmentData(code, user, matchingReceipt);
            //     try {
            //       String message =
            //           await apiClient.assignSerial(token, serialAssignmentData);

            //       DataStorage().assignedReceipts.add(serialAssignmentData);

            //       dialogService.showCompletionDialog(context, message);
            //     } on GeneralException catch (e) {
            //       dialogService.showExceptionDialog(context, e.message);
            //     }
            //   },
            //   child: Text('Registrar',
            //       style: Theme.of(context).textTheme.labelSmall),
            // ),
          ],
        );
      },
    );
  }

  // void validateQR(String code) {
  //   try {
  //     validationService.checkQR(code);
  //     showResultDialog(code);
  //   } on InvalidQRException catch (e) {
  //     dialogService.showExceptionDialog(context, e.message);
  //   } on GeneralException catch (e) {
  //     dialogService.showExceptionDialog(context, e.message);
  //   }
  // }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
