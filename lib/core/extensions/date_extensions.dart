extension DateExtensions on DateTime {
  String get ddmmyyyy {
    return "${day.toString().padLeft(2, '0')}/"
        "${month.toString().padLeft(2, '0')}/"
        "$year";
  }

  String get hhmm {
    return "${hour.toString().padLeft(2, '0')}:"
        "${minute.toString().padLeft(2, '0')}";
  }
}
