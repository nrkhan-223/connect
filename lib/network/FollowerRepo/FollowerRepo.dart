


import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../Const/const.dart';
import '../../model/FollowerModel/FollowerModel.dart';
import 'package:http/http.dart' as http;

import '../../model/following.dart';
class FollowerRepo{

  Future<FollowerModel?> getFollower()async{

    try{
      var box=Hive.box("login");
      var responce=await http.get(Uri.parse("$BaseUrl/follow/listing?user_id=${box.get("userid")}&limit=10&offset=0&type=follower"));
      var datadeco=await jsonDecode(responce.body);
      if(datadeco["error"]==0){

        return followerModelFromJson(responce.body);
      }

    }catch(e,s){
      print(e);
      print(s);
    }

  }

  Future<Following?> getFollowing()async{

    try{
      var box=Hive.box("login");
      var responce=await http.get(Uri.parse("$BaseUrl/follow/listing?user_id=${box.get("userid")}&limit=10&offset=0&type=following"));
      var datadeco=await jsonDecode(responce.body);
      if(datadeco["error"]==0){

        return followingFromJson(responce.body);
      }

    }catch(e,s){
      print(e);
      print(s);
    }

  }
}