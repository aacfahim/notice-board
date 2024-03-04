import 'dart:convert';
import 'dart:io';

import 'package:notice_board/features/home/model/degree_model.dart';
import 'package:notice_board/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PreferredDegree {
  static Future<List<DegreeModel>> fetchDegreeDropdown() async {
    String dropdownUrl = BASE_URL + DEGREE_LENGTH;
    var client = http.Client();
    List<DegreeModel> dropdownList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await client.get(Uri.parse(dropdownUrl), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}"
      });

      print("res " + response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);

        for (var i in data['data']) {
          dropdownList.add(DegreeModel.fromJson(i));
        }

        print("dropdown data: " + jsonEncode(data));

        return dropdownList;
      } else {
        print("dropdown data: " +
            response.statusCode.toString() +
            " " +
            response.body);
      }
    } catch (e) {
      print("exception during dropdown fetch: " + e.toString());
    } finally {
      client.close();
    }

    return [];
  }
}
