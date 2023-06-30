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
    await audioPlayer.play(UrlSource(source));
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  void disposeAudioPlayer() {
    audioPlayer.dispose();
    positionTimer?.cancel();
  }
}
