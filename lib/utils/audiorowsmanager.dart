import 'package:speezer_app/data/musics.dart';
import 'package:speezer_app/models/music.dart';

class AudioRowManager {
  List<List<Music>> getExploreMusicRowsList({required int rowLenght}) {
    List<List<Music>> list = [];
    int numberOfRows = (musics.length / rowLenght).round() + 1;
    
    for (var rowIndex = 0; rowIndex < numberOfRows; rowIndex++) {
      List<Music> row = [];

      int startMusicIndex = rowIndex * rowLenght;
      for (var musicIndex = startMusicIndex;
          musicIndex < startMusicIndex + rowLenght;
          musicIndex++) {
        if (musicIndex < musics.length) {
          row.add(musics[musicIndex]);
        }
      }
      list.add(row);
    }

    return list;
  }
}
