
import 'dart:convert';
import 'package:connect/Const/route.dart';
import 'package:connect/Home/HomePage.dart';
import 'package:connect/Splash/Splash.dart';
import 'package:flutter/material.dart';
import 'package:connect/Const/const.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:http/http.dart'as http;

import '../../BottomNav/bottomNavPage.dart';

 class LoginRepository{
   var box=Hive.box("login");
  Future LoginRepo(String email,String password,BuildContext context)async{
print(email);
print(password);
 var body={
   "email":email,
   "password":password
 };
    try{
      var responce=await http.post(Uri.parse("$BaseUrl/user/login"),
      body:body
      );
      print(responce.body);
      var datadecode=await jsonDecode(responce.body);
      print(datadecode);

      if(datadecode['error']==0){
        box.put('email', datadecode['msg']['UserEmail']);
        box.put('userid', datadecode['msg']['mainUserId']);
        box.put('name', datadecode['msg']['name']);
        Fluttertoast.showToast(
            msg: "Login Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SplashScreen()), (route) => false);

      }
      else{
        Fluttertoast.showToast(
            msg: "${datadecode["msg"]}",
            toastLength: Toast.LENGTH_SHORT,
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