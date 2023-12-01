import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart' as fs;
import 'package:permission_handler/permission_handler.dart';

class RecordTest extends StatefulWidget {
  const RecordTest({super.key});

  @override
  State<RecordTest> createState() => _RecordTestState();
}

class _RecordTestState extends State<RecordTest> {
  final recorder = fs.FlutterSoundRecorder();
  bool isRecordingReady = false;
  File? finalAudioFile;

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    initRecorder();
    // setAudio();

    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        if (event == PlayerState.completed) {
          isPlaying = false;
          position = Duration.zero;
        }
        isPlaying = event == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
        position = Duration.zero;
      });
    });

    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    audioPlayer.dispose();
    super.dispose();
  }

  // Future setAudio() async {
  //   // String url =
  //   //     "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";

  //   // audioPlayer.play(UrlSource(url));
  //   if (finalAudioFile == null) return;
  //   audioPlayer.setSourceUrl(finalAudioFile!.path);
  // }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw "Microphone permission not granted";
    }
    await recorder.openRecorder();

    isRecordingReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  Future record() async {
    try {
      if (!isRecordingReady) return;
      Constants.showToast(msg: "started recording");
      await recorder.startRecorder(toFile: 'audio');
    } catch (error) {
      Constants.showToast(msg: error.toString());
    }
  }

  Future stop() async {
    if (!isRecordingReady) return;
    Constants.showToast(msg: "Recording stopped");
    final path = await recorder.stopRecorder();
    finalAudioFile = File(path!);

    // print("Recorded audio: $audioFile");
  }

  String _formatTime(Duration duration) {
    final hours = duration.inHours.remainder(60).toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<fs.RecordingDisposition>(
              stream: recorder.onProgress,
              builder: (context, snapshot) {
                final duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;
                final twoDigitMinutes =
                    duration.inMinutes.remainder(60).toString().padLeft(2, '0');
                final twoDigitSeconds =
                    duration.inSeconds.remainder(60).toString().padLeft(2, '0');
                return Text(
                  "$twoDigitMinutes:$twoDigitSeconds",
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                if (recorder.isRecording) {
                  await stop();
                  if (finalAudioFile == null) return;
                  audioPlayer.setSourceUrl(finalAudioFile!.path);
                  audioPlayer.setReleaseMode(ReleaseMode.stop);
                } else {
                  await record();
                }
                setState(() {});
              },
              child: Icon(
                recorder.isRecording ? Icons.stop : Icons.mic,
              ),
            ),
            const SizedBox(height: 32),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final slidePosition = Duration(seconds: value.toInt());
                await audioPlayer.seek(slidePosition);
                await audioPlayer.resume();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatTime(position)),
                  Text(_formatTime(duration - position)),
                ],
              ),
            ),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.resume();
                  }
                  isPlaying = !isPlaying;
                  setState(() {});
                },
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                iconSize: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
