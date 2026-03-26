class TimeFormat {
  static String fomatduration(Duration duration) {
    final minute = duration.inMinutes;
    final second = duration.inSeconds % 60;
    return '$minute:${second.toString().padLeft(2, '0')}';
  }
}
