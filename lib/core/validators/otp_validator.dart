class OtpValidator {
  OtpValidator._();

  static String? validate(String value) {
    final otp = value.trim();

    if (otp.isEmpty) {
      return 'OTP is required';
    }

    if (otp.length != 4) {
      return 'OTP must contain 4 digits';
    }

    if (int.tryParse(otp) == null) {
      return 'OTP must contain only numbers';
    }

    return null;
  }

  static bool isValid(String value) {
    return validate(value) == null;
  }
}
