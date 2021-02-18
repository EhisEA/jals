const String ServerBaseUrl = "http://backendjals.herokuapp.com";

class AppUrl {
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
}
// 3b79df4433f5aad10c8956e3bd0fb71e415790a7

// {
//     "status": "successful",
//     "data": {
//         "key": "3b79df4433f5aad10c8956e3bd0fb71e415790a7",
//         "user": {
//             "user": 10,
//             "full_name": "Collins",
//             "phone_number": "08163509379",
//             "date_of_birth": "2021-02-12",
//             "verified": false,
//             "avatar": null
//         }
//     }
// }
// {
//     "status": "error",
//     "error": {
//         "non_field_errors": ["Unable to log in with provided credentials."]
//     }
// }
