
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../Const/const.dart';

class AudioView extends StatefulWidget {
  final String audio;
  const AudioView({super.key, required this.audio});

  @override
  State<AudioView> createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> {
  final player = AudioPlayer();
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: 10),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.black,
        child: SizedBox(height:30,width:30,child: Text("audio"),)
      ),
    );
  }
}
