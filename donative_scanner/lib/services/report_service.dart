import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:donative_scanner/models/report.dart';

class ReportService {
  //localhost
  static const String baseUrl = 'http://127.0.0.1:5000/report/';

  static getReports() async {
    List<Report> reports = [];
    try {
      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        data.forEach((value) => {
              reports.add(
                Report(
                  value['id'],
                  value['reportDate'],
                  value['donatives'],
                ),
              )
            });
        return reports;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static deleteReports(int id) async {
    try {
      final res = await http.delete(Uri.parse("${baseUrl}delete/${id}"));
      if (res.statusCode == 200) {
        return "Report deleted successfully";
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
