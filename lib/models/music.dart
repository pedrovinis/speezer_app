// ignore_for_file: prefer_initializing_formals

import 'package:speezer_app/models/Genre.dart';
import 'package:speezer_app/models/artist.dart';

class Music {
  late final String audioSource;
  late final Genre genre;
  late final String name;
  late final Artist artist;

  Music(
      {required String audioSource,
      required Genre genre,
      required String name,
      required Artist artist}) {
    this.audioSource = audioSource;
    this.name = name;
    this.genre = genre;
    this.artist = artist;
  }
}
