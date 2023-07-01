import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:speezer_app/widgets/AudiosRow.dart';
import 'package:speezer_app/widgets/PlaybackBar.dart';
import 'package:speezer_app/widgets/SideBar.dart';
import 'utils/audiomanager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(const SpeezerApp());

class SpeezerApp extends StatelessWidget {
  const SpeezerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speezer App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES'),
        Locale('pt', 'BR'),
      ],
      theme: ThemeData(
        primaryColor: Colors.black,
        primarySwatch: Colors.deepPurple,
        highlightColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Arial',
      ),
      home: const SpeezerHome(),
    );
  }
}

class SpeezerHome extends StatefulWidget {
  const SpeezerHome({Key? key}) : super(key: key);

  @override
  _SpeezerHomeState createState() => _SpeezerHomeState();
}

class _SpeezerHomeState extends State<SpeezerHome> {
  AudioManager audioManager = AudioManager();
  PlayerState playerState = PlayerState.paused;

  @override
  void initState() {
    super.initState();
    AudioPlayer audioPlayer = audioManager.audioPlayer;

    audioPlayer.onPlayerStateChanged.listen((_playerState) {
      setState(() {
        playerState = _playerState;
      });
    });
  }

  @override
  void dispose() {
    audioManager.disposeAudioPlayer();
    super.dispose();
  }

  void playAudio(String source) {
    audioManager.playAudio(source);
  }

  void pauseAudio() {
    audioManager.pauseAudio();
  }

  void stopAudio() {
    audioManager.stopAudio();
  }

  @override
  Widget build(BuildContext context) {
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
                    "test",
                    // AppLocalizations.of(context)!.playing_now,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AudiosRow(),
                AudiosRow(),
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
