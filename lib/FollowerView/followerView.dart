

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Const/route.dart';
import '../Skeleton/SearchUserSkeleton.dart';
import '../model/FollowerModel/FollowerModel.dart';
import '../network/FollowerRepo/FollowerRepo.dart';
import '../searchpage/linkSearchPage.dart';
import '../user_profile/user_profile.dart';

class FollowerView extends StatefulWidget {
  const FollowerView({Key? key}) : super(key: key);

  @override
  State<FollowerView> createState() => _FollowerViewState();
}

class _FollowerViewState extends State<FollowerView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body:

      Stack(
        children: [
          SizedBox(
              height: size.height,
              width: size.width,
              child: Image.asset(
                "assets/backgroundImage.png",
                fit: BoxFit.cover,
              )),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15).r,
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: Text(
                      "Follower",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 18.sp,
                          //fontFamily: 'IrabotiMJ',
                          color: Colors.black
                      )
                  ),
                  centerTitle: true,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 10).r,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon:  Icon(
                        Icons.arrow_back_ios, size: 25.w,  color: Colors.black,),
                    ),
                  ),
                ),
              ),
              FutureBuilder<FollowerModel?>(
                  future: FollowerRepo().getFollower(),
                  builder: (context, ss) {
                    if (ss.connectionState == ConnectionState.waiting) {
                      return searchUserSkeleton(size);
                    } else if (ss.hasData) {
                      var dataList = ss.data!.msg!.result;
                      return ListView.builder(
                          itemCount: dataList!.length,
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var data = dataList[index];
                            return InkWell(
                                onTap: () {
                                  newPage(
                                      context: context,
                                      child: UserProfilePage(
                                        id: data.userId!,
                                      ));
                                },
                                child: LinkSearchPageWidget(
                                  name: data.fullName!,
                                  tagline: data.profileTagline!,
                                  proPic: data.pic?? "",
                                  userId: data.userId!,
                                ));
                          });
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Center(child: Text("No data")),
                      );
                    }
                  }),
            ],
          )
        ],
      ),


    );
  }
}
