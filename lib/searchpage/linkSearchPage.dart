import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:http/http.dart' as http;
import '../Const/const.dart';
import '../controllar/userprofileController/userProfileController.dart';
import '../network/NotificationSend/Notification.dart';

class LinkSearchPageWidget extends StatefulWidget {
  final String name;
  final String tagline;
  final String proPic;
  final String userId;

  const LinkSearchPageWidget(
      {super.key,
      required this.name,
      required this.tagline,
      required this.proPic,
      required this.userId});

  @override
  State<LinkSearchPageWidget> createState() => _LinkSearchPageWidgetState();
}

class _LinkSearchPageWidgetState extends State<LinkSearchPageWidget> {
  String? status = '';
  var timer;

  Future followstatus() async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=8b60b892cb6cdac140e0edd7f17a76733b8087b3'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$BaseUrl/follow/followstatus?user_id=${box.get('userid')}&user_profile_id=${widget.userId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        // your timer code, you may have called setState() here to refresh UI
      });
      setState(() {
        status = json['msg'];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    followstatus();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel(); //cancel the periodic task
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final follow = Provider.of<ProfileProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: size.height * 0.15,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15).w,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50.h,
              width: 50.w,
              decoration: widget.proPic == ""
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red),
                      image: const DecorationImage(
                          image: AssetImage("assets/unnamed.png")))
                  : BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("$media${widget.proPic}"))),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    )),
                Text(widget.tagline,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.sp,
                    )),
              ],
            ),
            InkWell(
              onTap: () {
                if (status == "User can follow this user") {
                  follow
                      .followAction(
                          profileid: widget.userId.toString(), status: 'add')
                      .then((value) => followstatus().then((value) {
                            var box = Hive.box("login");
                            NotificationRepo().notificationSend(
                                type: 'follow',
                                content:
                                    '${box.get("name")} started following you',
                                receiverId: widget.userId);
                          }));
                } else {
                  follow
                      .followAction(
                          profileid: widget.userId.toString(), status: 'remove')
                      .then((value) => followstatus());
                }
              },
              child: Container(
                height: 30.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15).w,
                    color: Colors.red),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0).w,
                    child: Text(
                        status == ""
                            ? ""
                            : status == "User can follow this user"
                                ? 'Follow'
                                : 'Unfollow',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
