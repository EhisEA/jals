import 'package:jals/services/authentication_service.dart';
import 'package:jals/utils/locator.dart';

const String ServerBaseUrl = "http://backendjals.herokuapp.com";

Map<String, String> appHttpHeaders() {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  return {
    "Authorization": "Token ${_authenticationService.currentUser.key}",
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

  // =============================================================
  // =============================================================
  // =============================================================
  // articles
  // =============================================================
  // =============================================================
  // =============================================================

  static const ArticleList = "$ServerBaseUrl/v1/posts/articles/";
  static const TrendingList = "$ServerBaseUrl/v1/posts/articles/";
  static const ArticleBookmarkList =
      "$ServerBaseUrl/v1/posts/articles/get_bookmarks/";
  static const BookmarkArticle = "$ServerBaseUrl/v1/posts/articles/";
  static const NewsList = "$ServerBaseUrl/v1/posts/news/";

// 3b79df4433f5aad10c8956e3bd0fb71e415790a7
}
