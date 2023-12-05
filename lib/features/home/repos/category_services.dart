import 'dart:convert';
import 'dart:io';

import 'package:notice_board/features/home/model/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/api_url.dart';

class CategoryServices {
  static Future<List<CategoryDataModel>> fetchCategory() async {
    String categoryUrl = BASE_URL + CATEGORIES;
    var client = http.Client();
    List<CategoryDataModel> categories = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await client.get(Uri.parse(categoryUrl), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}"
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);

        for (var i in data['data']) {
          categories.add(CategoryDataModel.fromJson(i));
        }

        print("category data: " + jsonEncode(data));

        return categories;
      } else {
        print("category data: " +
            response.statusCode.toString() +
            " " +
            response.body);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      client.close();
    }

    return [];
  }
}
