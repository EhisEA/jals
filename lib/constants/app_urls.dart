const String ServerBaseUrl = "http://backendjals.herokuapp.com";
final Map<String, String> headers = {"Content-Type": "application/json"};

class AppUrl {
  // ============Authetications.
  static const String Login = "$ServerBaseUrl/v1/rest-auth/login/";
  static const String VerifyEmail = "$ServerBaseUrl/v1/users/check_email/";
  static const String RegisterUser =
      "$ServerBaseUrl/v1/rest-auth/registration/";
  static const String LogOut = "$ServerBaseUrl/v1/rest-auth/logout/";
  static const String CreateUserAccountIno = "$ServerBaseUrl/v1/users/";
  static const String SendForgotPasswordEmail =
      "$ServerBaseUrl/v1/users/forgot_password/";
  static const String SendForgotPassword =
      "$ServerBaseUrl/v1/users/forgot_password/";
  // ===============Videos.
  static const VideosList = "$ServerBaseUrl/v1/posts/videos/";
}
// 3b79df4433f5aad10c8956e3bd0fb71e415790a7
