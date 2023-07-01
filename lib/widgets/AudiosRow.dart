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
          String artistsImageSource = music.artists[0].imageSource;
          bool isMusicSelected =
              audioManager.music.audioSource == music.audioSource;

          return GestureDetector(
            onTap: () {
              audioManager.setSelectedMusic(music);
              audioManager.playMusic();
            },
            child: Container(
                width: 150.0,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: isMusicSelected
                            ? Colors.deepPurple
                            : Colors.grey)),
                child: Column(
                  children: [
                    Image(
                        image: AssetImage("assets/image/$artistsImageSource")),
                    Center(
                      child: Column(children: [
                        Text(
                          music.name,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          music.artists[0].name,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ]),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
