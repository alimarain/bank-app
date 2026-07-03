// lib/presentation/view_model/dashboard_viewmodel.dart
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app_locator.dart';

class DashboardViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void handleLogout() {
    print("👋 Logging out from dashboard context...");
    // clear tokens/session if needed
    _navigationService.clearStackAndShow('/onboarding-one');
  }
}
