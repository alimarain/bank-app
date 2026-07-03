import 'package:my_app/domain/model/api_response.dart';
import 'package:my_app/domain/model/auth_response.dart';

abstract class AuthRepository {
  Future<ApiResponse<AuthResponse>> requestOtp(String phoneNumber);

  Future<ApiResponse<AuthResponse>> registerStepOne({
    required String name,
    required String ic,
    required String phone,
    required String email,
  });

  Future<ApiResponse<AuthResponse>> verifyMobileOtp({
    required String mobileNumber,
    required String otpCode,
  });

  // Backend expects emailAddress instead of mobileNumber
  Future<ApiResponse<AuthResponse>> verifyEmailOtp({
    required String emailAddress,
    required String otpCode,
  });

  Future<ApiResponse<AuthResponse>> resendMobileOtp({
    required String mobileNumber,
  });

  Future<ApiResponse<AuthResponse>> resendEmailOtp({
    required String mobileNumber,
  });

  Future<ApiResponse<AuthResponse>> acceptPrivacyPolicy({
    required String mobileNumber,
  });

  // Create MPIN
  Future<ApiResponse<AuthResponse>> createMpin({
    required String mobileNumber,
    required String mpin,
  });

  // Confirm MPIN
  Future<ApiResponse<AuthResponse>> confirmMpin({
    required String mobileNumber,
    required String confirmMpin,
  });

  Future<ApiResponse<AuthResponse>> enableBiometric({
    required String mobileNumber,
    required bool enableBiometric,
  });
}
