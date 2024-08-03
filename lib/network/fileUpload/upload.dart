import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../Const/const.dart';
class UploadFile{


  Future<void> uploadAudio(File audioFile) async {

    final uri = Uri.parse('$BaseUrl/uploader/up/'); // Replace with your API endpoint
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', audioFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {

        Fluttertoast.showToast(
            msg: "Upload Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);


    } else {
      Fluttertoast.showToast(
          msg: "Upload Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      print('Upload failed with status code ${response.statusCode}');
    }
  }


  Future<bool?> uploaddile(String path) async {

    var request = http.MultipartRequest(
        'POST', Uri.parse('$BaseUrl/uploader/up/'));
    request.files.add(await http.MultipartFile.fromPath('file', path));

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var json = jsonDecode(responsedata.body);
      if (json['error'] == 0) {
        Fluttertoast.showToast(
            msg: "Upload Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      }else{
        print(json['msg'] + "msgggg");
        Fluttertoast.showToast(
            msg: json['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      }

    } else {
      print(responsedata.body);
      return false;

    }
  }

}