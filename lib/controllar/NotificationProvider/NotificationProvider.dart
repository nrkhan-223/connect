


import 'package:flutter/material.dart';

import '../../model/Notification/NotificationModel.dart';
import '../../network/NotificationSend/Notification.dart';

class NotificationProvider extends ChangeNotifier{
  NotificationModel? notificationModel;

  Future getNotification()async{

    var network=await NotificationRepo().getNotification();
    if(network !=null){
      print(true);
      notificationModel= network;

      notifyListeners();
    }
    else{
      notificationModel =null;
      notifyListeners();

    }


  }

}