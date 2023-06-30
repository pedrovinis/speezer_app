import 'package:flutter/material.dart';

class AudiosRow extends StatelessWidget {
  const AudiosRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
