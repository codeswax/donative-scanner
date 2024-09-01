import 'package:donative_scanner/models/report.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../utils/color_constants.dart';
import '../widgets/pdf_format.dart';

class ReportPreview extends StatelessWidget {
  final Report report;
  const ReportPreview({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: lightTeal,
        title: const Text(
          'Vista Previa',
          style:
              TextStyle(color: teal, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: PdfPreview(
        build: (context) => makePdf(report),
      ),
    );
  }
}
