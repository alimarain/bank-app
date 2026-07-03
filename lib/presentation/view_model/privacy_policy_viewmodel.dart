import 'package:my_app/app/app_locator.dart';
import 'package:my_app/data/repositories/auth_repository.dart';
import 'package:my_app/presentation/view/create_mpin_view.dart';
import 'package:my_app/services/registration_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PrivacyPolicyViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final AuthRepository _authRepository = locator<AuthRepository>();
  final RegistrationService _registration = locator<RegistrationService>();

  bool _isAccepted = false;

  bool get isAccepted => _isAccepted;

  bool get canContinue => _isAccepted && !isBusy;

  /// Replace this with your actual privacy policy text
  String get privacyText => '''
KP is committed to protecting your personal and financial data.
We collect essential information—including your identity details (CNIC), transaction history, and device ID—solely to process secure banking services and prevent financial fraud.
With your explicit permission, we access device features like Location (to find ATMs and trace fraudulent logins) and Camera (for secure identity verification).
We strictly comply with State Bank of Pakistan (SBP) regulations and never sell your data to third parties.
All information is secured using industry-standard encryption protocols and retained only as required by local banking laws.
For questions or to manage your permissions, please visit our app settings or contact us at privacy@kp.com.
''';

  void togglePrivacy(bool? value) {
    _isAccepted = value ?? false;
    notifyListeners();
  }

  Future<void> acceptPrivacyPolicy() async {
    if (!_isAccepted) {
      _snackbarService.showSnackbar(
        message: 'Please accept the Privacy Policy.',
      );
      return;
    }

    setBusy(true);

    try {
      final response = await _authRepository.acceptPrivacyPolicy(
        mobileNumber: _registration.data.mobileNumber,
      );

      setBusy(false);

      if (response.success) {
        _navigationService.clearStackAndShowView(const CreateMpinView());
      } else {
        _snackbarService.showSnackbar(message: response.message);
      }
    } catch (e) {
      setBusy(false);

      _snackbarService.showSnackbar(message: e.toString());
    }
  }

  void goBack() {
    _navigationService.back();
  }
}
