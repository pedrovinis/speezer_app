import 'package:speezer_app/data/artists.dart';
import 'package:speezer_app/models/Genre.dart';
import 'package:speezer_app/models/music.dart';

List<Music> musics = [
  Music(
      audioSource: "de_garrafa_a_pior.mp3",
      genre: Genre.Countryside,
      name: "Garrafa a pior",
      artists: [ArtistHenriqueEJuliano]),
  Music(
      audioSource: "a-maior-saudade.mp3",
      genre: Genre.Countryside,
      name: "A maior saudade",
      artists: [ArtistHenriqueEJuliano]),
  Music(
      audioSource: "groupies.mp3",
      genre: Genre.Trap,
      name: "Groupies",
      artists: [ArtistMatue]),
  Music(
      audioSource: "goosebumps.mp3",
      genre: Genre.TrapInternational,
      name: "Goosebumps",
      artists: [ArtistTravisScott]),
  Music(
      audioSource: "beberia_ou_nao_beberia.mp3",
      genre: Genre.Countryside,
      name: "Você beberia ou não beberia",
      artists: [ArtistZenetoeCristiano]),
  Music(
      audioSource: "roct-pot.mp3",
      genre: Genre.Funk,
      name: "Roct Poct",
      artists: [ArtistMcLaranjinha]),
  Music(
      audioSource: "Batom_de_Cereja.mp3",
      genre: Genre.Countryside,
      name: "Batom de Cereja",
      artists: [ArtistIsraeleRodolffo]),
];
