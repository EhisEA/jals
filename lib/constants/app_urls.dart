import 'package:jals/services/authentication_service.dart';
import 'package:jals/utils/locator.dart';

const String ServerBaseUrl = "http://backendjals.herokuapp.com";

Map<String, String> httpHeaders() {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  return {
    "Authorization": "Token 3d31aa3d1a1159e1eb494ad25f97ffcf661ca58b",
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
  static const String CreateUserAccountInfo = "$ServerBaseUrl/v1/users/";
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

  static const BookmarkedVideos =
      '$ServerBaseUrl/v1/posts/videos/get_bookmarks/';
  static String addToBoomarks({String uid}) {
    return "$ServerBaseUrl/v1/posts/videos/$uid/add_to_bookmarks/";
  }

  static String removeFromBookmarks({String uid}) {
    return "$ServerBaseUrl/v1/posts/videos/$uid/remove_from_bookmarks/";
  }
}
// 3b79df4433f5aad/10c8956e3bd0fb71e415790a7
