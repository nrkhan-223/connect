
import 'dart:convert';

import 'package:connect/model/user_profilemodel/user_profilemode;.dart';
import 'package:http/http.dart' as http;

import '../Const/const.dart';

class FriendProfileRepo{

  UserProfileModel? userProfileModel;


  Future<UserProfileModel?> getUserProfileInfo(String id) async {

    print("UserId>>>$id");
    var headers = {
      'Cookie': 'ci_session=6462a9d3495609d2caf8d9a99a5fdb8325123111'
    };
    var request = http.Request(
        'GET', Uri.parse('$BaseUrl/user/profile/$id'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(jsonDecode(responsedata.body));
      userProfileModel = UserProfileModel.fromJson(jsonDecode(responsedata.body));

      return userProfileModel;

    } else {
return null;

    }
  }
}
