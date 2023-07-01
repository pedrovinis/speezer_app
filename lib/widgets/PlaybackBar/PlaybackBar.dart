import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:speezer_app/utils/audiomanager.dart';
import 'package:speezer_app/utils/plabackbarmanager.dart';
import 'package:speezer_app/widgets/PlaybackBar/PlayerTimer.dart';

import '../../models/music.dart';

class PlaybackBar extends StatefulWidget {
  final AudioManager audioManager;
  final PlayerState playerState;
  const PlaybackBar(
      {super.key, required this.audioManager, required this.playerState});

  @override
  _PlaybackBarState createState() => _PlaybackBarState();
}

class _PlaybackBarState extends State<PlaybackBar> {
  Duration currentDuration = Duration.zero;
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
        currentDuration = duration;
      });
    });
  }

  void setCurrentPosition(Duration position) {
    widget.audioManager.setCurrentPosition(position);
  }

  void pauseMusic() {
    widget.audioManager.pauseMusic();
  }

  void resumeMusic() {
    widget.audioManager.resumeMusic();
  }

  @override
  Widget build(BuildContext context) {
    PlayerState playerState = widget.playerState;
    PlaybackBarManager playbackmanager = PlaybackBarManager();

    int totalTimeInSeconds = totalDuration.inSeconds;

    double playerRange =
        playbackmanager.getPlayerRange(currentDuration, totalDuration);

    double horizontalPadding =
        MediaQuery.of(context).size.width.toDouble() * 0.25;

    bool isPlaying = playerState == PlayerState.playing;

    String currentDurationISOStr =
        playbackmanager.getFormatedTime(currentDuration);

    String totalDurationISOStr = playbackmanager.getFormatedTime(totalDuration);

    return Container(
        height: 108,
        color: Colors.black,
        padding:
            EdgeInsets.fromLTRB(horizontalPadding, 10, horizontalPadding, 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                splashRadius: 0.1,
                icon: const Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              IconButton(
                splashRadius: 0.1,
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (isPlaying) {
                    pauseMusic();
                  } else {
                    resumeMusic();
                  }
                },
              ),
              IconButton(
                splashRadius: 0.1,
                icon: const Icon(
                  Icons.skip_next,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              PlayerTimer(timer: currentDurationISOStr),
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
              PlayerTimer(timer: totalDurationISOStr)
            ],
          )
        ]));
  }
}
