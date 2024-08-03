import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../controllar/addlinkPage_controllar/addlinkPage_controllar.dart';
import '../network/fileUpload/upload.dart';

class RecordExample extends StatefulWidget {
  const RecordExample({super.key});

  @override
  State<RecordExample> createState() => _RecordExampleState();
}

bool isAudioUpload = false;

class _RecordExampleState extends State<RecordExample> {
  Duration duration = const Duration();
  var joinpath;
  Timer? timer;
  String? recordingPath;
  bool isRecoding = false;
  bool recordEnd = false;
  AudioRecorder audioRecorder = AudioRecorder();
  UploadFile fileUpload = UploadFile();
  late Record audioRecord;
  String? _filePath;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTimer());
  }

  void stopTimer() {
    timer?.cancel();
  }

  void addTimer() {
    const addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final second = twoDigits(duration.inSeconds.remainder(120));
    final minute = twoDigits(duration.inMinutes.remainder(2));
    final controller = Provider.of<AddLinkControllar>(context, listen: true);
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 10,),
        Image.asset("assets/icon/logo2.png",scale: 4.4,),
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                '$minute:$second',
                style: const TextStyle(fontSize: 22, color: Colors.black),
              ),
              const SizedBox(height: 15,),
              Image.asset("assets/icon/circle.png",scale: 5.5,),
              const SizedBox(height: 20,),
              if (recordEnd != true)
                ElevatedButton(
                  onPressed: () async {
                    if (isRecoding) {
                      stopTimer();
                      await audioRecorder.stop();
                      if (_filePath != null) {
                        setState(() {
                          recordEnd = true;
                          recordingPath = _filePath;
                        });
                      }
                    } else {
                      if (await audioRecorder.hasPermission()) {
                        startTimer();
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final filePath =
                            '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.mp3';
                        await audioRecorder.start(
                            const RecordConfig(),
                            path: filePath);
                        setState(() {
                          isRecoding = true;
                          recordingPath = null;
                          _filePath = filePath;
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(isRecoding ? "Stop Recoding" : "start record",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )),
                ),
              if (recordEnd)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () async {
                          if (recordingPath != null) {
                            joinpath = recordingPath;
                           var path2=path.basename(joinpath);
                            controller.changeAudio(File(path2));
                            await fileUpload
                                .uploadAudio(File(joinpath))
                                .then((v) {
                              setState(() {
                                isAudioUpload = true;
                                log("path2:$path2");
                              });
                            });
                            // await fileUpload
                            //     .uploaddile(joinpath.path)
                            //     .then((value) {
                            //   setState(() {
                            //     isAudioUpload = true;
                            //     log(joinpath);
                            //   });
                            // });
                            Navigator.pop(context, 'r');
                            print("DDDD>>$joinpath");
                          }
                        },
                        child: const Icon(
                          Icons.done_all,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          setState(() {
                            isAudioUpload = false;
                            Navigator.pop(context);
                          });
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        )),
                  ],
                )
            ],
          ),
        ),
      ],
    ));
  }
}
