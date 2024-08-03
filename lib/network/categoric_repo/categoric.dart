
import 'dart:convert';

import 'package:connect/Const/const.dart';
import 'package:connect/model/categoric_model.dart';
import 'package:http/http.dart'as http;


class CategoricRepository{

  Future<CategoricModel?> categoricRepo()async{

    try{
      var responce=await http.get(Uri.parse("${BaseUrl}/job/catlisting"));
      var datadeco=await jsonDecode(responce.body);
      if(datadeco["error"]==0){
        return categoricModelFromJson(responce.body);
      }

    }catch(e,s){
      print(e);
    print(s);
    }

  }
}