import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/donative.dart';

class DonativeService {
  static const String baseUrl = 'http://localhost:5000/donative/';
  static getDonatives() async {
    List<Donative> donatives = [];
    try {
      final res = await http.get(Uri.parse(baseUrl));

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        data.forEach((value) => {
              donatives.add(
                Donative(
                    value['id'],
                    value['brand'],
                    value['description'],
                    /*value['category']*/
                    value['quantity']),
              )
            });
        return donatives;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static deleteDonatives(int id) async {
    try {
      final res = await http.delete(Uri.parse("${baseUrl}delete/${id}"));
      if (res.statusCode == 200) {
        return "Report deleted successfully";
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static updateDonatives(int? id, int quantity) async {
    try {
      final body = jsonEncode({'quantity': quantity});
      final res = await http.put(Uri.parse("${baseUrl}update/${id}"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body);
      if (res.statusCode == 200) {
        return "Quantity updated successfully";
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
