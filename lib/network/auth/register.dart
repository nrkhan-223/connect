import 'dart:convert';

import 'package:connect/Const/const.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

import '../../model/register_model.dart';

 class RegisgerRepository{

  Future<RegisterModel?> RegisterRepo(String full_name,String email,String profile_tagline,
      String company_name, String phone,String password,String re_pass,BuildContext context)async{
   var body={
    "full_name":full_name,
    "email":email,
    "profile_tagline" :profile_tagline,
    "company_name":company_name,
    "phone":phone,
    "password":password,
    "re_pass":re_pass
   };
   try{

    var respoce= await http.post(Uri.parse("${BaseUrl}/user/register"),
        body:body);
    print(respoce.body);

    var datadecode=jsonDecode(respoce.body);

    if(datadecode["error"]==0){
     print(respoce.body);

     Fluttertoast.showToast(
         msg: "${datadecode["msg"]} Please Login",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.green,
         textColor: Colors.white,
         fontSize: 16.0
     );
     Navigator.pop(context);
     return registerModelFromJson(respoce.body);
    }
    else{
     Fluttertoast.showToast(
         msg: "${datadecode["msg"]} Please Login",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 16.0
     );
     Navigator.pop(context);

    }

   }catch(e,s){
    print(e);

    print(s);

   }

  }


 }