import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAudio(String source) async {
    await audioPlayer.play(UrlSource("assets/audio/$source"));
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  Future<void> setCurrentPosition(Duration duration) async {
    await audioPlayer.seek(duration);
  }

  void disposeAudioPlayer() {
    audioPlayer.dispose();
  }
}
