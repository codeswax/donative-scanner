import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart';
import '../models/report.dart';

Future<Uint8List> makePdf(Report report) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/images/image.png')).buffer.asUint8List());
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("REPORTE ${report.id}",
                        style: Theme.of(context).header0),
                    Text("Fecha: ${report.reportDate}",
                        style: Theme.of(context).header1),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(imageLogo),
                )
              ],
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'Producto',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: const EdgeInsets.all(20),
                    ),
                    Padding(
                      child: Text(
                        'Información de Categoría',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: const EdgeInsets.all(20),
                    ),
                    Padding(
                      child: Text(
                        'Cantidad',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: const EdgeInsets.all(20),
                    ),
                  ],
                ),
                ...report.donatives.map(
                  (d) => TableRow(
                    children: [
                      Expanded(
                        child:
                            paddedText('${d['brand']} - ${d['description']}'),
                        flex: 2,
                      ),
                      Expanded(
                        child: paddedText(
                            'Tipo: ${d['category']['name']} - Expira en: ${d['category']['expirationDate']}'),
                        flex: 3,
                      ),
                      Expanded(
                        child: paddedText('${d['quantity']} unidades.'),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(height: 50),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                "Prototipo de Reporte",
                style: Theme.of(context).header3.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget paddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
