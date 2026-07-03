import 'package:my_app/domain/model/registration_data.dart';

class RegistrationService {
  final RegistrationData data = RegistrationData();

  void clear() {
    data.clear();
  }
}
