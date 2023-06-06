import 'package:flutter/material.dart';

class PlaybackBar extends StatefulWidget {
  @override
  _PlaybackBarState createState() => _PlaybackBarState();
}

class _PlaybackBarState extends State<PlaybackBar> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = MediaQuery.of(context).size.width.toDouble() * 0.25;

    return Container(
      height: 60,
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(horizontalPadding, 10, horizontalPadding, 10),
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
          SizedBox(width: 16.0),
          Expanded(
            child: Slider(
              onChanged: (double value) {
              },
              value: 0.5,
              activeColor: Colors.green,
              inactiveColor: Colors.grey,
            ),
          ),
          SizedBox(width: 16.0),
          IconButton(
            icon: Icon(
              Icons.skip_next,
              color: Colors.white,
            ),
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }
}