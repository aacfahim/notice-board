import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/api_url.dart';

class AuthRepo {
  static Future<void> localLogin() async {
    String loginUrl = BASE_URL + AUTH_LOGIN;
    var client = http.Client();

    try {
      var response = await client.post(Uri.parse(loginUrl), body: {
        "identifier": "rab.marjan@gmail.com",
        "password": "12345678aA",
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        String token = await data["jwt"];
        await _saveTokenToSharedPreferences(token);

        print("login data: " + jsonEncode(data));
      } else {
        print("login data: " +
            response.statusCode.toString() +
            " " +
            response.body);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      client.close();
    }
  }

  static Future<void> _saveTokenToSharedPreferences(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
