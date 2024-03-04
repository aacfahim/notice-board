import 'dart:convert';
import 'dart:io';

import 'package:notice_board/features/home/model/notice_tile_model.dart';
import 'package:notice_board/features/home/model/preferred_notice_model.dart';
import 'package:notice_board/features/notice_detail/bloc/notice_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utils/api_url.dart';

class NoticeServices {
  static Future<List<NoticeDataModel>> fetchNoticeTile() async {
    NoticeBloc noticeBloc = NoticeBloc();
    String noticeUrl = BASE_URL + NOTICES;
    var client = http.Client();
    List<NoticeDataModel> notices = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await client.get(Uri.parse(noticeUrl), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}"
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);

        for (var i in data['data']) {
          notices.add(NoticeDataModel.fromJson(i));
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
      print("exception during notice fetch: " + e.toString());
      noticeBloc.add(HomeNoticeErrorEvent());
    } finally {
      client.close();
    }

    return [];
  }

  static Future<List<PreferredNoticeModel>> fetchPreferredNotice() async {
    NoticeBloc noticeBloc = NoticeBloc();
    String noticeUrl = PREFERRED_DETAILED_NOTICE;
    var client = http.Client();
    List<PreferredNoticeModel> notices = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await client.get(Uri.parse(noticeUrl), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}"
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);

        for (var i in data) {
          notices.add(PreferredNoticeModel.fromJson(i));
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
      print("exception during notice fetch: " + e.toString());
      noticeBloc.add(HomeNoticeErrorEvent());
    } finally {
      client.close();
    }

    return [];
  }

  static Future<List<NoticeDataModel>> fetchCategorizedNoticeTile(
      String category) async {
    String categoryId;
    switch (category) {
      case "Exam Notice":
        categoryId = "2";
        break;
      case "Special Notice":
        categoryId = "3";
        break;
      case "Leave Notice":
        categoryId = "4";
        break;
      case "Result Notice":
        categoryId = "6";
        break;
      default:
        categoryId = "1";
    }
    NoticeBloc noticeBloc = NoticeBloc();
    String categoryUrl;

    if (categoryId != "1") {
      categoryUrl = BASE_URL + GET_CATEGORIZED_NOTICES + categoryId;
    } else {
      categoryUrl = BASE_URL + NOTICES;
    }

    var client = http.Client();
    List<NoticeDataModel> notices = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await client.get(Uri.parse(categoryUrl), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}"
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);

        for (var i in data['data']) {
          notices.add(NoticeDataModel.fromJson(i));
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
      print("exception during notice fetch: " + e.toString());
      noticeBloc.add(HomeNoticeErrorEvent());
    } finally {
      client.close();
    }

    return [];
  }
}
