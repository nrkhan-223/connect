
import 'dart:convert';

import '../../Const/const.dart';
import '../../model/membershipModel/membershipModel.dart';
import 'package:http/http.dart' as http;
class MembershipRepo{


  Future<MembershipModel?> getMembership()async{
    try{
      var responce=await http.get(Uri.parse("$BaseUrl/membership/packages"));
      var dataDecde=jsonDecode(responce.body);
      if(dataDecde["error"]==0)
      {
        print("myLink>>>>>>${responce.body}");
        return membershipModelFromJson(responce.body);
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

}