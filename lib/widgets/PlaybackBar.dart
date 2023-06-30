import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:speezer_app/utils/audiomanager.dart';
import 'package:speezer_app/utils/plabackbarmanager.dart';

class PlaybackBar extends StatefulWidget {
  final AudioManager audioManager;
  final PlayerState playerState;
  const PlaybackBar(
      {super.key, required this.audioManager, required this.playerState});

  @override
  _PlaybackBarState createState() => _PlaybackBarState();
}

class _PlaybackBarState extends State<PlaybackBar> {
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  @override
  void initState() {
    AudioManager audioManager = widget.audioManager;
    AudioPlayer audioPlayer = audioManager.audioPlayer;

    super.initState();

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

  void setCurrentPosition(Duration position) {
    widget.audioManager.setCurrentPosition(position);
  }

  void playAudio(String source) {
    widget.audioManager.playAudio(source);
  }

  void pauseAudio() {
    widget.audioManager.pauseAudio();
  }

  void stopAudio() {
    widget.audioManager.stopAudio();
  }

  @override
  Widget build(BuildContext context) {
    PlayerState playerState = widget.playerState;
    PlaybackBarManager playbackmanager = PlaybackBarManager();

    int currentDurationInSeconds = currentPosition.inSeconds;
    int totalTimeInSeconds = totalDuration.inSeconds;

    double playerRange =
        currentDurationInSeconds == 0 && totalTimeInSeconds == 0
            ? 0
            : ((currentDurationInSeconds * 100) / totalTimeInSeconds) / 100;

    double horizontalPadding =
        MediaQuery.of(context).size.width.toDouble() * 0.25;

    bool isPlaying = playerState == PlayerState.playing;

    String currentDurationISOStr =
        playbackmanager.getFormatedTime(currentPosition);

    String totalDurationISOStr = playbackmanager.getFormatedTime(totalDuration);

    return Container(
      height: 75,
      color: Colors.black,
      padding:
          EdgeInsets.fromLTRB(horizontalPadding, 10, horizontalPadding, 10),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {
              if (isPlaying) {
                pauseAudio();
              } else {
                playAudio("assets/audio/de_garrafa_a_pior.mp3");
              }
            },
          ),
          Text(
            "$currentDurationISOStr",
            style: const TextStyle(color: Colors.white),
          ),
          Expanded(
              child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 0.5,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 3,
                      elevation: 0,
                    ),
                  ),
                  child: Slider(
                    onChanged: (double value) {
                      int seconds = (value * totalTimeInSeconds).round();
                      setCurrentPosition(Duration(seconds: seconds));
                    },
                    value: playerRange,
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey,
                  ))),
          Text(
            "$totalDurationISOStr",
            style: const TextStyle(color: Colors.white),
          ),
          IconButton(
            icon: const Icon(
              Icons.skip_next,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
