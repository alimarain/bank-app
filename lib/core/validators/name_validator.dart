class NameValidator {
  NameValidator._();

  static String? validate(String value) {
    final name = value.trim();

    if (name.isEmpty) {
      return 'Customer name is required';
    }

    if (name.length < 3) {
      return 'Name is too short';
    }

    return null;
  }

  static bool isValid(String value) {
    return validate(value) == null;
  }
}
