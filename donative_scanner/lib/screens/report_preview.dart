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
        backgroundColor: Colors.teal,
        title: Text(
          'Vista Previa',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }
}
