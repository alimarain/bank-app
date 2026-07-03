class IcValidator {
  IcValidator._();

  static String? validate(String value) {
    final ic = value.trim();

    if (ic.isEmpty) {
      return 'IC Number is required';
    }

    if (ic.length < 5) {
      return 'Invalid IC Number';
    }

    return null;
  }

  static bool isValid(String value) {
    return validate(value) == null;
  }
}
