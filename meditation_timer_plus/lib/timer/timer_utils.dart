

class TimerUtils {
  String displayTimeFormatted(Duration timeRemaining) {
    final parts = <String>[];

    final hours = timeRemaining.inHours;
    final minutes = timeRemaining.inMinutes % 60;
    final seconds = timeRemaining.inSeconds % 60;

    if (hours > 0) {
      parts.add("${hours}h");
    }
    if (minutes > 0) {
      parts.add("${minutes}m");
    }
    if (seconds > 0) {
      parts.add("${seconds}s");
    }

    return parts.join(", ");
  }
}

