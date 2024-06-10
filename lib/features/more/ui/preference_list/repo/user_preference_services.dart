import 'dart:convert';
import 'dart:io';

import 'package:notice_board/features/more/ui/preference_list/model/preference_model.dart';
import 'package:notice_board/utils/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserPreferenceServices {
  static Future<List<UserPreferenceDataModel>> fetchUserPreferenceList() async {
    String noticeUrl = BASE_URL + USER_PREFERENCE;
    var client = http.Client();
    List<UserPreferenceDataModel> preferences = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await client.get(Uri.parse(noticeUrl), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}"
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);

        for (var i in data['data']) {
          preferences.add(UserPreferenceDataModel.fromJson(i));
        }

        preferences.sort((a, b) {
          DateTime dateA = DateTime.parse(a.attributes!.createdAt!);
          DateTime dateB = DateTime.parse(b.attributes!.createdAt!);
          return dateB.compareTo(dateA); // For descending order
        });

        print("pref data: " + jsonEncode(data));

        return preferences;
      } else {
        print("pref data: " +
            response.statusCode.toString() +
            " " +
            response.body);
      }
    } catch (e) {
      print("exception during pref fetch: " + e.toString());
    } finally {
      client.close();
    }

    return [];
  }

  static Future<void> removeUserPreferenceById(int id) async {
    String noticeUrl = BASE_URL + USER_PREFERENCE_DELETE_BY_ID + "/$id";
    var client = http.Client();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await client.delete(Uri.parse(noticeUrl), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}"
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);

        print("pref deletion data: " + jsonEncode(data));
      } else {
        print("pref deletion data: " +
            response.statusCode.toString() +
            " " +
            response.body);
      }
    } catch (e) {
      print("exception during pref deletion: " + e.toString());
    } finally {
      client.close();
    }
  }
}
