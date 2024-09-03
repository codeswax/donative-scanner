import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:donative_scanner/models/campaign.dart';

class CampaignService {
  static const String baseUrl = 'http://localhost:5000/campaign/';

  static getCampaings() async {
    List<Campaign> campaigns = [];
    try {
      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        data.forEach((value) => {
              campaigns.add(
                Campaign(
                  value['id'],
                  value['current'],
                  value['description'],
                  value['name'],
                  value['objective'],
                ),
              )
            });
        return campaigns;
      } else {
        return [];
      }
    } catch (e) {
      return e.toString();
    }
  }

  static deleteCampaign(int id) async {
    try {
      final res = await http.delete(Uri.parse("${baseUrl}delete/$id"));
      if (res.statusCode == 200) {
        return "Campaign deleted successfully";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static postCampaign(String id, String name, String description, int objective) async {
    try {
      final res = await http.post(Uri.parse("${baseUrl}new/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode({
          "id": id,
          "content":{
            "current":0,
            "description": description,
            "name": name,
            "objective": objective,
          }
        }));
      if (res.statusCode == 200) {
        return "Campaign creada successfully";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static updateCampaignField(String id, String value, String campo) async {
    try {
      final body = jsonEncode({campo: value});
      final res = await http.put(Uri.parse("${baseUrl}update/$id"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body);
      if (res.statusCode == 200) {
        return "field updated successfully";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static updateCampaign(String id, String name, String description) async {
    try {
      final body = jsonEncode({'name': name, 'description': description});
      final res = await http.put(Uri.parse("${baseUrl}update/$id"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body);
      if (res.statusCode == 200) {
        return "name and description updated successfully";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
