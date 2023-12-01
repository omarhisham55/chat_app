import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_app/core/widgets/text_form_field.dart';
import 'package:chat_app/features/chat_page/presentation/cubit/chat_page_cubit.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart' as fs;
import 'package:permission_handler/permission_handler.dart';

class TypeMessage extends StatefulWidget {
  final User otherUser;
  const TypeMessage({super.key, required this.otherUser});

  @override
  State<TypeMessage> createState() => _TypeMessageState();
}

class _TypeMessageState extends State<TypeMessage> {
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
    checkPermission();
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        isPlaying = false;
        position = Duration.zero;
      }
      isPlaying = event == PlayerState.playing;
      setState(() {});
    });

    audioPlayer.onDurationChanged.listen((event) {
      duration = event;
      position = Duration.zero;
      setState(() {});
    });

    audioPlayer.onPositionChanged.listen((event) {
      position = event;
      setState(() {});
    });
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    audioPlayer.dispose();
    super.dispose();
  }

  Future checkPermission() async {
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<fs.RecordingDisposition>(
      stream: recorder.onProgress,
      builder: (context, snapshot) {
        final duration =
            snapshot.hasData ? snapshot.data!.duration : Duration.zero;
        final twoDigitMinutes =
            duration.inMinutes.remainder(60).toString().padLeft(2, '0');
        final twoDigitSeconds =
            duration.inSeconds.remainder(60).toString().padLeft(2, '0');
        snapshot.hasData
            ? BlocProvider.of<ChatPageCubit>(context).messageController.text =
                "$twoDigitMinutes:$twoDigitSeconds"
            : null;
        return MessagesTextField(
          controller: BlocProvider.of<ChatPageCubit>(context).messageController,
          onSend: () => BlocProvider.of<ChatPageCubit>(context).sendChat(
            context: context,
            receiverId: widget.otherUser.id,
          ),
          record: () => record(),
          finishRecording: () => stop(),
        );
      },
    );
  }
}
