import 'dart:convert';

import 'package:notice_board/features/home/model/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/api_url.dart';

class CategoryServices {
  static Future<List<CategoryModel>> fetchCategory() async {
    String categoryUrl = BASE_URL + CATEGORIES;
    var client = http.Client();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await client.get(Uri.parse(categoryUrl), headers: {
        "jwt": "bearer ${prefs.getString("token")}",
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);

        print("category data: " + jsonEncode(data));
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
