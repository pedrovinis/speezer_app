import 'package:flutter/material.dart';
import 'package:speezer_app/data/musics.dart';
import 'package:speezer_app/utils/audiomanager.dart';

import '../models/music.dart';

class AudiosRow extends StatelessWidget {
  final AudioManager audioManager;
  const AudiosRow({super.key, required this.audioManager});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: musics.length,
        itemBuilder: (BuildContext context, int index) {
          Music music = musics[index];

          return GestureDetector(
            onTap: () {
              audioManager.setSelectedMusic(music);
              audioManager.playMusic();
            },
            child: Container(
              width: 150.0,
              margin: const EdgeInsets.all(8.0),
              color: Colors.deepPurple,
              child: Center(
                child: Text(
                  music.name,
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
    );
  }
}
