import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/app/app_locator.dart';
import 'package:my_app/data/repositories/auth_repository.dart';
import 'package:my_app/presentation/view/privacy_policy_view.dart';
import 'package:my_app/services/registration_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OtpVerificationViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final AuthRepository _authRepository = locator<AuthRepository>();
  final RegistrationService _registration = locator<RegistrationService>();

  final List<String> _otpDigits = ['', '', '', ''];

  Timer? _timer;

  int _remainingSeconds = 60;

  // ==========================
  // Registration data
  // ==========================

  bool get isEmailVerification => _registration.data.isEmailVerification;

  String get mobileNumber => _registration.data.mobileNumber;

  String get emailAddress => _registration.data.emailAddress;

  String get maskedPhone {
    if (mobileNumber.length >= 4) {
      return '****** ${mobileNumber.substring(mobileNumber.length - 4)}';
    }
    return '******';
  }

  String get displayTarget => isEmailVerification ? emailAddress : maskedPhone;

  // ==========================
  // Initialize
  // ==========================

  void initialize() {
    startResendTimer();
  }

  // ==========================
  // Timer
  // ==========================

  int get remainingSeconds => _remainingSeconds;

  bool get canResend => _remainingSeconds == 0;

  void startResendTimer() {
    _timer?.cancel();

    _remainingSeconds = 60;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  // ==========================
  // Resend OTP
  // ==========================

  Future<void> resendOtp() async {
    setBusy(true);

    final response = isEmailVerification
        ? await _authRepository.resendEmailOtp(mobileNumber: mobileNumber)
        : await _authRepository.resendMobileOtp(mobileNumber: mobileNumber);

    setBusy(false);

    if (response.success) {
      startResendTimer();

      _snackbarService.showSnackbar(
        title: "OTP Sent",
        message: response.message,
      );
    } else {
      _snackbarService.showSnackbar(title: "Failed", message: response.message);
    }
  }

  // ==========================
  // OTP
  // ==========================

  void updateCode(int index, String value) {
    if (index < 0 || index > 3) return;

    _otpDigits[index] = value;
    notifyListeners();
  }

  String get completeOtp => _otpDigits.join();

  bool get isOtpComplete =>
      completeOtp.length == 4 && int.tryParse(completeOtp) != null;

  void _clearOtp() {
    for (int i = 0; i < _otpDigits.length; i++) {
      _otpDigits[i] = '';
    }
    notifyListeners();
  }

  // ==========================
  // Verify OTP
  // ==========================

  Future<void> verifyOtpCode(BuildContext context) async {
    if (!isOtpComplete) return;

    setBusy(true);

    final response = isEmailVerification
        ? await _authRepository.verifyEmailOtp(
            emailAddress: emailAddress,
            otpCode: completeOtp,
          )
        : await _authRepository.verifyMobileOtp(
            mobileNumber: mobileNumber,
            otpCode: completeOtp,
          );

    setBusy(false);

    if (!response.success) {
      _clearOtp();

      _snackbarService.showSnackbar(
        title: isEmailVerification
            ? "Email Verification Failed"
            : "Mobile Verification Failed",
        message: response.message,
      );

      return;
    }

    // --------------------------
    // Mobile verified
    // --------------------------
    if (!isEmailVerification) {
      _registration.data.isEmailVerification = true;

      _clearOtp();

      startResendTimer();

      _snackbarService.showSnackbar(
        title: "Mobile Verified",
        message: "Please verify your email.",
      );

      return;
    }

    // --------------------------
    // Email verified
    // --------------------------
    _snackbarService.showSnackbar(
      title: "Verification Complete",
      message: "Proceeding to Privacy Policy.",
    );

    _navigationService.navigateToView(const PrivacyPolicyView());
  }

  // ==========================
  // Back
  // ==========================

  void navigateBack() {
    if (isEmailVerification) {
      _registration.data.isEmailVerification = false;

      _clearOtp();

      startResendTimer();

      return;
    }

    _navigationService.back();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
