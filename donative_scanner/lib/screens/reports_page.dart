import 'package:flutter/material.dart';
import 'package:donative_scanner/models/report.dart';
import 'package:donative_scanner/services/report_service.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late Future<List<dynamic>> _futureReports;

  @override
  void initState() {
    super.initState();
    _futureReports = ReportService().fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _futureReports,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay reportes disponibles'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final report = snapshot.data![index];
              return ListTile(
                title: Text(report.toString()),
                subtitle: Text(report.toString()),
                onTap: () {},
              );
            },
          );
        }
      },
    );
  }
}
