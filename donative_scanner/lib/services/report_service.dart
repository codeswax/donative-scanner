import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:donative_scanner/models/report.dart';

class ReportService {
  static const String baseUrl = 'http://ip:5000/report/';

  Future<List<dynamic>> fetchReports() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body;
    } else {
      throw Exception('Failed to load reports');
    }
  }
}
