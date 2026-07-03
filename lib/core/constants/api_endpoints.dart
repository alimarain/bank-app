class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'http://172.16.119.249:8080/api/Auth';

  static const String register = '/Register';
  static const String verifyMobileOtp = '/verify-mobile';
  static const String verifyEmailOtp = '/verify-email';
  static const String resendMobileOtp = '/resend-mobile-otp';
  static const String resendEmailOtp = '/resend-email-otp';
  static const String acceptPrivacyPolicy = '/accept-privacy-policy';
  static const String createMpin = '/create-mpin';
  static const String confirmMpin = '/confirm-mpin';
  static const String enableBiometric = '/enable-biometric';
  static const String login = '/login';
}
