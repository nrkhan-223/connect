import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../Const/const.dart';
import '../Const/route.dart';
import '../player/VideoView.dart';

class ThumbView extends StatefulWidget {
  final String video;

  const ThumbView({super.key, required this.video});

  @override
  State<ThumbView> createState() => _ThumbViewState();
}

class _ThumbViewState extends State<ThumbView> {
  String? thumb;

  var dataGet = true;

  getData() async {
    await VideoThumbnail.thumbnailFile(
      video: "$media${widget.video}",
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
    ).then((value) {
      setState(() {
        thumb = value;
        dataGet = false;
      });
    });
  }

  @override
  void initState() {
    if (widget.video != "") {
      getData();
      print("pathFuad...${thumb ?? ""} $dataGet");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.22,
      width: 75.w,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: dataGet
              ? SkeletonLine(
                  style: SkeletonLineStyle(
                      height: size.height * 0.22,
                      width: 180,
                      borderRadius: BorderRadius.circular(15)),
                )
              : Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.file(
                      File(thumb!),
                      height: size.height * 0.22,
                      width: 180,
                      fit: BoxFit.cover,
                      color: const Color(0xffD9D9D9).withOpacity(0.6),
                      colorBlendMode: BlendMode.modulate,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        newPage(
                            context: context,
                            child: VideoViewPage(
                              link: "$media${widget.video}",
                              hedarText: "",
                              procolpo: "",
                              timeAgo: "",
                              postName: "",
                              ownerId: "",
                              connectId: "",
                              discription: "",
                            ));
                      },

                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(45, 45),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.cyan,
                      ),
                      //icon of the button
                      child: const Center(
                        child: Icon(
                          Icons.play_arrow_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                )),
    );
  }
}
