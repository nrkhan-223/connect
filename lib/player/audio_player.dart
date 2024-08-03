import 'dart:developer';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

enum AudioSourceOption { Network, Asset }

class AudioPlayers extends StatefulWidget {
  final String audio;

  const AudioPlayers({super.key, required this.audio});

  @override
  State<AudioPlayers> createState() => _AudioPlayersState();
}

class _AudioPlayersState extends State<AudioPlayers> {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _setupAudioPlayer(AudioSourceOption.Network);
  }

  Future<void> _setupAudioPlayer(AudioSourceOption option) async {
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stacktrace) {
      print("A stream error occurred: $e");
    });
    try {
      if (option == AudioSourceOption.Network) {
        await _player.setAudioSource(AudioSource.uri(Uri.parse(
            widget.audio)));
      } else if (option == AudioSourceOption.Asset) {
        await _player.setAudioSource(
            AudioSource.asset("assets/audio/pixabay_audio.mp3"));
      }
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  //
  // Widget _sourceSelect() {
  //   return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
  //     MaterialButton(
  //       color: Colors.purple,
  //       child: Text("Network"),
  //       onPressed: () => _setupAudioPlayer(AudioSourceOption.Network),
  //     ),
  //     MaterialButton(
  //       color: Colors.purple,
  //       child: Text("Asset"),
  //       onPressed: () => _setupAudioPlayer(AudioSourceOption.Asset),
  //     ),
  //   ]);
  // }

  Widget _progessBar() {
    return StreamBuilder<Duration?>(
      stream: _player.positionStream,
      builder: (context, snapshot) {
        return ProgressBar(
          progress: snapshot.data ?? Duration.zero,
          buffered: _player.bufferedPosition,
          total: _player.duration ?? Duration.zero,
          onSeek: (duration) {
            _player.seek(duration);
          },
        );
      },
    );
  }

  Widget _playbackControlButton() {
    log(widget.audio);
    return StreamBuilder<PlayerState>(
        stream: _player.playerStateStream,
        builder: (context, snapshot) {
          final processingState = snapshot.data?.processingState;
          final playing = snapshot.data?.playing;
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 64,
              height: 64,
              child: const CircularProgressIndicator(),
            );
          } else if (playing != true) {
            return IconButton(
              icon: const Icon(Icons.play_arrow),
              iconSize: 64,
              onPressed: _player.play,
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              icon: const Icon(Icons.pause),
              iconSize: 64,
              onPressed: _player.pause,
            );
          } else {
            return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64,
                onPressed: () => _player.seek(Duration.zero));
          }
        });
  }

  Widget _controlButtons() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      StreamBuilder(
          stream: _player.speedStream,
          builder: (context, snapshot) {
            return Row(children: [
              const Icon(
                Icons.speed,
              ),
              Slider(
                  min: 1,
                  max: 3,
                  value: snapshot.data ?? 1,
                  divisions: 3,
                  onChanged: (value) async {
                    await _player.setSpeed(value);
                  })
            ]);
          }),
      StreamBuilder(
          stream: _player.volumeStream,
          builder: (context, snapshot) {
            return Row(children: [
              const Icon(
                Icons.volume_up,
              ),
              Slider(
                  min: 0,
                  max: 3,
                  value: snapshot.data ?? 1,
                  divisions: 4,
                  onChanged: (value) async {
                    await _player.setVolume(value);
                  })
            ]);
          }),
    ]);
  }

  @override
  void dispose() {
    _player.pause;
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Audio Player")),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 50,),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 2,
                      offset:
                          const Offset(0, 2.2), // changes position of shadow
                    ),
                  ],
                ),
                child: Image.asset(
                  isAntiAlias: true,
                  "assets/icon/logo2.png",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 2,
                      offset:
                          const Offset(0, 2.2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _progessBar(),
                    Row(
                      children: [
                        _controlButtons(),
                        _playbackControlButton(),
                      ],
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
