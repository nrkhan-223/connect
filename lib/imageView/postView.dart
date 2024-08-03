import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/link_add/applyLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skeletons/skeletons.dart';
import 'package:video_player/video_player.dart';
import '../Const/const.dart';
import '../Const/route.dart';
import '../player/VideoView.dart';
import '../user_profile/user_profile.dart';

class PostView extends StatefulWidget {
  final List image;
  final String video;
  final String hedarText;
  final String connectId;
  final String postName;
  final String shareLink;
  final String discription;
  final String procolpo;
  final String timeAgo;
  final String ownerId;
  final String audio;
  final bool from;
  final bool check;
  final int page;

  const PostView(
      {super.key,
      required this.image,
      required this.hedarText,
      required this.connectId,
      required this.postName,
      required this.procolpo,
      required this.discription,
      required this.timeAgo,
      required this.ownerId,
      required this.from,
      required this.page,
      required this.shareLink,
      required this.check,
      required this.video,
      required this.audio});

  @override
  State<PostView> createState() => _ImageViewState();
}

class _ImageViewState extends State<PostView>
    with SingleTickerProviderStateMixin {
  var box = Hive.box("login");

  Future<void> share() async {
    await FlutterShare.share(
        title: widget.hedarText,
        text: widget.discription,
        linkUrl: widget.shareLink,
        chooserTitle: widget.hedarText);
  }

  TransformationController controllar = TransformationController();
  TapDownDetails? tapDownDetails;
  int page = 0;
  PageController? pageController;
  AnimationController? animationController;

  Animation<Matrix4>? animation;

  bool isFirstPage() {
    print("fast");
    print(page == 0);
    return page == 0;
  }

  bool isLastPage() {
    print("last");
    print(page == widget.image.length - 1);
    return page == widget.image.length - 1;
  }

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        controllar.value = animation!.value;
      });
    pageController = PageController(
      initialPage: widget.page,
    );
    log(widget.video);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        page = widget.page;
      });
    });
    getData();
    super.initState();
  }

  VideoPlayerController? controllervideo;

  Future getData() async {
    controllervideo = VideoPlayerController.networkUrl(Uri.parse(widget.video))
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    controllar.dispose();
    animationController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.page.toString() + "fuad");
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.hedarText,
          style: const TextStyle(color: Colors.red),
        ),
        actions: [
          InkWell(
            child: const Icon(
              Icons.share_outlined,
              color: Colors.red,
            ),
            onTap: () {
              share();
            },
          ),
          const SizedBox(
            width: 15,
          )
        ],
        elevation: 2,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 24,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title",
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  widget.hedarText,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xffF2F3F4)),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      widget.procolpo,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Post: ",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.3),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  TextSpan(
                      text: widget.timeAgo,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ))
                ])),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    newPage(
                        context: context,
                        child: UserProfilePage(id: widget.ownerId));
                  },
                  child: Text(
                    widget.postName,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Colors.red.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "কানেক্ট আইডি ",
                      style: TextStyle(
                        color: Colors.red.withOpacity(0.6),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'IrabotiMJ',
                      )),
                  TextSpan(
                    text: widget.connectId,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Colors.red.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  )
                ])),
              ],
            ),
          ),
          if (widget.audio != "" ||
              widget.image.isNotEmpty ||
              widget.video != "")
            SizedBox(
              height: size.height * 0.13,
              width: size.width,
              // color: Color(0xffD9D9D9),
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  // const SizedBox(width: 20,),
                  if (widget.audio != "")
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, bottom: 8, left: 5),
                      child: CircleAvatar(
                        radius: 22.w,
                        backgroundColor: Colors.black,
                        child: const Center(child: Icon(Icons.abc)),
                      ),
                    ),
                  SizedBox(
                    width: 15.w,
                  ),
                  if (widget.image.isNotEmpty)
                    for (int img = 0; img < widget.image.length; img++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: CachedNetworkImage(
                          imageUrl: Uri.decodeFull(
                            "$media${widget.image[img]}",
                          ),
                          height: 45,
                          imageBuilder: (context, imageProvider) => Container(
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
                              (context, url, downloadProgress) => SkeletonLine(
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
                                  borderRadius: BorderRadius.circular(25).w),
                              child: const Icon(Icons.error)),
                        ),
                      ),
                  SizedBox(
                    width: 5.w,
                  ),
                  if (widget.video != "")
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
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
                                                procolpo: widget.procolpo,
                                                timeAgo: widget.timeAgo,
                                                postName: widget.postName,
                                                ownerId: widget.ownerId,
                                                connectId: widget.connectId,
                                                discription: widget.discription,
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
          const SizedBox(
            height: 10,
          ),

          // SizedBox(
          //   height: 300,
          //   child: Stack(
          //     children: [
          //       PageView.builder(
          //         itemCount: widget.image.length,
          //         controller: pageController,
          //         onPageChanged: (p) {
          //           setState(() {
          //             page = p;
          //           });
          //           print(page);
          //         },
          //         itemBuilder: (BuildContext context, int index) {
          //           return GestureDetector(
          //               onDoubleTapDown: (details) {
          //                 tapDownDetails = details;
          //               },
          //               onDoubleTap: () {
          //                 const double scale = 3;
          //                 final position = tapDownDetails!.localPosition;
          //                 final x = -position.dx * (scale - 1);
          //                 final y = -position.dy * (scale - 1);
          //                 final zoomed = Matrix4.identity()
          //                   ..translate(x, y)
          //                   ..scale(scale);
          //                 final end = controllar.value.isIdentity()
          //                     ? zoomed
          //                     : Matrix4.identity();
          //                 animation =
          //                     Matrix4Tween(begin: controllar.value, end: end)
          //                         .animate(CurveTween(curve: Curves.easeOut)
          //                         .animate(animationController!));
          //                 animationController!.forward(from: 0);
          //               },
          //               child: InteractiveViewer(
          //                 clipBehavior: Clip.none,
          //                 transformationController: controllar,
          //                 panEnabled: true,
          //                 scaleEnabled: true,
          //                 child: AspectRatio(
          //                   aspectRatio: 1,
          //                   child: CachedNetworkImage(
          //                     imageUrl: Uri.decodeFull(
          //                         "$media${widget.image[index]}"),
          //                     imageBuilder: (context, imageProvider) =>
          //                         Container(
          //                           decoration: BoxDecoration(
          //                             image: DecorationImage(
          //                               image: imageProvider,
          //                             ),
          //                           ),
          //                         ),
          //                     progressIndicatorBuilder:
          //                         (context, url, downloadProgress) =>
          //                         SkeletonLine(
          //                           style: SkeletonLineStyle(
          //                               height: size.height,
          //                               width: size.width,
          //                               borderRadius: BorderRadius.circular(25)),
          //                         ),
          //                     errorWidget: (context, url, error) => Container(
          //                         height: size.height,
          //                         width: size.width,
          //                         decoration: BoxDecoration(
          //                             color: Colors.black.withOpacity(0.2),
          //                             borderRadius: BorderRadius.circular(25)),
          //                         child: const Icon(Icons.error)),
          //                   ),
          //                 ),
          //               ));
          //         },
          //       ),
          //       isLastPage()
          //           ? Container()
          //           : Align(
          //           alignment: Alignment.centerRight,
          //           child: CircleAvatar(
          //             radius: 15,
          //             backgroundColor: Colors.black.withOpacity(0.3),
          //             child: Center(
          //               child: IconButton(
          //                   onPressed: () {
          //                     nextPage();
          //                   },
          //                   icon: const Icon(
          //                     Icons.arrow_forward_ios_outlined,
          //                     size: 13,
          //                   )),
          //             ),
          //           )),
          //       isFirstPage()
          //           ? Container()
          //           : Align(
          //           alignment: Alignment.centerLeft,
          //           child: CircleAvatar(
          //             radius: 15,
          //             backgroundColor: Colors.black.withOpacity(0.3),
          //             child: Center(
          //               child: IconButton(
          //                   onPressed: () {
          //                     previousPage();
          //                   },
          //                   icon: const Icon(
          //                     Icons.arrow_back_ios_new_outlined,
          //                     size: 13,
          //                   )),
          //             ),
          //           ))
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  " Description:",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.6,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    widget.discription,
                    textAlign: TextAlign.start,
                    maxLines: 30,
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          height: 1.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          newPage(
              context: context,
              child: ApplyLinkPage(
                jobId: widget.connectId,
                ownerId: widget.ownerId,
                title: widget.hedarText,
                ownerName: widget.postName,
                time: widget.timeAgo,
                category:widget.procolpo,
              ));
        },
        child: const Text(
          "Apply",
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  nextPage() {
    print("next Page");
    pageController!.animateToPage(pageController!.page!.toInt() + 1,
        duration: const Duration(microseconds: 1), curve: Curves.easeIn);
  }

  previousPage() {
    pageController!.animateToPage(pageController!.page!.toInt() - 1,
        duration: const Duration(milliseconds: 4), curve: Curves.easeIn);
  }
}
