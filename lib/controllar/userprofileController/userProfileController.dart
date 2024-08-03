import 'dart:convert';

import 'package:connect/Const/const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../../model/following.dart';
import '../../model/membershipModel/membershipModel.dart';
import '../../model/userModel.dart';
import '../../model/user_profilemodel/user_profilemode;.dart';
import '../../network/MembershipRepo/MembershipRepo.dart';
import '../categoric_controllar/categoric_controllar.dart';

class ProfileProvider extends ChangeNotifier {
  var loder = false;


  List<dynamic> services = [];
  List<String> servicesByName = [];
  Profile? profile;
  UserProfileModel? userProfileModel;
  final categoryController = CategoricContrllar();

  Future getProfileInfo() async {
    await categoryController.getCategoric();
    var box = Hive.box('login');
    print('profile UId:${box.get('userid')}');
    var headers = {
      'Cookie':
          'ci_session=911b437d1f2509031e11c96854785401c37ddd72; path=/; HttpOnly'
    };
    var request = http.Request('GET',
        Uri.parse('https://linkapp.xyz/api/user/profile/${box.get('userid')}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);
    print(response.statusCode);
    final jsondata = jsonDecode(responsedata.body);
    if (jsondata['error'] == 0) {
      print(jsonDecode(responsedata.body));
      profile = Profile.fromJson(jsonDecode(responsedata.body));
      print(profile!.msg);
      services = profile!.msg!.userData!.serviceArea!;
      servicesByName.clear();
      for (var i in categoryController.catagoriclist.msg!) {
        if (services.contains(i.catId!)) {
          servicesByName.add(i.catName!);
          notifyListeners();
        }
      }
      print("fuad" + servicesByName.toString());

      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  Future followAction({String? status, String? profileid}) async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=9d28b8137e3efdce4d19a5c2d3140dcbd0d306c7'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$BaseUrl/follow/action?action=$status&user_id=${box.get('userid')}&user_profile_id=$profileid'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
    } else {}
  }

  Future followStatusCheck({String? userid, userprofileid}) async {
    var headers = {
      'Cookie': 'ci_session=9d28b8137e3efdce4d19a5c2d3140dcbd0d306c7'
    };
    var request = http.Request('GET',
        Uri.parse('$BaseUrl/follow/followstatus?user_id=2&user_profile_id=5'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsedata.body);
      notifyListeners();
      return data;
    } else {
      notifyListeners();
    }
  }

  MembershipModel? membershipModel;
  MembershipRepo membershipRepo = MembershipRepo();

  Future getMembershipFromModel() async {
    loder = true;
    membershipModel = await membershipRepo.getMembership();
    loder = false;
    notifyListeners();
  }

  Following? following;

  Future getFollowing({String? type}) async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=b9761a6ab237259e012629d2dc8c591188119af6'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$BaseUrl/follow/listing?user_id=${box.get('userid')}&limit=10&offset=0&type=$type'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error'] == 0) {
        following = followingFromJson(responsedata.body);
        notifyListeners();
      } else {
        following = null;
        notifyListeners();
      }
    } else {}
  }

  Future profileUpdate({
    String? name,
    company,
    phone,
    profiletag,
    oldpass,
    newpass,
    pic,
    confirmpass,
    List<String>? servicearea,
  }) async {
    var list = [];

    for (var s in servicearea!) {
      list.add("\"$s\"");
    }
    print(list);
    var box = Hive.box('login');
    var request =
        http.MultipartRequest('POST', Uri.parse('$BaseUrl/user/profileupdate'));
    request.fields.addAll({
      'user_id': box.get('userid'),
      'full_name': name!,
      'company_name': company,
      'phone': phone,
      'user_name': '',
      'service_area': list.isNotEmpty ? "${list}" : "",
      'profile_tagline': profiletag,
      'pic': pic,
      'oldpass': oldpass,
      'newpass': newpass,
      'confirmnewpass': confirmpass
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var json = jsonDecode(responsedata.body);
      if (json['error'] == 0) {
        Fluttertoast.showToast(
            msg: "Profile Update Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

      } else {

        Fluttertoast.showToast(
            msg: json['msg'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

      }
      notifyListeners();
    } else {}
  }
}
