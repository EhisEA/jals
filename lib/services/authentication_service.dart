class AuthenticationService {
  String _authEmail;

  sendSignUpEmail(String email) {
    _authEmail = email;
  }

  verifySignUpEmail(String code) {}
}
