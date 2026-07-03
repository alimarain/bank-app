import 'package:my_app/core/constants/api_endpoints.dart';
import 'package:my_app/core/network/api_client.dart';
import 'package:my_app/core/network/base_repository.dart';
import 'package:my_app/data/repositories/auth_repository.dart';
import 'package:my_app/domain/model/api_response.dart';
import 'package:my_app/domain/model/auth_response.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  AuthRepositoryImpl(ApiClient apiClient) : super(apiClient);

  @override
  Future<ApiResponse<AuthResponse>> requestOtp(String phoneNumber) {
    return post<AuthResponse>(
      url: '${ApiEndpoints.baseUrl}${ApiEndpoints.login}',
      body: {"phone_number": phoneNumber.trim()},
      parser: (json) {
        final parsedPhone = json["masked_phone"] ?? "******874";

        return AuthResponse(success: true, maskedPhone: parsedPhone);
      },
    );
  }

  @override
  Future<ApiResponse<AuthResponse>> registerStepOne({
    required String name,
    required String ic,
    required String phone,
    required String email,
  }) {
    return post<AuthResponse>(
      url: '${ApiEndpoints.baseUrl}${ApiEndpoints.register}',
      body: {
        "userName": name,
        "icNumber": ic,
        "mobileNumber": phone,
        "emailAddress": email,
      },
      parser: (json) => AuthResponse.fromJson(json),
    );
  }

  @override
  Future<ApiResponse<AuthResponse>> verifyMobileOtp({
    required String mobileNumber,
    required String otpCode,
  }) {
    return post<AuthResponse>(
      url: '${ApiEndpoints.baseUrl}${ApiEndpoints.verifyMobileOtp}',
      body: {"mobileNumber": mobileNumber, "otp": otpCode},
      parser: (json) => AuthResponse.fromJson(json),
    );
  }

  @override
  Future<ApiResponse<AuthResponse>> verifyEmailOtp({
    required String emailAddress,
    required String otpCode,
  }) {
    return post<AuthResponse>(
      url: '${ApiEndpoints.baseUrl}${ApiEndpoints.verifyEmailOtp}',
      body: {"emailAddress": emailAddress, "otp": otpCode},
      parser: (json) => AuthResponse.fromJson(json),
    );
  }

  @override
  Future<ApiResponse<AuthResponse>> resendMobileOtp({
    required String mobileNumber,
  }) {
    return post<AuthResponse>(
      url: '${ApiEndpoints.baseUrl}${ApiEndpoints.resendMobileOtp}',
      body: {"mobileNumber": mobileNumber},
      parser: (json) => AuthResponse.fromJson(json),
    );
  }

  @override
  Future<ApiResponse<AuthResponse>> resendEmailOtp({
    required String mobileNumber,
  }) {
    return post<AuthResponse>(
      url: '${ApiEndpoints.baseUrl}${ApiEndpoints.resendEmailOtp}',
      body: {"mobileNumber": mobileNumber},
      parser: (json) => AuthResponse.fromJson(json),
    );
  }

  @override
  Future<ApiResponse<AuthResponse>> acceptPrivacyPolicy({
    required String mobileNumber,
  }) {
    return post<AuthResponse>(
      url: '${ApiEndpoints.baseUrl}${ApiEndpoints.acceptPrivacyPolicy}',
      body: {"mobileNumber": mobileNumber, "isAccepted": true},
      parser: (json) => AuthResponse.fromJson(json),
    );
  }

  @override
  Future<ApiResponse<AuthResponse>> createMpin({
    required String mobileNumber,
    required String mpin,
  }) {
    return post<AuthResponse>(
      url: '${ApiEndpoints.baseUrl}${ApiEndpoints.createMpin}',
      body: {"mobileNumber": mobileNumber, "mpin": mpin},
      parser: (json) => AuthResponse.fromJson(json),
    );
  }

  @override
  Future<ApiResponse<AuthResponse>> confirmMpin({
    required String mobileNumber,
    required String confirmMpin,
  }) {
    return post<AuthResponse>(
      url: '${ApiEndpoints.baseUrl}${ApiEndpoints.confirmMpin}',
      body: {"mobileNumber": mobileNumber, "confirmMpin": confirmMpin},
      parser: (json) => AuthResponse.fromJson(json),
    );
  }

  @override
  Future<ApiResponse<AuthResponse>> enableBiometric({
    required String mobileNumber,
    required bool enableBiometric,
  }) {
    return post<AuthResponse>(
      url: '${ApiEndpoints.baseUrl}${ApiEndpoints.enableBiometric}',
      body: {"mobileNumber": mobileNumber, "enableBiometric": enableBiometric},
      parser: (json) => AuthResponse.fromJson(json),
    );
  }
}
