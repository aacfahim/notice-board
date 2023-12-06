import 'dart:convert';
import 'dart:io';

import 'package:notice_board/features/home/model/notice_tile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utils/api_url.dart';

class NoticeServices {
  static Future<List<NoticeTileDataModel>> fetchNoticeTile() async {
    String categoryUrl = BASE_URL + NOTICES;
    var client = http.Client();
    List<NoticeTileDataModel> notices = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await client.get(Uri.parse(categoryUrl), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}"
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);

        for (var i in data['data']) {
          notices.add(NoticeTileDataModel.fromJson(i));
        }

        print("notice tile data: " + jsonEncode(data));

        return notices;
      } else {
        print("notice tile data: " +
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
