import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class CategoryService {
  static const String baseUrl = 'http://127.0.0.1:5000/category/';

  static postDonatives(Map data) async {
    try {
      final res = await http.post(
        Uri.parse("${baseUrl}new"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode([data]),
      );
      if (res.statusCode == 200) {
      } else {}
    } catch (e) {
      throw Exception(e);
    }
  }

  static getCategory() async {
    List<Category> categories = [];
    try {
      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        data.forEach((value) => {
              categories.add(
                  Category(value['id'], value['name'], value['description']))
            });
        return categories;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static deleteCategory(String id) async {
    try {
      final res = await http.delete(Uri.parse("${baseUrl}delete/$id"));
      if (res.statusCode == 200) {
        return "Report deleted successfully";
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
