import 'package:donative_scanner/screens/report_preview.dart';
import 'package:donative_scanner/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:donative_scanner/models/report.dart';
import 'package:donative_scanner/services/report_service.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ReportService.getReports(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(color: white));
        } else {
          List<Report> data = snapshot.data;
          return Container(
            margin: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyForm(),
                SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if (data.length == 1) {
                      return const Text(
                        "No hay reportes creados aún. Aquí aparecerán tus reportes generados.",
                        style: TextStyle(color: white),
                      );
                    } else {
                      return reportContainer(data[index]);
                    }
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget reportContainer(Report report) {
    return Container(
      width: 310,
      height: 110,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.teal[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            Icons.description_outlined,
            color: teal,
            size: 50.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Campaña: ${report.id}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'ID: ${report.id}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Fecha de Reporte: ${report.reportDate}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Cantidad de donativos: ${report.donatives.length}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                child: Icon(
                  Icons.delete_forever,
                  color: red,
                  size: 25.0,
                ),
                onTap: () {
                  showDeletionDialog(report);
                },
              ),
              GestureDetector(
                  child: const Icon(
                    Icons.remove_red_eye_sharp,
                    color: teal,
                    size: 25.0,
                  ),
                  onTap: () {
                    goToSelectedReport(report);
                  }),
            ],
          )
        ],
      ),
    );
  }

  void goToSelectedReport(Report report) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportPreview(
          report: report,
        ),
      ),
    );
  }

  void showDeletionDialog(Report report) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Atención',
                  style: Theme.of(context).textTheme.bodyMedium),
              content: Text(
                'El report ${report.id} será eliminado. Esto no se puede deshacer.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: teal),
                  onPressed: () {
                    ReportService.deleteReports(int.parse(report.id));
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: Text(
                    'Aceptar',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancelar',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ]);
        });
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController dateController = TextEditingController();
  String? selectedOption;

  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedOption,
            items: options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedOption = newValue;
              });
            },
            decoration: const InputDecoration(labelText: 'Elegir campaña'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: dateController,
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                dateController.text =
                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
              }
            },
            decoration: const InputDecoration(
              labelText: 'Elegir fecha',
            ),
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.add_box,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
