
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../../Const/const.dart';
import '../../model/Notification/NotificationModel.dart';

class NotificationRepo{

  Future notificationSend(
      {required String type, String? receiverId, String?jobId, required String content})async{
    var box = Hive.box('login');
    var body={
      "sender_id":"${box.get('userid')}",
      "receiver_id":"$receiverId",
      "job_id":"${jobId??""}",
      "content":"$content",
      "type":type,
    };
    try{
      print(body);
      var response=await http.post(Uri.parse("${BaseUrl}/notification/send"),

      body: body
      );
      print("myLink>>>>>>${response.body}");

    }catch(e,s){
      print(e);
      print(s);
    }

  }


  Future<NotificationModel?> getNotification() async {

    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=48992169d438e8d18248cc6d509f325251184d7e'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$BaseUrl/notification/read?receiver_id=${box.get('userid')}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error'] == 0) {



        return notificationModelFromJson(responsedata.body);

      } else {
        print(responsedata.body);
        return null;


      }
    } else {
      return null;
    }

  }



  Future notificationDelete(
      {required String id,required String receiverId,})async{
    var body={
      "id":"$id",
      "receiver_id":"$receiverId",

    };
    try{
      print(body);
      var response=await http.post(Uri.parse("${BaseUrl}/notification/delete"),

          body: body
      );
      print("myLink>>>>>>${response.body}");

    }catch(e,s){
      print(e);
      print(s);
    }

  }


}