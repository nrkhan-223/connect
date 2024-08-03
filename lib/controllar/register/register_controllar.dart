import 'package:connect/model/register_model.dart';
import 'package:connect/network/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RegisterControllar extends ChangeNotifier {
  var box = Hive.box("login");

  var registerData = RegisterModel();

  RegisgerRepository regisgerRepository = RegisgerRepository();

  var loder = false;
  TextEditingController fullNameControllar = TextEditingController();
  TextEditingController emailControllar = TextEditingController();
  TextEditingController profileTaglineControllar = TextEditingController();
  TextEditingController conpanyNameControllar = TextEditingController();
  TextEditingController phoneControllar = TextEditingController();
  TextEditingController passswordControllar = TextEditingController();
  TextEditingController rePassworddControllar = TextEditingController();

  Future getRegister(BuildContext context) async {
    loder = true;
    if (fullNameControllar.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Name is required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (emailControllar.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Email is required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (profileTaglineControllar.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Tagline is required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (conpanyNameControllar.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Company Name is required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (phoneControllar.text.isEmpty ||
        phoneControllar.text.length != 11) {
      Fluttertoast.showToast(
          msg: "Valid phone number is required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (passswordControllar.text != rePassworddControllar.text) {
      Fluttertoast.showToast(
          msg: "Password & confirm password is not same",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      box.put("userNumber", phoneControllar.text);
      await regisgerRepository.RegisterRepo(
              fullNameControllar.text,
              emailControllar.text,
              profileTaglineControllar.text,
              conpanyNameControllar.text,
              phoneControllar.text,
              passswordControllar.text,
              rePassworddControllar.text,
              context)
          .then((value) {
        fullNameControllar.clear();
        emailControllar.clear();
        profileTaglineControllar.clear();
        conpanyNameControllar.clear();
        phoneControllar.clear();
        passswordControllar.clear();
        rePassworddControllar.clear();
        notifyListeners();
      });
    }
    loder = false;
    notifyListeners();
  }
}
