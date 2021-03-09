import 'package:flutter/foundation.dart';

const String ServerBaseUrl = "http://backendjals.herokuapp.com";
final Map<String, String> headers = {"Content-Type": "application/json"};

Map<String, String> httpHeaders({String token, @required bool isToken}) {
  return isToken
      ? {
          "Content-Type": "application/json",
          "Authorization": "Token $token",
        }
      : {
          "Content-Type": "application/json",
        };
}

class AppUrl {
  // =============================================================
  // =============================================================
  // =============================================================
  // AUTHENTICATION
  // =============================================================
  // =============================================================
  // =============================================================
  static const String Login = "$ServerBaseUrl/v1/rest-auth/login/";
  static const String VerifyEmail = "$ServerBaseUrl/v1/users/check_email/";
  static const String RegisterUser =
      "$ServerBaseUrl/v1/rest-auth/registration/";
  static const String LogOut = "$ServerBaseUrl/v1/rest-auth/logout/";

  // =============================================================
  // =============================================================
  // =============================================================
  // HOME VIEW
  // =============================================================
  // =============================================================
  // =============================================================
  static const String Explore = "$ServerBaseUrl/v1/posts/explore/";
  static const String DailyRead = "$ServerBaseUrl/v1/posts/get_scripture/";
  static const String ForYou = "$ServerBaseUrl/v1/posts/explore/";
  static const String CreateUserAccountIno = "$ServerBaseUrl/v1/users/";
  static const String SendForgotPasswordEmail =
      "$ServerBaseUrl/v1/users/forgot_password/";
  static const String SendForgotPassword =
      "$ServerBaseUrl/v1/users/forgot_password/";

  // =============================================================
  // =============================================================
  // =============================================================
  // Videos
  // =============================================================
  // =============================================================
  // =============================================================
  static const VideosList = "$ServerBaseUrl/v1/posts/videos/";
  static const VideosSearch = "$ServerBaseUrl/v1/posts/videos/search/";
}
// 3b79df4433f5aad10c8956e3bd0fb71e415790a7
