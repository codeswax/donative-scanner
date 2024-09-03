import 'package:donative_scanner/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:donative_scanner/widgets/scanner.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({Key? key, Colors? idk}) : super(key: key);

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Align(
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 20,
          children: [
            const QRScanner(),
            Row(
              children: [
                Icon(
                  Icons.live_help,
                  color: lightTeal,
                  size: 35.0,
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Text(
                    "Mantén fijo el celular para hasta que se capture el código correctamente.",
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
