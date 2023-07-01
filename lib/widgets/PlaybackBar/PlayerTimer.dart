import 'package:flutter/material.dart';

class PlayerTimer extends StatelessWidget {
  final String timer;
  const PlayerTimer({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    return Text(
      timer,
      style: const TextStyle(color: Colors.white, fontSize: 12),
    );
  }
}
