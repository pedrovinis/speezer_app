import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:speezer_app/data/musics.dart';
import 'package:speezer_app/models/music.dart';

class AudioManager {
  AudioPlayer audioPlayer = AudioPlayer();
  late Music music = musics[0];

  Future<void> playMusic() async {
    String source = music.audioSource;
    await audioPlayer.play(UrlSource("assets/audio/$source"));
  }

  Future<void> pauseMusic() async {
    await audioPlayer.pause();
  }

  Future<void> resumeMusic() async {
    await audioPlayer.resume();
  }

  Future<void> stopMusic() async {
    await audioPlayer.stop();
  }

  Future<void> setCurrentPosition(Duration duration) async {
    await audioPlayer.seek(duration);
  }

  void setSelectedMusic(Music _music) {
    music = _music;
  }

  void disposeAudioPlayer() {
    audioPlayer.dispose();
  }
}
