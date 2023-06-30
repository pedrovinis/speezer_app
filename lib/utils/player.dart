import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class AudioManager {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration totalDuration = const Duration();
  Duration currentPosition = const Duration();
  Timer? positionTimer;

  Future<void> playAudio(String source) async {
    // await stopAudio();
    await audioPlayer.play(source, isLocal: true);
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();

    isPlaying = false;
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();

    isPlaying = false;
    currentPosition = Duration();
  }

  void startPositionTracker() {
    positionTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (isPlaying) {
        currentPosition = timer.tick as Duration;
      }
    });
  }

  void disposeAudioPlayer() {
    audioPlayer.dispose();
    positionTimer?.cancel();
  }
}
