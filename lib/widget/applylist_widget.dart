import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/Const/const.dart';
import 'package:connect/Const/route.dart';
import 'package:connect/imageView/ImageView.dart';
import 'package:connect/user_profile/user_profile.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletons/skeletons.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import '../model/getpic_model.dart';
import '../network/getFrndProdfile.dart';
import '../player/VideoView.dart';
import '../controllar/myLink_controller/myLink_controller.dart';
import '../imageView/postView.dart';
import '../player/audio_player.dart';

class ApplyListWidget extends StatefulWidget {
  final String hedarText;
  final String? procolpo;
  final DateTime postTime;
  final String applyTime;
  final String postName;
  final String connectId;
  final String discription;
  final String audio;
  final String video;
  final String ownerId;
  final String userID;
  final List image;
  final bool home;
  final int? index;
  final String shareLink;
  final Function? delete;
  final String? categoryId;

  const ApplyListWidget({
    super.key,
    required this.hedarText,
    required this.procolpo,
    required this.postTime,
    required this.userID,
    required this.postName,
    required this.connectId,
    required this.discription,
    required this.audio,
    required this.video,
    required this.image,
    required this.home,
    required this.ownerId,
    this.index,
    required this.shareLink,
    this.delete,
    this.categoryId,
    required this.applyTime,
  });

  @override
  State<ApplyListWidget> createState() => _ApplyListWidgetState();
}

class _ApplyListWidgetState extends State<ApplyListWidget> {
  List<Getprofile> usersPic = [];
   Future<List<Getprofile>>getUsers()async{
    var url = '$BaseUrl/user/profile/${widget.ownerId}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final result = json['msg']as List<dynamic>;
    final userspic=result.map((e) => Getprofile.fromJson(e)).toList();
    return userspic;
  }
   Future<void> getUser() async {
     final response = await getUsers();
     setState(() {
       usersPic = response;
     });
   }


  var audioplay = false;
  final player = AudioPlayer();
  Duration? duration;
  ScrollController lodingControllar = ScrollController();

  VideoPlayerController? controllervideo;

  List<PopupMenuEntry<dynamic>> list = [];
  CustomPopupMenuController popcontroller = CustomPopupMenuController();
  String? thumb;
  Map<String, dynamic> _map = {};
  var dataGet = true;

  Future getData() async {
    controllervideo = VideoPlayerController.networkUrl(Uri.parse(widget.video))
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  bool _error = true;

  Future fetchdata(String id) async {
    String api = "$BaseUrl/job/jobapplylisting/$id";
    var headers = {
      'Cookie': 'ci_session=48992169d438e8d18248cc6d509f325251184d7e'
    };
    var res = await http.get(Uri.parse(api), headers: headers);

    if (res.statusCode == 200) {
      try {
        _map = jsonDecode(res.body);
        setState(() {});
        _error = false;
      } catch (e) {
        _map = {};
        _error = true;
      }
    } else {
      _error = true;

      _map = {};
    }
  }

  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(widget.postTime);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '১ সপ্তাহ আগে' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} দিন আগে';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '১ দিন আগে' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} ঘণ্টা আগে';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '১ ঘণ্টা আগে' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} মিনিট আগে';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '১ মিনিট আগে' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} সেকেন্ড আগে';
    } else {
      return 'এই মাত্র';
    }
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: widget.hedarText,
        text: widget.discription,
        linkUrl: widget.shareLink,
        chooserTitle: widget.hedarText);
  }

  @override
  void initState() {
    print("Video Link data ${widget.video}");
    // if (widget.audio != "") {
    //   player.setUrl("$media${widget.audio}").then((value) {});
    // }
    if (widget.video != "") {
      getData();
      print("pathFuad...${thumb ?? ""} $dataGet");
    }
    if (widget.home == false) {
      fetchdata(widget.connectId);
    }

    super.initState();
  }

  @override
  void dispose() {
    controllervideo?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final controller = Provider.of<MyLinkContrllar>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0,left: 5),
              child: SizedBox(width: 50,height: 50,
                child: CircleAvatar(
                  radius: 12,
                  child: Image.asset('assets/unnamed.png'),
                ),

              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          newPage(
                              context: context,
                              child: PostView(
                                image: widget.image,
                                shareLink: widget.shareLink,
                                hedarText: widget.hedarText,
                                connectId: widget.connectId,
                                postName: widget.postName,
                                discription: widget.discription,
                                check: widget.home,
                                procolpo: widget.procolpo ?? '',
                                timeAgo: timeAgo(),
                                ownerId: widget.ownerId,
                                from: false,
                                page: 1,
                                video: widget.video,
                                audio: widget.audio,
                              ));
                        },
                        child: SizedBox(
                          width: size.width * 0.6,
                          child: Text(
                            widget.hedarText,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.5.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: timeAgo(),
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                              ),
                            ))
                      ])),
                      SizedBox(
                        width: 5.w,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "কাজ করতে সময় লাগবে: ",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          fontWeight: FontWeight.w400,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    TextSpan(
                        text: widget.applyTime,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                          ),
                        ))
                  ])),
                ),
                SizedBox(height: 3.h),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          newPage(
                              context: context,
                              child: UserProfilePage(
                                id: widget.ownerId,
                              ));
                        },
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "মালিকের আইডি:",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'IrabotiMJ',
                              )),
                          TextSpan(
                            text: widget.ownerId,
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                              ),
                            ),
                          )
                        ])),
                      ),
                      SizedBox(width: 10.w),
                      InkWell(
                        onTap: () {
                          newPage(
                              context: context,
                              child: PostView(
                                image: widget.image,
                                shareLink: widget.shareLink,
                                hedarText: widget.hedarText,
                                connectId: widget.connectId,
                                postName: widget.postName,
                                discription: widget.discription,
                                check: widget.home,
                                procolpo: widget.procolpo ?? '',
                                timeAgo: timeAgo(),
                                ownerId: widget.ownerId,
                                from: false,
                                page: 1,
                                video: widget.video,
                                audio: widget.audio,
                              ));
                        },
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "কানেক্ট আইডি :",
                              style: TextStyle(
                                color: Colors.red.withOpacity(0.6),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'IrabotiMJ',
                              )),
                          TextSpan(
                            text: widget.connectId,
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: Colors.red.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                              ),
                            ),
                          )
                        ])),
                      ),
                      SizedBox(width: 10.w),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                Container(
                  width: size.width-100,
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: ReadMoreText(
                    widget.discription,
                    textAlign: TextAlign.start,
                    trimMode: TrimMode.Length,
                    trimLength: 80,
                    colorClickableText: Colors.red,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        height: 1.3.h,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ),
                if (widget.audio != "" ||
                    widget.image.isNotEmpty ||
                    widget.video != "")
                  SizedBox(
                    height: size.height * 0.13,
                    width: size.width-100,
                    // color: Color(0xffD9D9D9),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        // const SizedBox(width: 20,),
                        if (widget.audio != "")
                          InkWell(
                            onTap: () {
                              newPage(
                                  context: context,
                                  child:
                                      AudioPlayers(audio: "$media${widget.audio}"));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 4),
                              child: Container(
                                width: size.width / 5.1,
                                height: 15,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: const Center(
                                    child: Icon(
                                  Icons.audiotrack,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          ),
                        SizedBox(
                          width: 8.w,
                        ),
                        if (widget.image.isNotEmpty)
                          for (int img = 0; img < widget.image.length; img++)
                            InkWell(
                              onTap: () {
                                newPage(
                                    context: context,
                                    child: ImageView(
                                      image: widget.image,
                                      shareLink: widget.shareLink,
                                      hedarText: widget.hedarText,
                                      connectId: widget.connectId,
                                      postName: widget.postName,
                                      discription: widget.discription,
                                      procolpo: widget.procolpo ?? '',
                                      timeAgo: timeAgo(),
                                      ownerId: widget.ownerId,
                                      from: false,
                                      page: img,
                                      check: widget.home,
                                      video: widget.video,
                                      audio: widget.audio,
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: CachedNetworkImage(
                                  imageUrl: Uri.decodeFull(
                                    "$media${widget.image[img]}",
                                  ),
                                  height: 45,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 45.h,
                                    width: 75.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          SkeletonLine(
                                    style: SkeletonLineStyle(
                                        height: 80,
                                        width: 75.w,
                                        borderRadius: BorderRadius.circular(15)),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                      height: 45,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(25).w),
                                      child: const Icon(Icons.error)),
                                ),
                              ),
                            ),
                        SizedBox(
                          width: 5.w,
                        ),
                        if (widget.video != "")
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: SizedBox(
                              height: 55,
                              width: 85.w,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: controllervideo == null
                                      ? SkeletonLine(
                                          style: SkeletonLineStyle(
                                              height: size.height * 0.22,
                                              width: 75.w,
                                              borderRadius:
                                                  BorderRadius.circular(15).w),
                                        )
                                      : Stack(
                                          alignment: AlignmentDirectional.center,
                                          children: [
                                            VideoPlayer(controllervideo!),
                                            ElevatedButton(
                                              onPressed: () {
                                                newPage(
                                                    context: context,
                                                    child: VideoViewPage(
                                                      link: "$media${widget.video}",
                                                      hedarText: widget.hedarText,
                                                      procolpo:
                                                          widget.procolpo ?? '',
                                                      timeAgo: timeAgo(),
                                                      postName: widget.postName,
                                                      ownerId: widget.ownerId,
                                                      connectId: widget.connectId,
                                                      discription:
                                                          widget.discription,
                                                    ));
                                              },
                                              // styling the button
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: const Size(45, 45),
                                                shape: const CircleBorder(),
                                                // Button color
                                                backgroundColor: Colors.white,
                                                // Splash color
                                                foregroundColor: Colors.cyan,
                                              ),
                                              // icon of the button
                                              child: Center(
                                                child: Icon(
                                                  Icons.play_arrow_outlined,
                                                  color: Colors.black,
                                                  size: 30.w,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                            ),
                          ),
                      ],
                    ),
                  ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 1.2,
                  color: Colors.black.withOpacity(0.3),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            InkWell(
                              onTap: () {
                                share();
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/sahre.svg",
                                    height: 18.h,
                                    width: 18.w,
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                    'শেয়ার',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.inter(
                                      color: Colors.black.withOpacity(0.3),
                                      fontSize: 11.sp,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String prettyDuration(Duration d) {
    var min = d.inMinutes < 10 ? "0${d.inMinutes}" : d.inMinutes.toString();
    var sec = d.inSeconds < 10 ? "0${d.inSeconds}" : d.inSeconds.toString();
    return "$min:$sec";
  }
}
