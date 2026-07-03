import 'package:my_app/presentation/view/onboarding/onboarding_three.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app_locator.dart';

class OnboardingTwoViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void handleNextStep() {
    print("🚀 Next clicked from OnboardingTwo");

    _navigationService.navigateToView(const OnboardingThree());
  }

  void handleBack() {
    _navigationService.back();
  }
}
