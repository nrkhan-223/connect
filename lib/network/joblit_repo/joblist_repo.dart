
import 'dart:convert';

import 'package:connect/Const/const.dart';
import 'package:connect/model/joblist_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart'as http;
class JobListRepository{
var box=Hive.box("login");
Future<JobListModel?> jobListRepo(int offeset,int limit )async{
  print(box.get("userid"));

  try {
    var responce= await http.get(Uri.parse("${BaseUrl}/job/listing?user_id=${box.get("userid")}&limit=$limit&offset=$offeset"),);
    var data=jsonDecode(responce.body);
    if(data["error"]==0){

      print(responce.body);
      return jobListModelFromJson(responce.body);
    }
  }catch(e,s){
    print(e);
    print(s);

  }
}



Future removeJob({String? jobid}) async {
  var box = Hive.box('login');
  print("${box.get('userid')}");
  var request = http.Request('GET', Uri.parse('$BaseUrl/job/delete/$jobid/${box.get('userid')}'));
print('$BaseUrl/job/delete/$jobid/${box.get('userid')}');
  http.StreamedResponse response = await request.send();
  var responsedata = await http.Response.fromStream(response);

  try {
    if (response.statusCode == 200) {
      print(responsedata.body);
      var json = jsonDecode(responsedata.body);

      if (json['error'] == 0) {
        Fluttertoast.showToast(
            msg: json['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: json['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      print(responsedata.body);
    }
  }

  catch(e,s){
    print(e);
    print(s);
  }
}
}