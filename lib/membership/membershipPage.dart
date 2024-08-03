import 'dart:async';
import 'package:connect/Const/route.dart';
import 'package:connect/aamarpay/aamarpay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controllar/membershipUpdate/membershipUpdate.dart';
import '../controllar/userprofileController/userProfileController.dart';

class MemberShipPage extends StatefulWidget {
  final String mambershipName;

  const MemberShipPage({super.key, required this.mambershipName});

  @override
  State<MemberShipPage> createState() => _MemberShipPageState();
}

class _MemberShipPageState extends State<MemberShipPage> {
  Map<String, dynamic>? paymentIntentData;
  var loader = true;

  @override
  void initState() {
    final membershipUpdate =
        Provider.of<MembershipUpdate>(context, listen: false);
    Timer.run(() {
      membershipUpdate
          .load(widget.mambershipName, context)
          .then((value) => loader = false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final profile = Provider.of<ProfileProvider>(context, listen: true);
    final membershipUpdate =
        Provider.of<MembershipUpdate>(context, listen: true);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 25),
          child: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10).r,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 25.w,
                  color: Colors.black,
                ),
              ),
            ),
            centerTitle: true,
            title: const Text('মেম্বারশীপ',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'IrabotiMJ',
                )),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: loader
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Image.asset(
                      "assets/backgroundImage.png",
                      fit: BoxFit.cover,
                    )),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.15),
                      membershipUpdate.selectIndex == 0
                          ? SvgPicture.asset(
                              "assets/silverBox.svg",
                            )
                          : membershipUpdate.selectIndex == 1
                              ? SvgPicture.asset(
                                  "assets/memberShipBox.svg",
                                )
                              : SvgPicture.asset(
                                  "assets/diamontBox.svg",
                                ),
                      profile.loder
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15, left: 20, right: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.red.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 2,
                                          offset: const Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Table(
                                      border: TableBorder.all(
                                          color: Colors.black.withOpacity(0.05),
                                          width: 1.5,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      columnWidths: const {
                                        0: FlexColumnWidth(120),
                                        1: FlexColumnWidth(90),
                                        2: FlexColumnWidth(90),
                                        3: FlexColumnWidth(90)
                                      },
                                      children: [
                                        TableRow(children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0, right: 8, top: 25),
                                            child: Text("লিমিটেশনস",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  // fontFamily: 'IrabotiMJ',
                                                )),
                                          ),
                                          for (var i = 0;
                                              i <
                                                  profile.membershipModel!.msg!
                                                      .length;
                                              i++)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                      profile.membershipModel!
                                                          .msg![i].title!,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 16,
                                                        // fontFamily: 'IrabotiMJ',
                                                      )),
                                                  Text(
                                                      "${profile.membershipModel!.msg![i].price!}৳/মাস",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Inter',
                                                      )),
                                                ],
                                              ),
                                            ),
                                        ]),
                                        TableRow(children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("লিংক লিমিট",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  // fontFamily: 'IrabotiMJ',
                                                )),
                                          ),
                                          for (var j = 0;
                                              j <
                                                  profile.membershipModel!.msg!
                                                      .length;
                                              j++)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                profile.membershipModel!.msg![j]
                                                    .privilege!.postLimit
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                    color: Colors.black,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: 'IrabotiMJ',
                                                    fontSize: 15.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ]),
                                        TableRow(children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("এপ্লাই লিমিট",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  // fontFamily: 'IrabotiMJ',
                                                )),
                                          ),
                                          for (var j = 0;
                                              j <
                                                  profile.membershipModel!.msg!
                                                      .length;
                                              j++)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  profile
                                                      .membershipModel!
                                                      .msg![j]
                                                      .privilege!
                                                      .applyLimit
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontFamily: 'Inter',
                                                  )),
                                            ),
                                        ]),
                                        TableRow(children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("ক্যাটাগরি",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                )),
                                          ),
                                          for (var j = 0;
                                              j <
                                                  profile.membershipModel!.msg!
                                                      .length;
                                              j++)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  profile
                                                      .membershipModel!
                                                      .msg![j]
                                                      .privilege!
                                                      .category
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontFamily: 'Inter',
                                                  )),
                                            ),
                                        ]),
                                        TableRow(children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("ফোন এক্সেস",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  // fontFamily: 'IrabotiMJ',
                                                )),
                                          ),
                                          for (var j = 0;
                                              j <
                                                  profile.membershipModel!.msg!
                                                      .length;
                                              j++)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  profile.membershipModel!
                                                      .msg![j].privilege!.phone
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontFamily: 'Inter',
                                                  )),
                                            ),
                                        ]),
                                        TableRow(children: [
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.sp,
                                                    fontFamily: 'IrabotiMJ',
                                                  )),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // update(0);
                                              newPage(
                                                  context: context,
                                                  child: MyPay(
                                                      index: 0,
                                                      membershipName: widget
                                                          .mambershipName));
                                            },
                                            child: Center(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0)
                                                          .r,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top: 7,
                                                        bottom: 1.5,left: 7,right: 7),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.red),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: membershipUpdate
                                                                  .selectIndex ==
                                                              0
                                                          ? Colors.red
                                                          : Colors.white60,
                                                    ),
                                                    child: Center(
                                                      child: Text("নির্বাচন",
                                                          style: TextStyle(
                                                            color: membershipUpdate
                                                                        .selectIndex ==
                                                                    0
                                                                ? Colors.red
                                                                : Colors.red,
                                                            fontSize: 13,
                                                            // fontFamily: 'IrabotiMJ',
                                                          )),
                                                    ),
                                                  )

                                                  // Text(membershipUpdate.selectIndex==0?"Selected":"Select",style: TextStyle(
                                                  //   color: membershipUpdate.selectIndex==0?Colors.black:Colors.red,
                                                  //   fontSize: 14.sp,
                                                  //   // fontFamily: 'IrabotiMJ',
                                                  // )),
                                                  ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // update(1);
                                              newPage(
                                                  context: context,
                                                  child: MyPay(
                                                    index: 1,
                                                    membershipName:
                                                        widget.mambershipName,
                                                  ));
                                            },
                                            child: Center(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0)
                                                          .r,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top: 7,
                                                        bottom: 1.5,left: 7,right: 7),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.red),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: membershipUpdate
                                                                  .selectIndex ==
                                                              1
                                                          ? Colors.red
                                                          : Colors.white60,
                                                    ),
                                                    child:  Center(
                                                      child: Text("নির্বাচন",
                                                          style: TextStyle(
                                                            color: membershipUpdate
                                                                .selectIndex ==
                                                                1
                                                                ? Colors.white
                                                                : Colors.red,
                                                            fontSize: 13,
                                                            // fontFamily: 'IrabotiMJ',
                                                          )),
                                                    ),
                                                  )

                                                  // Text(membershipUpdate.selectIndex==1?"Selected":"Select",style: TextStyle(
                                                  //   color: membershipUpdate.selectIndex==1?Colors.black:Colors.red,
                                                  //   fontSize: 14.sp,
                                                  //   // fontFamily: 'IrabotiMJ',
                                                  // )),
                                                  ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // update(2);
                                              newPage(
                                                  context: context,
                                                  child: MyPay(
                                                      index: 2,
                                                      membershipName: widget
                                                          .mambershipName));
                                            },
                                            child: Center(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0)
                                                          .r,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top: 7,
                                                        bottom: 1.5,left: 7,right: 7),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.red),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: membershipUpdate
                                                                  .selectIndex ==
                                                              2
                                                          ? Colors.red
                                                          : Colors.white60,
                                                    ),
                                                    child:  Center(
                                                        child: Text("নির্বাচন",
                                                            style: TextStyle(
                                                              color: membershipUpdate
                                                                  .selectIndex ==
                                                                  2
                                                                  ? Colors.white
                                                                  : Colors.red,
                                                              fontSize: 13,
                                                              // fontFamily: 'IrabotiMJ',
                                                            )),)
                                                  )

                                                  // Text( membershipUpdate.selectIndex==2?"Selected":"Select",style: TextStyle(
                                                  //   color:  membershipUpdate.selectIndex==2?Colors.black:Colors.red,
                                                  //   fontSize: 14.sp,
                                                  //   // fontFamily: 'IrabotiMJ',
                                                  // )),
                                                  ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                                //   child: InkWell(
                                //     onTap: (){
                                //       update();
                                //     },
                                //     child: Container(
                                //       height: 41,
                                //       width: 285,
                                //       decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.circular(51),
                                //           color: Color(0xffE51D20)
                                //       ),
                                //       child:Center(
                                //         child: Text(
                                //             "Upgrade Membership",
                                //             textAlign: TextAlign.center,
                                //             style: TextStyle(
                                //               color: Colors.white,
                                //               fontSize: 15,
                                //
                                //             )
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
