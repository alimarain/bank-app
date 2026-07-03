import 'package:flutter/material.dart';
import 'package:my_app/app/app_locator.dart';
import 'package:my_app/data/repositories/auth_repository.dart';
import 'package:my_app/presentation/view/onboarding/onboarding_one.dart';
import 'package:my_app/presentation/view/otp_verification_view.dart';
import 'package:my_app/presentation/widgets/account_exists_dialog.dart';
import 'package:my_app/services/registration_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OnboardingThreeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final AuthRepository _authRepository = locator<AuthRepository>();
  final RegistrationService _registration = locator<RegistrationService>();

  String _customerName = '';
  String _icNumber = '';
  String _mobileNumber = '+60';
  String _emailAddress = '';

  String get customerName => _customerName;
  String get icNumber => _icNumber;
  String get mobileNumber => _mobileNumber;
  String get emailAddress => _emailAddress;

  void updateCustomerName(String value) {
    _customerName = value;
    notifyListeners();
  }

  void updateIcNumber(String value) {
    _icNumber = value;
    notifyListeners();
  }

  void updateMobileNumber(String value) {
    _mobileNumber = value;
    notifyListeners();
  }

  void updateEmailAddress(String value) {
    _emailAddress = value;
    notifyListeners();
  }

  bool get isFormValid {
    final name = _customerName.trim();
    final ic = _icNumber.trim();
    final phone = _mobileNumber.trim();
    final email = _emailAddress.trim();

    return name.isNotEmpty &&
        ic.length >= 5 &&
        phone.length > 7 &&
        email.contains('@') &&
        email.contains('.');
  }

  Future<void> submitRegistrationDetails(BuildContext context) async {
    if (!isFormValid) return;

    final customerName = _customerName.trim();
    final icNumber = _icNumber.trim();
    final mobileNumber = _mobileNumber.replaceFirst('+60', '').trim();
    final emailAddress = _emailAddress.trim();

    setBusy(true);

    final response = await _authRepository.registerStepOne(
      name: customerName,
      ic: icNumber,
      phone: mobileNumber,
      email: emailAddress,
    );

    setBusy(false);
    print("========== REGISTER RESPONSE ==========");
    print("Success: ${response.success}");
    print("Status Code: ${response.statusCode}");
    print("Message: ${response.message}");
    print("OTP: ${response.data?.developmentOtp}");
    print("=======================================");
    if (response.success) {
      print("Saving registration data...");

      // Save everything needed for the onboarding flow
      _registration.data.customerName = customerName;
      _registration.data.icNumber = icNumber;
      _registration.data.mobileNumber = mobileNumber;
      _registration.data.emailAddress = emailAddress;
      _registration.data.nextStep = response.data?.nextStep ?? '';

      print("Navigating to OTP screen...");

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const OtpVerificationView()));
      print("Navigation method called.");

      return;
    }

    if (response.statusCode == 409 ||
        response.message.toLowerCase().contains('already')) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AccountExistsDialog(
          onRetry: () => Navigator.of(context).pop(),
          onLogin: () {
            Navigator.of(context).pop();
            _navigationService.clearStackAndShowView(const OnboardingOne());
          },
        ),
      );

      return;
    }

    _snackbarService.showSnackbar(
      title: 'Registration Error',
      message: response.message,
      duration: const Duration(seconds: 4),
    );
  }

  void handleBack() {
    _navigationService.back();
  }
}
