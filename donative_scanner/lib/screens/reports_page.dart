import 'package:donative_scanner/screens/report_preview.dart';
import 'package:flutter/material.dart';
import 'package:donative_scanner/models/report.dart';
import 'package:donative_scanner/services/report_service.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  //late Future<List<dynamic>> _futureReports;
  List<dynamic> reports = [
    {
      "Campaña": "Prueba",
      "ID": 1,
      "Fecha": "12/10/2024",
      "Donativos": [1, 2]
    },
    {
      "Campaña": "Gotitas del Saber",
      "ID": 1,
      "Fecha": "12/10/2024",
      "Donativos": [1, 2]
    },
    {
      "Campaña": "Ballenita",
      "ID": 1,
      "Fecha": "12/10/2024",
      "Donativos": [1, 2, 5, 9]
    },
    {
      "Campaña": "Teleton",
      "ID": 1,
      "Fecha": "12/10/2024",
      "Donativos": [1, 2, 3]
    },
    {
      "Campaña": "Test",
      "ID": 1,
      "Fecha": "12/10/2024",
      "Donativos": [1]
    },
  ];
  @override
  void initState() {
    super.initState();
    //_futureReports = ReportService().fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: reports.length,
        itemBuilder: (context, index) {
          return reportContainer(
              reports[index]["Campaña"],
              reports[index]["ID"],
              reports[index]["Fecha"],
              reports[index]["Donativos"].length);
        },
      ),
    );
  }

  Widget reportContainer(String campaign, int id, String date, int quantity) {
    return Container(
      width: 310,
      height: 110,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.teal[200],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            Icons.description_outlined,
            color: Colors.teal,
            size: 50.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Campaña: $campaign',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'ID: $id',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Fecha de Reporte: $date',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Cantidad de donativos: $quantity',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                child: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                  size: 25.0,
                ),
              ),
              GestureDetector(
                  child: const Icon(
                    Icons.remove_red_eye_sharp,
                    color: Colors.blue,
                    size: 25.0,
                  ),
                  onTap: () {
                    goToSelectedReport();
                  }),
            ],
          )
        ],
      ),
    );
  }

  void goToSelectedReport() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ReportPreview(),
      ),
    );
  }
}
