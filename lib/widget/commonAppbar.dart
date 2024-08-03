


import 'package:flutter/material.dart';

import '../Const/const.dart';
import '../Const/route.dart';
import '../controllar/drawer/drawer.dart';
import '../model/userLink.dart';
import '../model/userModel.dart';
import '../searchpage/searchpage.dart';

Widget commonAppbar(UserData? profileData, BuildContext context, DrawerControllerdata drawerController) {
  return Padding(
    padding: const EdgeInsets.only(top: 30, left: 22),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image:
                profileData!.pic == null ?
                DecorationImage(
                  image: AssetImage("assets/unnamed.png"),
                ) : DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("$media${profileData.pic}"),
                )
            )),
        SizedBox(width: 15,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                profileData.fullName!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                )
            ),
            SizedBox(height: 8,),
            Text(
                profileData.phone!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 11,
                )
            ),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    newPage(context: context, child: SearchPage());
                  },
                  child: Icon(Icons.search, color: Colors.white, size: 27,)),
              SizedBox(width: 25,),
              InkWell(
                  onTap: () {
                    drawerController.scafoldKey.currentState!.openEndDrawer();
                  },
                  child: Icon(Icons.menu, color: Colors.white, size: 31,))
            ],
          ),
        )
      ],
    ),
  );
}