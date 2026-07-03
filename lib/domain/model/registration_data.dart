class RegistrationData {
  String customerName;
  String icNumber;
  String mobileNumber;
  String emailAddress;
  String maskedPhone = '';
  String maskedEmail = '';

  String token;
  String nextStep;
  String mpin;
  bool isEmailVerification = false;

  RegistrationData({
    this.customerName = '',
    this.icNumber = '',
    this.mobileNumber = '',
    this.emailAddress = '',
    this.token = '',
    this.nextStep = '',
    this.mpin = '',
  });

  void clear() {
    customerName = '';
    icNumber = '';
    mobileNumber = '';
    emailAddress = '';
    token = '';
    nextStep = '';
    mpin = '';
  }
}
