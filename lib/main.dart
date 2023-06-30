import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:speezer_app/widgets/PlaybackBar.dart';
import 'package:speezer_app/widgets/SideBar.dart';
import 'utils/player.dart';

void main() => runApp(const SpeezerApp());

class SpeezerApp extends StatelessWidget {
  const SpeezerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speezer App',
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
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    AudioPlayer audioPlayer = audioManager.audioPlayer;

    audioPlayer.onPlayerStateChanged.listen((_playerState) {
      setState(() {
        playerState = _playerState;
      });
    });

    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        totalDuration = duration;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration duration) {
      setState(() {
        currentPosition = duration;
      });
    });
  }

  Future<void> setCurrentPosition(Duration duration) async {
    // print("seek $duration");
    await audioManager.audioPlayer.seek(duration);
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
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Playing now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // playAudio('assets/audio/music$index.mp3');
                        },
                        child: Container(
                          width: 150.0,
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.grey,
                          child: Center(
                            child: Text(
                              'Music $index',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Playlists',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 150.0,
                        margin: const EdgeInsets.all(8.0),
                        color: Colors.grey,
                        child: Center(
                          child: Text(
                            'Playlist $index',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: PlaybackBar(
        playerState: playerState,
        currentPosition: currentPosition,
        totalDuration: totalDuration,
        onPlay: playAudio,
        onPause: pauseAudio,
        onStop: stopAudio,
        setCurrentPosition: setCurrentPosition,
      ),
    );
  }
}
