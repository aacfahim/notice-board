import 'dart:convert';
import 'dart:io';

import 'package:notice_board/features/home/model/tutor_model.dart';
import 'package:notice_board/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TutorServices {
  static Future<List<TutorDataModel>> fetchTutorList() async {
    String noticeUrl = BASE_URL + TUTOR_LIST;
    var client = http.Client();
    List<TutorDataModel> tutorList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await client.get(Uri.parse(noticeUrl), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}"
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);

        for (var i in data['data']) {
          tutorList.add(TutorDataModel.fromJson(i));
        }

        tutorList.sort((a, b) {
          int ratingsA = int.parse(a.attributes!.ratings!);
          int ratingsB = int.parse(b.attributes!.ratings!);
          return ratingsB.compareTo(ratingsA); // For descending order
        });

        print("tutor tile data: " + jsonEncode(data));

        return tutorList;
      } else {
        print("tutor tile data: " +
            response.statusCode.toString() +
            " " +
            response.body);
      }
    } catch (e) {
      print("exception during tutor list fetch: " + e.toString());
    } finally {
      client.close();
    }

    return [];
  }
}
