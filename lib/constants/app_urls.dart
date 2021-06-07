import 'package:jals/services/authentication_service.dart';
import 'package:jals/utils/locator.dart';

const String ServerBaseUrl = "http://backendjals.herokuapp.com";

Map<String, String> appHttpHeaders() {
  // locator<AuthenticationService>();
  return {
    /////////////////////////////
    "Authorization":
        "Token " + locator<AuthenticationService>().currentUser.key,
  };
}

Map<String, String> appJsonHttpHeaders() {
  // locator<AuthenticationService>();
  return {
    /////////////////////////////
    "Authorization":
        "Token " + locator<AuthenticationService>().currentUser.key,
    "Content-Type": "application/json"
  };
}

class AppUrl {
  static String addTo(String url, List<String> others) {
    others.forEach((element) {
      url = url + element;
    });
    return url;
  }

  // =============================================================
  // =============================================================
  // =============================================================
  // AUTHENTICATION
  // =============================================================////////////////////////////////////////////////////////////////////////////////////////
  // =============================================================
  // =============================================================
  static const String GoogleLogin = "$ServerBaseUrl/v1/rest-auth/google/";
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
  static const String ForYou = "$ServerBaseUrl/v1/posts/for_you/";
  static const String CreateUserAccountInfo = "$ServerBaseUrl/v1/users/";
  static const String SendForgotPasswordEmail =
      "$ServerBaseUrl/v1/users/forgot_password/";
  static const String SendForgotPassword =
      "$ServerBaseUrl/v1/users/forgot_password/";
  static const String ChangePassword =
      "$ServerBaseUrl/v1/users/change_password/";
  static const String Feedback = "$ServerBaseUrl/v1/utils/feedback/add/";
  static const String EmailNotificationToggle =
      "$ServerBaseUrl/v1/utils/toggle_notifications/";

  // =============================================================
  // =============================================================
  // =============================================================
  // Videos
  // =============================================================
  // =============================================================
  // =============================================================
  static const VideosList = "$ServerBaseUrl/v1/posts/videos/";
  static const VideosSearch = "$ServerBaseUrl/v1/posts/videos/search/";
  static String videoPay(String id) {
    return "$ServerBaseUrl/v1/posts/videos/$id/pay/";
  }

  static String searchVideos(String query) {
    return '$ServerBaseUrl/v1/posts/videos/search/?query=$query';
  }

  static const BookmarkedVideos =
      '$ServerBaseUrl/v1/posts/videos/get_bookmarks/';
  static String addToBoomarks({String uid}) {
    return "$ServerBaseUrl/v1/posts/videos/$uid/add_to_bookmarks/";
  }

  static String removeFromBookmarks({String uid}) {
    return "$ServerBaseUrl/v1/posts/videos/$uid/remove_from_bookmarks/";
  }

  // =============================================================
  // =============================================================
  // =============================================================
  // articles
  // =============================================================
  // =============================================================
  // =============================================================
  static String buySermon(String id) {
    return '$ServerBaseUrl/v1/posts/sermons/$id/pay/';
  }

  static String searchArticles(String query) {
    return '$ServerBaseUrl/v1/posts/articles/search/?query=$query';
  }

  static const ArticleList = "$ServerBaseUrl/v1/posts/articles/";
  static const TrendingList = "$ServerBaseUrl/v1/posts/articles/trending/";
  static const ArticleBookmarkList =
      "$ServerBaseUrl/v1/posts/articles/get_bookmarks/";
  static const BookmarkArticle = "$ServerBaseUrl/v1/posts/articles/";
  static const NewsList = "$ServerBaseUrl/v1/posts/news/";

  // =============================================================
  // =============================================================
  // =============================================================
  // Audio
  // =============================================================
  // =============================================================
  // ===================================
  static String buyAudio(String id) {
    return '$ServerBaseUrl/v1/posts/audio/$id/pay/';
  }

  static String searchAudio(String query) {
    return '$ServerBaseUrl/v1/posts/audio/search/?query=$query';
  }

  static const AudioList = "$ServerBaseUrl/v1/posts/audio/";
  static const Playlist = "$ServerBaseUrl/v1/posts/playlists/";
  static String playlistWithId(String id) =>
      "$ServerBaseUrl/v1/posts/playlists/" + id + "/";

  // =============================================================
  // =============================================================
  // =============================================================
  // Comments
  // =============================================================
  // =============================================================
  // ===================================

  static const Comment = "$ServerBaseUrl/v1/posts/";
  static String postComment(String id) => Comment + id + "/add_comment/";
  static String getComment(String id) => Comment + id + "/get_post_comments/";
  // static const TrendingList = "$ServerBaseUrl/v1/posts/articles/";
  // static const ArticleBookmarkList =
  //     "$ServerBaseUrl/v1/posts/articles/get_bookmarks/";
  // static const BookmarkArticle = "$ServerBaseUrl/v1/posts/articles/";
  // static const NewsList = "$ServerBaseUrl/v1/posts/news/";

// 3b79df4433f5aad10c8956e3bd0fb71e415790a7
//
  // =============================================================
  // =============================================================
  // =============================================================
  // Shop Apis
  // =============================================================
  // =============================================================
  // ===================================

  static const String fetchNewestStoreItems =
      "http://backendjals.herokuapp.com/v1/posts/store/";

  static const getPurchasedItemsList =
      "http://backendjals.herokuapp.com/v1/posts/store/purchased/";

//=====================wallet apis==[==============
  static const String WALLET_BALANCE = '$ServerBaseUrl/v1/wallet';
}
// 3b79df4433f5aad/10c8956e3bd0fb71e415790a7
