
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

import '../../Const/const.dart';


class AllLinkRepository{
  var box=Hive.box("login");


  Future jobApply({
    required String jobid,
    required String time,
    required String ownerId,
    required String note,
    required String audio,
    required String video,
    required List<String> images,

  })async{


    try{
      var body = {
        'job_id': jobid,
        'user_id': box.get('userid'),
        'time': time,
        'job_owner': ownerId,
        'note': note,
        "image":"$images",
        "audio": "[\"$audio\"]",
        "video":"[\"$video\"]"
      };


      var responce= await http.post(Uri.parse("${BaseUrl}/job/applicationcreate"),
          body:body );
      jsonDecode(responce.body);
      if(jsonDecode(responce.body)["error"]==0){

        Fluttertoast.showToast(
            msg: "${jsonDecode(responce.body)["msg"]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else{
        Fluttertoast.showToast(
            msg: "${jsonDecode(responce.body)["msg"]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    }
    catch (e, s){
      print(e);
      print(s);
    }
  }

  Future updateJob(
      {String? jobTiltle,
        connectId,
        desc,
        category,


        audio,
        video,
        contactNumber,
        List <String>? image,
        BuildContext? context,  String? file}) async {
    print(jobTiltle);
    print(connectId);
    print(category);
    print(desc);
    print(contactNumber);
    // var request =
    //     http.MultipartRequest('POST', Uri.parse('$url/api/job/updatepost/'));
    try{
      var headers = {
        'Cookie': 'ci_session=2f73ed39ce35f5e92e48a1a1755b631c90781215'
      };
      var request = http.MultipartRequest('POST', Uri.parse('http://linkapp.xyz/api/job/updatepost/'));
      request.fields.addAll({
        'job_id': connectId??"",
        'job_title': jobTiltle??"",
        'description': desc??"",
        'category': category??"",
        'contactnumber': contactNumber??"",
        "image":"$image",
        "audio": "[\"$audio\"]",
        "video":"[\"$video\"]"
      });

      request.headers.addAll(headers);

      // request.fields.addAll({
      //   'job_id': jobid,
      //   'job_title': jobtite!,
      //   'description': description,
      //   'category': category,
      //   'contactnumber': contactnumber,
      //   'image': image,
      //   'audio': audio,
      //   'video': video
      // });


      // http.StreamedResponse response = await request.send();
      // var responsedata = await http.Response.fromStream(response);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {

        print(await response.stream.bytesToString());
        print("fuad");
      }
      else {
        print(response.reasonPhrase);
      }
    }
    catch(e, s){
      print("fuad"+e.toString());
      print("fuad"+s.toString());
    }

  }
  Future addLinkRepo(
      String job_title,
      String description,
      String id,
      String contactnumber,
      String category,
      List<String> image,
      String audio,
      String video, String file,
      )async{
    try{
      var body={
        "job_title":job_title,
        "description":description,
        "category":category,
        "user_id":id,
        "contactnumber":contactnumber,
        "image":"$image",
        "audio": "[\"$audio\"]",
        "video":"[\"$video\"]"


      };
      var responce= await http.post(Uri.parse("$BaseUrl/job/jobcreate"),
          body:body );
      jsonDecode(responce.body);
      if(jsonDecode(responce.body)["error"]==0){
        Fluttertoast.showToast(
            msg: "${jsonDecode(responce.body)["msg"]}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else{
        Fluttertoast.showToast(
            msg: "${jsonDecode(responce.body)["msg"]}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    }catch(e,s){
      print(e);
      print(s);

    }

  }


}