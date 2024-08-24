import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../widgets/pdf_format.dart';

class ReportPreview extends StatelessWidget {
  const ReportPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal[200],
        title: const Text(
          'Vista Previa',
          style: TextStyle(color: Colors.teal),
        ),
      ),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }
}
