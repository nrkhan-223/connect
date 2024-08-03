
import 'package:connect/model/categoric_model.dart';
import 'package:connect/network/categoric_repo/categoric.dart';
import 'package:flutter/cupertino.dart';

class  CategoricContrllar extends ChangeNotifier{

  var loder =false;

  var catagoriclist= CategoricModel();

  CategoricRepository categoricRepository=CategoricRepository();

  Future getCategoric()async{

    var network=await categoricRepository.categoricRepo();
    if(network !=null){
      catagoriclist= network;
      notifyListeners();
    }


  }



}