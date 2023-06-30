class PlaybackBarManager {
  String getFormatedTime(Duration time) {
    int seconds = time.inSeconds;

    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(1, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  double getPlayerRange(Duration currentDuration, Duration totalDuration) {
    int currentDurationInSeconds = currentDuration.inSeconds;
    int totalTimeInSeconds = totalDuration.inSeconds;

    if (totalTimeInSeconds == 0) return 0;

    return currentDurationInSeconds * 100 / totalTimeInSeconds / 100;
  }
}
