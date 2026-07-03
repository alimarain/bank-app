class UserSessionService {
  String _token = '';
  bool _isLoggedIn = false;

  String get token => _token;

  bool get isLoggedIn => _isLoggedIn;

  void login(String token) {
    _token = token;
    _isLoggedIn = true;
  }

  void logout() {
    _token = '';
    _isLoggedIn = false;
  }
}
