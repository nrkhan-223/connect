import 'dart:convert';
import 'dart:developer';

import 'package:connect/Const/const.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart'as http;

import '../../model/OtherLinkModel/OtherLinkModel.dart';
import '../../model/mylinkModel/my-apply_link_model.dart';
import '../../model/mylinkModel/mylinkModel.dart';

class MylinkRepository{

   Future<MyLinkModel?> myLinkRepo()async{
      var box = Hive.box('login');
      try{
         var responce=await http.get(Uri.parse("${BaseUrl}/user/usersjob/${box.get('userid')}"));
         var dataDecde=jsonDecode(responce.body);
         if(dataDecde["error"]==0)
         {
            return myLinkModelFromJson(responce.body);
         }
         else{
            return null;
         }
      }catch(e,s){
         print(e);
         print(s);

         return null;
      }


   }
   Future<OtherLinkModel?> otherLinkRepo(id)async{
      var box = Hive.box('login');
      try{
         var responce=await http.get(Uri.parse("${BaseUrl}/user/usersjob/$id"));
         var dataDecde=jsonDecode(responce.body);
         if(dataDecde["error"]==0)
         {

            return otherLinkModelFromJson(responce.body);
         }
         else {
            return null;
         }
      }catch(e,s){

         print(e);
         print(s);
         return null;
      }


   }
   Future<List<MyApply>?> getPost() async {
      var box = Hive.box('login');
      try{
         var url = 'https://linkapp.xyz/api/user/userapply/${box.get('userid')}';
         final uri = Uri.parse(url);
         final response = await http.get(uri);
         final body = response.body;
         final json = jsonDecode(body);
         final result = json['results'] as List<dynamic>;
         final posts = result.map((e) => MyApply.fromJson(e)).toList();
         if(json["error"]==0){
            return posts;
         }else{
            return null;
         }

      }catch(e){
         log(e.toString());
         return null;
      }
   }
}