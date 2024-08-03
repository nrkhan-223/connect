


import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../Const/const.dart';
import '../../model/CategoryJobMode/categoryJobModel.dart';
import 'package:http/http.dart' as http;
class CategoryJobRepo{


  Future<CategoryJobModel?> getCategoryJob (String catId)async{


    try{
      var box=Hive.box("login");
      var responce=await http.get(Uri.parse("$BaseUrl/job/catjob/$catId/${box.get("userid")}"));
      var datadeco=await jsonDecode(responce.body);
      if(datadeco["error"]==0){
        return categoryJobModelFromJson(responce.body);
      }

    }catch(e,s){
      print(e);
      print(s);
    }

}
}