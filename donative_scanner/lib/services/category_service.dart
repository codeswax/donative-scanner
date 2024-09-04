import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class CategoryService {
  static const String baseUrl = 'http://127.0.0.1:5000/category/';

  static postCategory(String id, String name, String description, List<dynamic> guiaProductos) async {
    try {
      final res = await http.post(Uri.parse("${baseUrl}new/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode({
          "id": id,
          "content":{
            "description": description,
            "name": name,
            "guideProducts": guiaProductos,
          }
        }));
      if (res.statusCode == 200) {
        return "Category create successfully";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static getCategories() async {
    List<Category> categories = [];
    try {
      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        data.forEach((value) => {
              categories.add(
                  Category(value['id'], value['name'], value['description'], value['guideProducts']))
            });
        print(categories);
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
