import 'package:flutter/material.dart';
import 'package:my_app/app/app_locator.dart';
import 'package:my_app/data/repositories/auth_repository.dart';
import 'package:my_app/presentation/view/biometric_view.dart';
import 'package:my_app/services/registration_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateMpinViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final AuthRepository _authRepository = locator<AuthRepository>();
  final RegistrationService _registration = locator<RegistrationService>();

  final TextEditingController pinController = TextEditingController();

  String _mpin = '';

  bool _isConfirming = false;

  String get mpin => _mpin;

  bool get isConfirming => _isConfirming;

  bool get canContinue => _mpin.length == 6 && !isBusy;

  List<bool> get enteredDigits =>
      List.generate(6, (index) => index < _mpin.length);

  void updatePin(String value) {
    if (value.length > 6) return;

    _mpin = value.replaceAll(RegExp(r'[^0-9]'), '');

    notifyListeners();
  }

  Future<void> submitMpin() async {
    if (_mpin.length != 6) {
      _snackbarService.showSnackbar(
        message: 'Please enter a valid 6-digit MPIN.',
      );
      return;
    }

    // First entry
    if (!_isConfirming) {
      _registration.data.mpin = _mpin;

      _mpin = '';
      pinController.clear();

      _isConfirming = true;

      notifyListeners();
      return;
    }

    // Confirm MPIN
    if (_mpin != _registration.data.mpin) {
      _snackbarService.showSnackbar(
        title: "MPIN Does Not Match",
        message: "Please enter the same MPIN again.",
      );

      _mpin = '';
      pinController.clear();

      notifyListeners();
      return;
    }

    setBusy(true);

    try {
      final createResponse = await _authRepository.createMpin(
        mobileNumber: _registration.data.mobileNumber,
        mpin: _registration.data.mpin,
      );

      if (!createResponse.success) {
        setBusy(false);

        _snackbarService.showSnackbar(
          title: "Error",
          message: createResponse.message,
        );
        return;
      }

      final confirmResponse = await _authRepository.confirmMpin(
        mobileNumber: _registration.data.mobileNumber,
        confirmMpin: _registration.data.mpin,
      );

      setBusy(false);

      if (confirmResponse.success) {
        _navigationService.navigateToView(const BiometricView());
      } else {
        _snackbarService.showSnackbar(
          title: "Error",
          message: confirmResponse.message,
        );
      }
    } catch (e) {
      setBusy(false);

      _snackbarService.showSnackbar(title: "Error", message: e.toString());
    }
  }

  void goBack() {
    if (_isConfirming) {
      _isConfirming = false;
      _mpin = '';
      pinController.clear();

      notifyListeners();
      return;
    }

    _navigationService.back();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }
}
