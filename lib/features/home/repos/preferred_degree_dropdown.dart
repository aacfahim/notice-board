import 'dart:convert';
import 'dart:io';

import 'package:notice_board/features/auth/repos/auth_repo.dart';
import 'package:notice_board/features/home/model/degree_model.dart';
import 'package:notice_board/features/home/model/preference_notifier.dart';
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

  static Future setPreference(PreferenceModel preferenceModel) async {
    String prefUrl = BASE_URL + USER_PREFERENCE;
    AuthRepo authRepo = AuthRepo();
    Future<String?> deviceUniqueId = authRepo.getDeviceId();
    String? deviceId = await deviceUniqueId;

    var client = http.Client();

    // try {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();

    //   Map<String, dynamic> body = {
    //     "data": {
    //       "year": preferenceModel.selectedYear ?? 0,
    //       if (preferenceModel.selectedSemester != null)
    //         "semester": preferenceModel.selectedSemester,
    //       "device_id": deviceId.toString(),
    //       if (preferenceModel.degreeId != null)
    //         "degree": preferenceModel.degreeId,
    //       if (preferenceModel.facultyId != null)
    //         "faculty": preferenceModel.facultyId,
    //       if (preferenceModel.subjectId != null)
    //         "subject": preferenceModel.subjectId
    //     }
    //   };

    //   var response = await client.post(Uri.parse(prefUrl),
    //       headers: {
    //         HttpHeaders.contentTypeHeader: "application/json",
    //         HttpHeaders.authorizationHeader:
    //             "Bearer ${prefs.getString("token")}"
    //       },
    //       body: jsonEncode(body));

    //   print("res " + response.body);

    //   if (response.statusCode == 200 || response.statusCode == 201) {
    //     var data = jsonDecode(response.body);

    //     print("pref data: " + jsonEncode(data));
    //   } else {
    //     print("pred data: " +
    //         response.statusCode.toString() +
    //         " " +
    //         response.body);
    //   }
    // } catch (e) {
    //   print("exception during pref fetch: " + e.toString());
    // } finally {
    //   client.close();
    // }
  }
}
