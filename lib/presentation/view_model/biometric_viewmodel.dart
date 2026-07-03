import 'package:my_app/app/app_locator.dart';
import 'package:my_app/data/repositories/auth_repository.dart';
import 'package:my_app/presentation/view/dashboard_view.dart';
import 'package:my_app/services/registration_service.dart';
import 'package:my_app/services/user_session_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BiometricViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final AuthRepository _authRepository = locator<AuthRepository>();
  final RegistrationService _registration = locator<RegistrationService>();
  final UserSessionService _session = locator<UserSessionService>();

  Future<void> enableBiometric() async {
    setBusy(true);

    try {
      final response = await _authRepository.enableBiometric(
        mobileNumber: _registration.data.mobileNumber,
        enableBiometric: true,
      );

      setBusy(false);

      if (response.success) {
        // Save JWT token in session
        _session.login(response.data?.token ?? '');

        _snackbarService.showSnackbar(
          title: "Success",
          message: response.message,
        );

        _navigationService.clearStackAndShowView(const DashboardView());
      } else {
        _snackbarService.showSnackbar(
          title: "Biometric",
          message: response.message,
        );
      }
    } catch (e) {
      setBusy(false);

      _snackbarService.showSnackbar(title: "Error", message: e.toString());
    }
  }

  Future<void> skip() async {
    setBusy(true);

    try {
      final response = await _authRepository.enableBiometric(
        mobileNumber: _registration.data.mobileNumber,
        enableBiometric: false,
      );

      setBusy(false);

      if (response.success) {
        // Save JWT token even if biometric is skipped
        _session.login(response.data?.token ?? '');

        _snackbarService.showSnackbar(
          title: "Success",
          message: response.message,
        );

        _navigationService.clearStackAndShowView(const DashboardView());
      } else {
        _snackbarService.showSnackbar(
          title: "Biometric",
          message: response.message,
        );
      }
    } catch (e) {
      setBusy(false);

      _snackbarService.showSnackbar(title: "Error", message: e.toString());
    }
  }

  void goBack() {
    _navigationService.back();
  }
}
