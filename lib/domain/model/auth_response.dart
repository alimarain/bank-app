class AuthResponse {
  final bool success;
  final String? message;
  final String? developmentOtp;
  final String? token;
  final String? nextStep;
  final String? maskedPhone;
  final String? maskedEmail;
  final String? errorMessage;

  const AuthResponse({
    required this.success,
    this.message,
    this.developmentOtp,
    this.token,
    this.nextStep,
    this.maskedPhone,
    this.maskedEmail,
    this.errorMessage,
  });
  factory AuthResponse.fromJson(
    Map<String, dynamic> json, {
    bool successOverride = true,
  }) {
    final Map<String, dynamic>? data = json['data'] as Map<String, dynamic>?;

    return AuthResponse(
      success: successOverride,
      message: json['message'] as String?,
      errorMessage: json['message'] as String?,
      maskedPhone: json['maskedPhone'] as String?,
      maskedEmail: json['maskedEmail'] as String?,
      developmentOtp: (data?['mobileOtp'] ?? data?['emailOtp']) as String?,
      token: data?['token'] as String?,
      nextStep: data?['nextStep'] as String?,
    );
  }
}
