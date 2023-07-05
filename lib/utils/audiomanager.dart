import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:speezer_app/data/musics.dart';
import 'package:speezer_app/models/music.dart';

class AudioManager {
  AudioPlayer audioPlayer = AudioPlayer();
  late Music music = musics[0];

  Future<void> playMusic() async {
    String source = music.audioSource;
    await audioPlayer.play("assets/audio/$source", isLocal: true);
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

  void playNextMusic() {
    int nextMusicIndex = musics
            .indexWhere((element) => music.audioSource == element.audioSource) +
        1;

    bool nextDoesntExist = nextMusicIndex >= musics.length;
    if (nextDoesntExist) nextMusicIndex = 0;

    music = musics[nextMusicIndex];
    playMusic();
  }

  void playPreviousMusic() {
    int previousMusicIndex = musics
            .indexWhere((element) => music.audioSource == element.audioSource) -
        1;

    if (previousMusicIndex <= -1) previousMusicIndex = musics.length - 1;

    music = musics[previousMusicIndex];
    playMusic();
  }

  void disposeAudioPlayer() {
    audioPlayer.dispose();
  }
}
