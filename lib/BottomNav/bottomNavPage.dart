import 'package:connect/Home/HomePage.dart';
import 'package:connect/notification/notificationpage.dart';
import 'package:connect/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../back/back.dart';
import '../message/message.dart';
import '../mylink_page/mylink_page.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int index = 0;

  List bodyItem = [
    const HomePage(),
    const MyLinkPage(),
    const Message(),
    const ProfilePage(),
    const NotificatonsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> navItem = [
      CircleAvatar(
        radius: 33.r,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset("assets/home.svg",
            colorFilter: ColorFilter.mode(
                index == 0 ? Colors.red : Colors.black, BlendMode.srcIn),
            semanticsLabel: 'A red up arrow'),
      ),
      CircleAvatar(
        radius: 33.w,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset("assets/link.svg",
            colorFilter: ColorFilter.mode(
                index == 1 ? Colors.red : Colors.black, BlendMode.srcIn),
            semanticsLabel: 'A red up arrow'),
      ),
      CircleAvatar(
        radius: 33.w,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset("assets/msg.svg",
            colorFilter: ColorFilter.mode(
                index == 2 ? Colors.red : Colors.black, BlendMode.srcIn),
            semanticsLabel: 'A red up arrow'),
      ),
      CircleAvatar(
        radius: 33.w,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset("assets/person.svg",
            colorFilter: ColorFilter.mode(
                index == 3 ? Colors.red : Colors.black, BlendMode.srcIn),
            semanticsLabel: 'A red up arrow'),
      ),
      CircleAvatar(
        radius: 33.w,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset("assets/notification.svg",
            colorFilter: ColorFilter.mode(
                index == 4 ? Colors.red : Colors.black, BlendMode.srcIn),
            semanticsLabel: 'A red up arrow'),
      ),
    ];
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0.w,
                  spreadRadius: 2.0.w,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0.w,
                  spreadRadius: 0.0.w,
                ),
              ]),
          height: 70.h,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            for (int i = 0; i < navItem.length; i++)
              InkWell(
                  onTap: () {
                    setState(() {
                      index = i;
                    });
                  },
                  child: navItem[i])
          ]),
        ),
        body: DoubleBackToCloseWidget(
          child: bodyItem[index],
        ));
  }
}
