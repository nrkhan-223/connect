
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../Const/const.dart';
import 'package:http/http.dart' as http;

import '../../model/ApplyListModel/ApplyListModek.dart';
class JobApplyListRepo{
  
  Future<ApplyListModel?> applyList(String id) async {
    String api = "$BaseUrl/job/jobapplylisting/$id";
    var headers = {
      'Cookie': 'ci_session=48992169d438e8d18248cc6d509f325251184d7e'
    };
    var res = await http.get(Uri.parse(api), headers: headers);
    if (res.statusCode == 200) {
      try {
         var datadecod =jsonDecode(res.body);
         if(datadecod["error"]==0){
           return applyListModelFromJson(res.body);
         }
         else{
           return null;
         }

      } catch (e) {

        return null;

      }
    } else {


      return null;
    }

  }
}