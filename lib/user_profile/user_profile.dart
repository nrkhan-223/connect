import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/Const/route.dart';
import 'package:connect/model/user_profilemodel/user_profilemode;.dart';
import 'package:connect/post/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import '../Const/const.dart';
import '../Skeleton/SearchUserSkeleton.dart';

import '../controllar/userprofileController/userProfileController.dart';
import '../membership/membershipPage.dart';
import '../message/messagepage.dart';
import '../model/OtherLinkModel/OtherLinkModel.dart';
import '../network/NotificationSend/Notification.dart';
import '../network/getFrndProdfile.dart';
import '../network/myLinkrepo/myLink.dart';
import '../widget/drawer_widget.dart';
import 'package:http/http.dart' as http;
import '../widget/postlist_widget.dart';

class UserProfilePage extends StatefulWidget {
  final String id;
  const UserProfilePage({super.key, required this.id});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

var profileimg;
class _UserProfilePageState extends State<UserProfilePage> {
  String status = '';
  var box = Hive.box('login');

  Future followstatus() async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=8b60b892cb6cdac140e0edd7f17a76733b8087b3'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$BaseUrl/follow/followstatus?user_id=${box.get('userid')}&user_profile_id=${widget.id}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
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
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final follow = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
                height: size.height.h,
                width: size.width.w,
                child: Image.asset(
                  "assets/backgroundImage.png",
                  fit: BoxFit.cover,
                )),
            Stack(
              children: [
                Container(
                  height: size.height * 0.35,
                  width: size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/profileImage.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
               Padding(
                 padding:  EdgeInsets.only(
                   top: (size.height * 0.1)/22,
                   // left: 15,
                   // right: 15,
                 ),
                 child: Column(
                   children: [
                     AppBar(
                       elevation: 0,
                       backgroundColor: Colors.transparent,
                       leading: IconButton(
                         onPressed: (){
                           Navigator.pop(context);
                         },
                         icon: const Icon(Icons.arrow_back_ios),
                       ),
                     ),
                     SizedBox(height: size.height*0.1,),
                     FutureBuilder<UserProfileModel?>(
                       future:
                       FriendProfileRepo().getUserProfileInfo(widget.id),
                       builder: (context, ss) {
                         if (ss.connectionState == ConnectionState.waiting) {
                           return searchUserSkeleton(size);
                         } else if (ss.hasData) {
                           var data = ss.data!.msg!.userData!;
                           return Stack(
                             alignment: Alignment.topCenter,
                             clipBehavior: Clip.none,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 15),
                                 child: Container(
                                   height: size.height * 0.36,
                                   width: size.width.w,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(20),
                                       color: Colors.white),
                                   child: Column(
                                     children: [
                                       SizedBox(
                                         height: 5.h,
                                       ),
                                       Column(
                                         mainAxisAlignment:
                                         MainAxisAlignment.center,
                                         crossAxisAlignment:
                                         CrossAxisAlignment.center,
                                         children: [
                                           Padding(
                                             padding:  const EdgeInsets.only(
                                                 top: 40).w,
                                             child: Text('${data.fullName}',
                                                 textAlign: TextAlign.center,
                                                 style:  TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 18.sp,
                                                     fontWeight:
                                                     FontWeight.bold)),
                                           ),
                                           SizedBox(height: 8.h),
                                           Text('${data.profileTagline}',
                                               textAlign: TextAlign.center,
                                               style: const TextStyle(
                                                 color: Colors.grey,
                                                 fontSize: 12,
                                               )),
                                         ],
                                       ),
                                       SizedBox(
                                         height: 15.h,
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.symmetric(
                                             horizontal: 10),
                                         child: Row(
                                           children: [
                                             SvgPicture.asset(
                                               "assets/phone.svg",
                                               color: Colors.black,
                                             ),
                                             const SizedBox(
                                               width: 10,
                                             ),
                                             Text('${data.phone}',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 12.sp,
                                                     fontWeight:
                                                     FontWeight.bold)),
                                           ],
                                         ),
                                       ),
                                        SizedBox(
                                         height: 8.h,
                                       ),
                                       Padding(
                                         padding:  const EdgeInsets.symmetric(
                                             horizontal: 10).w,
                                         child: Row(
                                           children: [
                                             SvgPicture.asset(
                                               "assets/email.svg",
                                               height: 12,
                                               width: 15,
                                               color: Colors.black,
                                             ),
                                             const SizedBox(
                                               width: 10,
                                             ),
                                             Text('${data.email}',
                                                 textAlign: TextAlign.center,
                                                 style: const TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 12,
                                                     fontWeight:
                                                     FontWeight.bold)),
                                           ],
                                         ),
                                       ),
                                       const SizedBox(
                                         height: 10,
                                       ),
                                       InkWell(
                                         onTap: (){
                                           if (status == "User can follow this user") {
                                             follow
                                                 .followAction(
                                                 profileid:
                                                 widget.id.toString(),
                                                 status: 'add')
                                                 .then((value) => followstatus().then((value){
                                               var box = Hive.box("login");
                                               NotificationRepo().notificationSend(type: 'follow', content: '${box.get("name")} started following you', receiverId: widget.id);

                                             }));
                                           } else {
                                             follow.followAction(
                                                 profileid:
                                                 widget.id.toString(),
                                                 status: 'remove')
                                                 .then((value) => followstatus());
                                           }

                                         },
                                         child: Container(
                                           height: 41,
                                           width: MediaQuery.of(context).size.width * 0.37,
                                           decoration: BoxDecoration(
                                               borderRadius:
                                               BorderRadius.circular(
                                                   25),
                                               color: Colors.red),
                                           child:  Center(
                                             child: Padding(
                                               padding: const EdgeInsets.all(12.0),
                                               child: Text(
                                                   status == ""
                                                       ? ""
                                                       : status == "User can follow this user"?
                                                   'অনুসরন করুন':"অনুসরন বাতিল করুন",
                                                   textAlign:
                                                   TextAlign.center,
                                                   style: const TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 12,
                                                     fontWeight:
                                                     FontWeight.normal,
                                                     fontFamily: 'IrabotiMJ',
                                                   )),
                                             ),
                                           ),
                                         ),
                                       ),
                                       // Row(
                                       //   mainAxisAlignment: MainAxisAlignment.center,
                                       //   children: [
                                       //     InkWell(
                                       //       onTap: (){
                                       //         if (status == "User can follow this user") {
                                       //           follow
                                       //               .followAction(
                                       //               profileid:
                                       //               widget.id.toString(),
                                       //               status: 'add')
                                       //               .then((value) => followstatus().then((value){
                                       //             var box = Hive.box("login");
                                       //             NotificationRepo().notificationSend(type: 'follow', content: '${box.get("name")} started following you', receiverId: widget.id);
                                       //
                                       //           }));
                                       //         } else {
                                       //           follow.followAction(
                                       //               profileid:
                                       //               widget.id.toString(),
                                       //               status: 'remove')
                                       //               .then((value) => followstatus());
                                       //         }
                                       //
                                       //       },
                                       //       child: Container(
                                       //         height: 41,
                                       //         width: MediaQuery.of(context).size.width * 0.37,
                                       //         decoration: BoxDecoration(
                                       //             borderRadius:
                                       //             BorderRadius.circular(
                                       //                 25),
                                       //             color: Colors.red),
                                       //         child:  Center(
                                       //           child: Padding(
                                       //             padding: const EdgeInsets.all(12.0),
                                       //             child: Text(
                                       //                 status == ""
                                       //                     ? ""
                                       //                     : status == "User can follow this user"?
                                       //                 'অনুসরন করুন':"অনুসরন বাতিল করুন",
                                       //                 textAlign:
                                       //                 TextAlign.center,
                                       //                 style: TextStyle(
                                       //                   color: Colors.white,
                                       //                   fontSize: 12,
                                       //                   fontWeight:
                                       //                   FontWeight.normal,
                                       //                   fontFamily: 'IrabotiMJ',
                                       //                 )),
                                       //           ),
                                       //         ),
                                       //       ),
                                       //     ),
                                       //     SizedBox(width: 15,),
                                       //     InkWell(
                                       //       onTap: (){
                                       //       //  newPage(context: context, child: MessagePage(applyid: '1', jobid: '1', senderid: box.get('userid'), recvid: widget.id, name:data.fullName!,));
                                       //       },
                                       //       child: Container(
                                       //         height: 41,
                                       //         width: size.width*0.4,
                                       //         decoration: BoxDecoration(
                                       //             borderRadius:
                                       //             BorderRadius.circular(
                                       //                 25),
                                       //             color: Colors.red),
                                       //         child:  Center(
                                       //           child: Padding(
                                       //             padding: const EdgeInsets.all(15.0),
                                       //             child: Text(
                                       //                 "বার্তা পাঠান",
                                       //                 textAlign:
                                       //                 TextAlign.center,
                                       //                 style: TextStyle(
                                       //                   color: Colors.white,
                                       //                   fontSize: 12,
                                       //                   fontWeight:
                                       //                   FontWeight.normal,
                                       //                   fontFamily: 'IrabotiMJ',
                                       //                 )),
                                       //           ),
                                       //         ),
                                       //       ),
                                       //     )
                                       //   ],
                                       // ),
                                       const SizedBox(
                                         height: 10,
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                               Positioned(
                                   top: -55,
                                   child:data.pic == null? Container(
                                     height: 90,
                                     width: 90,
                                     decoration: const BoxDecoration(
                                         shape: BoxShape.circle,
                                         image:DecorationImage(
                                           image: AssetImage(
                                               "assets/unnamed.png"),)
                                         //     :
                                         //  DecorationImage(
                                         //   fit: BoxFit.cover,
                                         //   image: NetworkImage(
                                         //       "$media${data.pic}"),
                                         // )
                         ),
                                   ):
                                   CachedNetworkImage(
                                     imageUrl: "$media${data.pic}",
                                     imageBuilder: (context, imageProvider) => Container(
                                       height: 90.h,
                                       width: 90.w,
                                       decoration: BoxDecoration(
                                         shape: BoxShape.circle,
                                         image: DecorationImage(
                                           image: imageProvider,
                                           fit: BoxFit.cover,
                                         ),
                                       ),
                                     ),
                                     placeholder: (context, url) =>SkeletonAvatar(
                                       style: SkeletonAvatarStyle(
                                         height: 90.h,
                                         width: 90.w,
                                         shape: BoxShape.circle,
                                         borderRadius: BorderRadius.circular(50).w, // Adjust the border radius as needed
                                       ),

                                     ),
                                     errorWidget: (context, url, error) => Icon(Icons.error),
                                   )

                               ),
                             ],
                           );
                         } else {
                           return const Center(
                             child: Text("No User found"),
                           );
                         }
                       },
                     ),
                     // SizedBox(
                     //   height: 15,
                     // ),
                     FutureBuilder<OtherLinkModel?>(
                         future: MylinkRepository().otherLinkRepo(widget.id),
                         builder: (context, ss){
                           if(ss.connectionState == ConnectionState.waiting){
                             return Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.symmetric(horizontal: 10),
                                   child:
                                   SkeletonParagraph(
                                     style: SkeletonParagraphStyle(
                                         lines: 1,
                                         spacing: 2,
                                         lineStyle: SkeletonLineStyle(
                                           randomLength: true,
                                           height: 20,
                                           borderRadius: BorderRadius.circular(8),
                                           minLength: MediaQuery.of(context).size.width / 2,
                                         )),
                                   ),

                                 ),
                                 SizedBox(height: 12.h),
                                 Row(
                                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   children: [
                                     Expanded(
                                       child: SkeletonParagraph(
                                         style: SkeletonParagraphStyle(
                                             lines: 1,
                                             spacing: 2,
                                             lineStyle: SkeletonLineStyle(
                                               randomLength: true,
                                               height: 20.h,
                                               borderRadius: BorderRadius.circular(8).w,
                                               minLength: MediaQuery.of(context).size.width / 2,
                                             )),
                                       ),
                                     ),
                                     Expanded(
                                       child: SkeletonParagraph(
                                         style: SkeletonParagraphStyle(
                                             lines: 1,
                                             spacing: 2,
                                             lineStyle: SkeletonLineStyle(
                                               randomLength: true,
                                               height: 20.h,
                                               borderRadius: BorderRadius.circular(8).w,
                                               minLength: MediaQuery.of(context).size.width / 25,
                                             )),
                                       ),
                                     ),
                                   ],
                                 ),
                                 Row(
                                   children: [
                                     Expanded(
                                       child: SkeletonParagraph(
                                         style: SkeletonParagraphStyle(
                                             lines: 1,
                                             spacing: 2,
                                             lineStyle: SkeletonLineStyle(
                                               randomLength: true,
                                               height: 20.h,
                                               borderRadius: BorderRadius.circular(8).w,
                                               minLength: MediaQuery.of(context).size.width / 25,
                                             )),
                                       ),
                                     ),
                                     SizedBox(
                                       width: 15.h,
                                     ),
                                     Expanded(
                                       child: SkeletonParagraph(
                                         style: SkeletonParagraphStyle(
                                             lines: 1,
                                             spacing: 2,
                                             lineStyle: SkeletonLineStyle(
                                               randomLength: true,
                                               height: 20,
                                               borderRadius: BorderRadius.circular(8),
                                               minLength: MediaQuery.of(context).size.width / 25,
                                             )),
                                       ),
                                     ),


                                   ],
                                 ),
                                 Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                     child:

                                     SkeletonLine(
                                       style: SkeletonLineStyle(
                                           height:150,
                                           width: size.width,
                                           borderRadius: BorderRadius.circular(8)),
                                     )
                                 ),

                                 Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 10),
                                   child: Container(
                                     height: size.height * 0.22,
                                     width: size.width,
                                     // color: Color(0xffD9D9D9),
                                     child: ListView(
                                       scrollDirection: Axis.horizontal,
                                       shrinkWrap: true,
                                       physics: const BouncingScrollPhysics(),
                                       children: [
                                         SkeletonLine(
                                           style: SkeletonLineStyle(
                                               height: size.height * 0.22,
                                               width: 180,
                                               borderRadius: BorderRadius.circular(8)),
                                         ),
                                         SizedBox(width: 10,),
                                         SkeletonLine(
                                           style: SkeletonLineStyle(
                                               height: size.height * 0.22,
                                               width: 180,
                                               borderRadius: BorderRadius.circular(8)),
                                         ),
                                         SizedBox(width: 10.w),
                                         SkeletonLine(
                                           style: SkeletonLineStyle(
                                               height: size.height * 0.22,
                                               width: 180.w,
                                               borderRadius: BorderRadius.circular(8).w
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ),

                               ],
                             );
                           }
                           else if(ss.hasData)
                           {
                             var dataList = ss.data!.msg!;
                             return
                               ListView.builder(
                                   primary: false,
                                   shrinkWrap: true,
                                   itemCount: dataList.length,
                                   itemBuilder:(context, index){
                                     var data = dataList[index];
                                     return
                                       PostListWidget(
                                         hedarText: "${data.jobTitle}",
                                         procolpo: "${data.category}",
                                         postTime: DateTime.parse("${data.createdAt}"),
                                         postName: "${data.createdByName}",
                                         home: true,
                                         connectId: "${data.jobId}",
                                         discription: "${data.description}", audio: data.doc!.audio!.isEmpty?"":data.doc!.audio![0], video: data.doc!.video!.isEmpty?"":data.doc!.video![0], image: data.doc!.image!, ownerId: data.createdBy!, shareLink: "", userID: data.createdBy!,

                                       );
                                   });
                           }
                           else{
                             return
                               Container(
                                 height: size.height*0.1,
                                 width: size.width,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(15),
                                   color: Colors.white,
                                 ),
                                 child: Center(
                                   child: Text("There is no link",
                                       style: TextStyle(
                                         color: Colors.black,
                                         fontSize: 18,
                                       )
                                   ),
                                 ),
                               );
                           }

                         }),
                   ],
                 ),
               )
              ],
            )
          ],
        ),
      ),
    );
  }
}
