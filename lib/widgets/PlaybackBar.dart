import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlaybackBar extends StatelessWidget {
  final bool isPlaying;
  final Duration currentPosition;
  final Duration totalDuration;
  final Function(String source) onPlay;
  final Function() onPause;
  final Function() onStop;
  final Function(Duration duration) setCurrentPosition;

  const PlaybackBar(
      {super.key,
      required this.isPlaying,
      required this.currentPosition,
      required this.totalDuration,
      required this.onPlay,
      required this.onPause,
      required this.onStop,
      required this.setCurrentPosition});

  @override
  Widget build(BuildContext context) {
    int currentPlayTimeInSeconds = currentPosition.inSeconds;
    int totalTimeInSeconds = totalDuration.inSeconds;

    double playerRange =
        currentPlayTimeInSeconds == 0 && totalTimeInSeconds == 0
            ? 0
            : ((currentPlayTimeInSeconds * 100) / totalTimeInSeconds) / 100;

    double horizontalPadding =
        MediaQuery.of(context).size.width.toDouble() * 0.25;
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
                onPause();
              } else {
                onPlay("assets/audio/de_garrafa_a_pior.mp3");
              }
            },
          ),
          Expanded(
              child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 1,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                  ),
                  child: Slider(
                    onChanged: (double value) {
                      setCurrentPosition(Duration(
                          seconds: value.round() * totalTimeInSeconds));
                    },
                    value: playerRange,
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey,
                  ))),
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
