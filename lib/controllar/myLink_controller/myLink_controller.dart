


import 'package:connect/model/mylinkModel/mylinkModel.dart';
import 'package:connect/network/myLinkrepo/myLink.dart';
import 'package:flutter/cupertino.dart';

import '../../network/myLinkrepo/my_apply_jobs.dart';

class  MyLinkContrllar extends ChangeNotifier{

  var loader =true;
  @override
  notifyListeners();
  MyLinkModel? mylinkList;

  MylinkRepository mylinkRepository=MylinkRepository();
  Future getMyLink()async{

    var network=await mylinkRepository.myLinkRepo();
    if(network !=null){
      mylinkList= network;
       loader =false;
      notifyListeners();
    }
    else{
      mylinkList = null;
      loader =false;
      notifyListeners();
    }


  }



}