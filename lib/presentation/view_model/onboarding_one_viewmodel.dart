import 'package:my_app/app/app_locator.dart';
import 'package:my_app/core/validators/phone_validator.dart';
import 'package:my_app/data/repositories/auth_repository.dart';
import 'package:my_app/presentation/view/otp_verification_view.dart';
import 'package:my_app/services/registration_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OnboardingOneViewmodel extends BaseViewModel {
  final AuthRepository _authRepository = locator<AuthRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final RegistrationService _registration = locator<RegistrationService>();

  String _icNumber = '';
  String _currentLanguage = 'EN';

  String get icNumber => _icNumber;
  String get currentLanguage => _currentLanguage;

  void changeLanguage(String language) {
    _currentLanguage = language;
    notifyListeners();
  }

  void updateIcNumber(String value) {
    _icNumber = value;
    notifyListeners();
  }

  bool get isLoginValid => PhoneValidator.isValid(_icNumber);

  Future<void> submitLogin() async {
    final error = PhoneValidator.validate(_icNumber);

    if (error != null) {
      _snackbarService.showSnackbar(title: "Validation Error", message: error);
      return;
    }

    setBusy(true);

    try {
      final response = await _authRepository.requestOtp(_icNumber.trim());

      setBusy(false);

      if (response.success && response.data != null) {
        final authData = response.data!;

        // Save login/onboarding state
        _registration.data.mobileNumber = _icNumber.trim();
        _registration.data.maskedPhone =
            authData.maskedPhone ??
            "****** ${_icNumber.substring(_icNumber.length - 3)}";

        _registration.data.emailAddress = authData.maskedEmail ?? '';

        _registration.data.maskedEmail = authData.maskedEmail ?? '';

        _registration.data.nextStep = authData.nextStep ?? '';

        _navigationService.navigateToView(const OtpVerificationView());
      } else {
        _snackbarService.showSnackbar(
          title: "Login Failed",
          message: response.message,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      setBusy(false);

      _snackbarService.showSnackbar(
        title: "Connection Error",
        message: "An unexpected error occurred. Please try again.",
      );
    }
  }
}
