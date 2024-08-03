import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/imageView/ImageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skeletons/skeletons.dart';
import '../Const/const.dart';
import '../Const/route.dart';
import '../message/messagepage.dart';
import '../model/ApplyListModel/ApplyListModek.dart';
import '../network/ApplyList/list.dart';
import '../user_profile/user_profile.dart';
import '../widget/audioView.dart';
import '../widget/thumbView.dart';

class ApplyListPage extends StatefulWidget {
  final String id;
  final String applyid;
  final String counetname;

  const ApplyListPage(
      {super.key,
      required this.id,
      required this.counetname,
      required this.applyid});

  @override
  State<ApplyListPage> createState() => _ApplyListPageState();
}

class _ApplyListPageState extends State<ApplyListPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var box = Hive.box('login');
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.transparent,
        title: const Text("এপ্লিকেশন লিস্ট",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 14, fontFamily: 'IrabotiMJ', color: Colors.black)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 6).r,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 23.w,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Stack(
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
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "assets/icon/logo2.png",
                  scale: 4,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "প্রস্তাবনার নাম: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        widget.counetname,
                        maxLines: 1,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder<ApplyListModel?>(
                  future: JobApplyListRepo().applyList(widget.id),
                  builder: (context, ss) {
                    if (ss.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (ss.hasData) {
                      print('ApplicetionListPost ID :${widget.id}');
                      var dataList = ss.data!.msg!;
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: ListView.builder(
                            itemCount: dataList.length,
                            primary: false,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              var data = dataList[index];
                              return Card(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        newPage(
                                            context: context,
                                            child: UserProfilePage(
                                              id: data.userId.toString(),
                                            ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "আবেদনকারী নাম : ${data.applicantName}",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "সময়ঃ ${data.time}",
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  print(data.ownerId! + "fuad");
                                                  print(data.userId! + "fuad");
                                                  newPage(
                                                      context: context,
                                                      child: MessagePage(
                                                        applyid: data.applyId!,
                                                        jobid: data.jobId!,
                                                        senderid:
                                                            box.get('userid'),
                                                        recvid: data.userId!,
                                                        name:
                                                            data.applicantName!,
                                                      ));
                                                },
                                                child: Container(
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.red),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "মেসেজ দিন",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.inter(
                                                        textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 11.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  directcall(data.applicantPhone
                                                      .toString());

                                                  // print(data.ownerId!+"fuad");
                                                  // print(data.userId!+"fuad");
                                                  // newPage(context: context, child: MessagePage(applyid: data.applyId!, jobid: data.jobId!, senderid: box.get('userid'), recvid: data.userId!, name:data.applicantName!,));
                                                },
                                                child: Container(
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.red),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16,
                                                            right: 16,
                                                            top: 8,
                                                            bottom: 8),
                                                    child: Text(
                                                      "কল দিন",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.inter(
                                                        textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 11.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        "নোটঃ ${data.note}",
                                        textAlign: TextAlign.start,
                                        maxLines: 300,
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            height: 2.h,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (data.doc!.audio!.first != "" ||
                                        data.doc!.image!.isNotEmpty ||
                                        data.doc!.video!.first != "")
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: SizedBox(
                                          height: size.height * 0.13,
                                          width: size.width,
                                          // color: Color(0xffD9D9D9),
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            children: [
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              if (data.doc!.audio!.first != "")
                                                AudioView(
                                                  audio: data.doc!.audio!.first,
                                                ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              if (data.doc!.image!.isNotEmpty)
                                                for (int img = 0;
                                                    img <
                                                        data.doc!.image!.length;
                                                    img++)
                                                  InkWell(
                                                    onTap: () {
                                                      newPage(
                                                          context: context,
                                                          child: ImageView(
                                                            image: data
                                                                .doc!.image!,
                                                            shareLink: "",
                                                            hedarText: "",
                                                            connectId: "",
                                                            postName: "",
                                                            discription: "",
                                                            procolpo: "",
                                                            timeAgo: "",
                                                            ownerId: "",
                                                            from: true,
                                                            page: img,
                                                            check: true,
                                                            video: '',
                                                            audio: '',
                                                          ));
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: Uri.decodeFull(
                                                            "$media${data.doc!.image![img]}"),
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          height: size.height *
                                                              0.22,
                                                          width: 75,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                SkeletonLine(
                                                          style: SkeletonLineStyle(
                                                              height:
                                                                  size.height *
                                                                      0.22,
                                                              width: 180,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25)),
                                                        ),
                                                        errorWidget: (context, url, error) => Container(
                                                            height:
                                                                size.height *
                                                                    0.22,
                                                            width: 180.w,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.2),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25)),
                                                            child: const Icon(
                                                                Icons.error)),
                                                      ),
                                                    ),
                                                  ),
                                              //fff jjjj jjjj
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              if (data.doc!.video!.first != "")
                                                ThumbView(
                                                  video: data.doc!.video!.first,
                                                )
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }),
                      );
                    } else {
                      return Center(
                        child: Text("No Job found"),
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  directcall(String phonenumber) async {
    // const number = phonenumber; //set the number here
    await FlutterPhoneDirectCaller.callNumber(phonenumber);
  }
}
