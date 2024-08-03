
import 'package:connect/network/auth/login.dart';
import 'package:flutter/cupertino.dart';

class LoginControllar extends ChangeNotifier{

  bool passvisible=true;
  LoginRepository loginRepository=LoginRepository();

  TextEditingController emailControllar=TextEditingController();
  TextEditingController passwordControllar=TextEditingController();
  var loder=false;

   passwordVisivile(){

    passvisible=!passvisible;
    print('visibiliti $passvisible');
    notifyListeners();

  }

 Future getLogin(BuildContext context)async{
   loder= true;
   notifyListeners();
   await loginRepository.LoginRepo(emailControllar.text, passwordControllar.text,context).then((value) {
     emailControllar.clear();
     passwordControllar.clear();
     loder=false;
     notifyListeners();
   });


  }
}