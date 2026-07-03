class EmailValidator {
  EmailValidator._();

  static String? validate(String value) {
    final email = value.trim();

    if (email.isEmpty) {
      return 'Email is required';
    }

    final regex = RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

    if (!regex.hasMatch(email)) {
      return 'Invalid email address';
    }

    return null;
  }

  static bool isValid(String value) {
    return validate(value) == null;
  }
}
