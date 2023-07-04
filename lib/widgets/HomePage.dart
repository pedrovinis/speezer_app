import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:speezer_app/data/musics.dart';
import 'package:speezer_app/utils/audiorowsmanager.dart';
import 'package:speezer_app/widgets/AudiosRow.dart';
import 'package:speezer_app/widgets/PlaybackBar/PlaybackBar.dart';
import 'package:speezer_app/widgets/SideBar.dart';
import '../models/music.dart';
import '../utils/audiomanager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Music currentMusic;
  late AudioManager audioManager = AudioManager();
  PlayerState playerState = PlayerState.paused;

  @override
  void initState() {
    super.initState();
    AudioPlayer audioPlayer = audioManager.audioPlayer;

    audioPlayer.onPlayerStateChanged.listen((_playerState) {
      setState(() {
        audioManager.setSelectedMusic(audioManager.music);
        playerState = _playerState;
      });
    });
  }

  @override
  void dispose() {
    audioManager.disposeAudioPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AudioRowManager audioRows = AudioRowManager();
    List<List<Music>> exploreMuiscList =
        audioRows.getExploreMusicRowsList(rowLenght: 10);

    print(exploreMuiscList);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: false,
        title: const Text(
          'Speezer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Row(
        children: [
          const SideBar(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    AppLocalizations.of(context)!.explore,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: exploreMuiscList.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<Music> list = exploreMuiscList[index];

                      return AudiosRow(
                          audioManager: audioManager, musics: list);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: PlaybackBar(
        audioManager: audioManager,
        playerState: playerState,
      ),
    );
  }
}
