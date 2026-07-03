class PhoneValidator {
  PhoneValidator._();

  static String? validate(String value) {
    final phone = value.trim();

    if (phone.isEmpty) {
      return 'Phone number is required';
    }

    if (phone.length < 8) {
      return 'Phone number is too short';
    }

    if (phone.length > 15) {
      return 'Phone number is too long';
    }

    return null;
  }

  static bool isValid(String value) {
    return validate(value) == null;
  }
}
