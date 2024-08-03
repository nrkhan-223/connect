import 'dart:developer';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class VideoViewPage extends StatefulWidget {
  final String link;
  final String hedarText;
  final String procolpo;
  final String timeAgo;
  final String postName;
  final String ownerId;
  final String connectId;
  final String discription;

  const VideoViewPage({super.key,
    required this.link,
    required this.hedarText,
    required this.procolpo,
    required this.timeAgo,
    required this.postName,
    required this.ownerId,
    required this.connectId,
    required this.discription});

  @override
  State<VideoViewPage> createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  late CustomVideoPlayerController customVideoPlayerController;
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  bool isLoading = true;

  void initialize() {
    log("videoplay:${widget.link}");
    videoPlayerController =
    VideoPlayerController.networkUrl(Uri.parse(widget.link))
      ..initialize().then((onValue) {
        setState(() {
          isLoading=false;
        });
      });
    customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: videoPlayerController);
  }
  @override
  void dispose() {
    super.dispose();
    videoPlayerController.pause();
    initialize();
    customVideoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          body: isLoading ? const Center(child: CircularProgressIndicator(
            color: Colors.red,),): CustomVideoPlayer(
            customVideoPlayerController: customVideoPlayerController,
          )
      ),
    );
  }
}
