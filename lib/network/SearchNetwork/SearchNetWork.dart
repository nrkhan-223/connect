
import 'dart:convert';

import 'package:connect/Const/const.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../../model/SearchCategoricModel/searchCategoric.dart';
import '../../model/SearchJobModel/SearchJobModel.dart';
import '../../model/SearchUserModel/SearchModelUser.dart';
class SearchNetWork {

  Future<SearchUserModel?> getSearchUser(
      {String? keyword, int? type}) async {
    print(keyword);
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=48992169d438e8d18248cc6d509f325251184d7e'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$BaseUrl/search/filter?key_word=$keyword&user_id=${box.get('userid')}&type=$type'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error'] == 0) {


        SearchUserModel  searchUserModel = searchUserModelFromJson(responsedata.body);

        return searchUserModelFromJson(responsedata.body);

      } else {
        return null;
        print(responsedata.body);

      }
    } else {
      return null;
    }

  }



  Future<ScarchCategoricModel?> getSearchCateGory(
      {String? keyword, int? type}) async {
    print(keyword);
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=48992169d438e8d18248cc6d509f325251184d7e'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$BaseUrl/search/filter?key_word=$keyword&user_id=${box.get('userid')}&type=$type'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error'] == 0) {


        SearchUserModel  searchUserModel = searchUserModelFromJson(responsedata.body);

        return scarchCategoricModelFromJson(responsedata.body);

      } else {
        return null;
        print(responsedata.body);

      }
    } else {
      return null;
    }

  }


  Future<SearchJobModel?> getSearchLink(
      {String? keyword, int? type}) async {
    print(keyword);
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=48992169d438e8d18248cc6d509f325251184d7e'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$BaseUrl/search/filter?key_word=$keyword&user_id=${box.get('userid')}&type=$type'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error'] == 0) {

        return searchJobModelFromJson(responsedata.body);

      } else {
        return null;
        print(responsedata.body);

      }
    } else {
      return null;
    }

  }
}