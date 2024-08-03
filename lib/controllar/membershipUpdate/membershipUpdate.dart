import 'dart:convert';
import 'dart:developer';
import 'package:connect/Const/route.dart';
import 'package:connect/Splash/congratulationpage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../BottomNav/bottomNavPage.dart';
import '../../Const/const.dart';
import '../userprofileController/userProfileController.dart';

class MembershipUpdate extends ChangeNotifier {
  Future update(int index, BuildContext context, member) async {

    final profile1 = Provider.of<ProfileProvider>(context, listen: false);

    var data = {
      "pg_service_charge_bdt": "0.35",
      "amount_original": "${profile1.membershipModel!.msg![index].price}",
      "gateway_fee": "",
      "pg_service_charge_usd": "Not-Available",
      "pg_card_bank_name": "Not Available",
      "pg_card_bank_country": "Not Available",
      "card_number": "1234XXXXXXXXX123",
      "card_holder": "",
      "status_code": "2",
      "pay_status": "Successful",
      "success_url": "http:\/\/localhost\/connect-api\/membership\/success",
      "fail_url": "http:\/\/localhost\/connect-api\/membership\/fail",
      "cus_name": "${profile1.profile!.msg!.userData!.fullName}",
      "cus_email": "${profile1.profile!.msg!.userData!.email}",
      "cus_phone": "${profile1.profile!.msg!.userData!.phone}",
      "currency_merchant": "BDT",
      "convertion_rate": "",
      "ip_address": "103.81.204.43",
      "other_currency": "10.00",
      "pg_txnid": "AAM1652555163103940",
      "epw_txnid": "AAM1652555163103940",
      "mer_txnid": "M44YD451BY",
      "store_id": "aamarpaytest",
      "merchant_id": "aamarpaytest",
      "currency": "BDT",
      "store_amount": "9.65",
      "pay_time": "2022-05-15 01:06:12",
      "amount": "10.00",
      "bank_txn": "1089255727259",
      "card_type": "DBBL-MobileBanking",
      "reason": "Not Available",
      "pg_card_risklevel": "0",
      "pg_error_code_details": "Not Available",
      "opt_a": "2",
      "opt_b": "1",
      "opt_c": "\u09ac\u09c7\u09b8\u09bf\u0995",
      "opt_d": ""
    };
    var body = {
      "user_id": profile1.profile!.msg!.userData!.userId!,
      "pgw_data": jsonEncode(data),
      "package_id": profile1.membershipModel!.msg![index].packageId,
      "is_renew": "1",
    };

    try {

      final profile1 = Provider.of<ProfileProvider>(context, listen: false);
      var responce =
          await http.post(Uri.parse("$BaseUrl/membership/buy"), body: body);
      print(responce.body);
      log(responce.statusCode.toString());

      if (responce.statusCode == 200) {
        // log("response code =200");

        var datadecode = await jsonDecode(responce.body);
        print(datadecode);

        if (datadecode['error'] == 0) {
          newPage(context: context, child: const CongratsPage());
          Fluttertoast.showToast(
              msg: "${datadecode["msg"]}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          profile1.getProfileInfo();
        } else {
          Fluttertoast.showToast(
              msg: "${datadecode["msg"]}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } catch (e, s) {
      print(e);
      print(s);
    } finally {
      load(member, context);
      // Navigator.pop(context);

      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => const BottomNavPage()),
      //     (route) => false);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>MemberShipPage(mambershipName: member,) ,));
    }

  }

  int selectIndex = 100;
  bool loader = true;

  Future load(mambershipName, context) async {
    loader = true;
    notifyListeners();
    final profile1 = Provider.of<ProfileProvider>(context, listen: false);

    profile1.getMembershipFromModel().then((value) {
      for (var i = 0; i < profile1.membershipModel!.msg!.length; i++) {
        if (mambershipName == profile1.membershipModel!.msg![i].title) {
          print(mambershipName == profile1.membershipModel!.msg![i].title);
          print(mambershipName);
          print(profile1.membershipModel!.msg![i].title);

          selectIndex = i;
          notifyListeners();
          print(selectIndex);
        } else {
          print(selectIndex);
        }
      }
    }).then((value) {
      loader = false;
      notifyListeners();
    });
  }
}
