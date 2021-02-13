const String ServerBaseUrl = "http://backendjals.herokuapp.com";

class AppUrl {
  static const String Login = "$ServerBaseUrl/v1/rest-auth/login/";
  static const String VerifyEmail = "$ServerBaseUrl/v1/users/check_email/";
  static const String RegisterUser =
      "$ServerBaseUrl/v1/rest-auth/registration/";
  static const String LogOut = "$ServerBaseUrl/v1/rest-auth/logout/";

  static const String CreateUserAccountIno = "$ServerBaseUrl/";
  static const String SendForgotPasswordEmail =
      "$ServerBaseUrl/v1/users/forgot_password/";
  static const String SendForgotPassword =
      "$ServerBaseUrl/v1/users/forgot_password/";
}
// 3b79df4433f5aad10c8956e3bd0fb71e415790a7
