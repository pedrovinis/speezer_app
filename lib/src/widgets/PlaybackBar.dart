import 'package:flutter/material.dart';

class PlaybackBar extends StatefulWidget {
  @override
  _PlaybackBarState createState() => _PlaybackBarState();
}

class _PlaybackBarState extends State<PlaybackBar> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    int _currentPlayTimeInSeconds = 20;
    int totalTimeInSeconds = 100;

    double playerRange = ((_currentPlayTimeInSeconds * 100) / totalTimeInSeconds) / 100;

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
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isPlaying = !_isPlaying;
              });
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
                    onChanged: (double value) {},
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
