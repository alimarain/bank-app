extension StringExtensions on String {
  String get trimmed => trim();

  bool get isBlank => trim().isEmpty;

  bool get isNotBlank => trim().isNotEmpty;

  bool get isEmail {
    return RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    ).hasMatch(trim());
  }

  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  String get capitalize {
    if (trim().isEmpty) return '';

    return trim()[0].toUpperCase() + trim().substring(1);
  }

  String get phoneDigits {
    return replaceAll(RegExp(r'[^0-9]'), '');
  }

  String maskPhone() {
    if (length < 4) return this;

    return '****** ${substring(length - 4)}';
  }
}
