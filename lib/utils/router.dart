import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/enums/content_type.dart';
import 'package:jals/enums/password_type.dart';
import 'package:jals/enums/verification_type.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/content_model.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/ui/article/article_library_view.dart';
import 'package:jals/ui/article/article_view.dart';
import 'package:jals/ui/audio/audio_library_view.dart';
import 'package:jals/ui/audio/audio_player_view.dart';
import 'package:jals/ui/audio/playlist_view.dart';
import 'package:jals/ui/authentication/account_info_view.dart';
import 'package:jals/ui/authentication/email_login_view.dart';
import 'package:jals/ui/authentication/forgot_password_view.dart';
import 'package:jals/ui/authentication/login_view.dart';
import 'package:jals/ui/authentication/password_view.dart';
import 'package:jals/ui/authentication/sign_up_view.dart';
import 'package:jals/ui/authentication/splashscreen_view.dart';
import 'package:jals/ui/authentication/verification_view.dart';
import 'package:jals/ui/authentication/welcome_view.dart';
import 'package:jals/ui/dynamic_link_entry_view.dart';
import 'package:jals/ui/feedback_view.dart';
import 'package:jals/ui/home/home_base.dart';
import 'package:jals/ui/search_view.dart';
import 'package:jals/ui/shop/payment_page_with_token.dart';
import 'package:jals/ui/store/store_item_view.dart';
import 'package:jals/ui/video/video_library_view.dart';
import 'package:jals/ui/video/video_player.dart';

import '../ui/undefinedRoute.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PaymentPageWithTokenViewRoute:
        int coinBalance;
        coinBalance = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => PaymentPageWithTokenView(),
        );
        break;
      case SplashScreenViewRoute:
        return MaterialPageRoute(builder: (context) => SplashScreenView());
        break;
      case WelcomeViewRoute:
        return MaterialPageRoute(builder: (context) => WelcomeView());
        break;
      case VideoLibraryRoute:
        return MaterialPageRoute(builder: (context) => VideoLibrary());
        break;
      case LoginViewRoute:
        return MaterialPageRoute(builder: (context) => LoginView());
        break;
      case VerificationViewRoute:
        VerificationType verificationType;
        String email;
        Map arguments = settings.arguments;
        verificationType = arguments["verificationType"] as VerificationType;
        email = arguments["email"];
        return MaterialPageRoute(
            builder: (context) => VerificationView(
                  verificationType: verificationType,
                  email: email,
                ));
        break;
      case SignUpViewRoute:
        return MaterialPageRoute(builder: (context) => SignUpView());
        break;
      case PasswordViewRoute:
        PasswordType passwordType = settings.arguments as PasswordType;
        return MaterialPageRoute(
            builder: (context) => PasswordView(passwordType: passwordType));
        break;
      case ForgotPasswordViewRoute:
        return MaterialPageRoute(builder: (context) => ForgotPasswordView());
        break;
      case EmailLoginViewRoute:
        return MaterialPageRoute(builder: (context) => EmailLoginView());
        break;
      case AccountInfoViewRoute:
        return MaterialPageRoute(builder: (context) => AccountInfoView());
        break;
      case HomeViewRoute:
        return MaterialPageRoute(builder: (context) => HomeBaseView());
        break;
      case ArticleLibraryViewRoute:
        return MaterialPageRoute(builder: (context) => ArticleLibrary());
        break;
      case ArticleViewRoute:
        ArticleModel article = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => ArticleView(
            article: article,
          ),
        );
        break;
      case AudioPlaylistViewRoute:
        PlayListModel playList = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => AudioPlaylistView(
            playList: playList,
          ),
        );
        break;
      case AudioPlayerViewRoute:
        Map arguments = settings.arguments;
        List<AudioModel> audios = arguments["audios"];
        String playlistName = arguments["playlistName"];

        return MaterialPageRoute(
          builder: (context) => AudioPlayerView(
            audios: audios,
            playlistName: playlistName,
          ),
        );
        break;
      case VideoPlayerViewRoute:
        VideoModel video = settings.arguments;
        return MaterialPageRoute(
          builder: (BuildContext context) => VideoPlayerView(
            video: video,
          ),
        );
        break;
      case AudioLibraryViewRoute:
        return MaterialPageRoute(builder: (context) => AudioLibrary());
        break;
      case SearchViewRoute:
        ContentType contentType = settings.arguments;
        return MaterialPageRoute(builder: (context) => SearchView(contentType));
        break;
      case StoreItemViewRoute:
        Map arguments = settings.arguments;
        ContentModel content = arguments["content"];
        Function callback = arguments["callback"];
        assert(content != null);
        return CupertinoPageRoute(
          builder: (context) => StoreItemView(
            content: content,
            callback: callback,
          ),
        );
        break;
      case DynamicLinkEntryViewRoute:
        Map arguments = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => DynamicLinkEntryView(
            contentId: arguments["contentId"],
            contentType: arguments["contentType"],
          ),
        );
        break;
      case FeedbackViewRoute:
        return MaterialPageRoute(builder: (context) => FeedbackView());
        break;
      // case RoutePaths.splashScreen:
      //   return MaterialPageRoute(builder: (context) => SplashScreenView());
      //   break;
      // case RoutePaths.createNewPasswordView:
      //   return MaterialPageRoute(builder: (context) => CreateNewPasswordView());
      //   break;
      // case RoutePaths.accountInfoView:
      //   return MaterialPageRoute(builder: (context) => AccountInfoView());
      //   break;
      // case RoutePaths.forgotPasswordView:
      //   return MaterialPageRoute(builder: (context) => ForgotPasswordView());
      //   break;
      // case RoutePaths.loginOptionsView:
      //   return MaterialPageRoute(builder: (context) => LoginOptionsView());
      //   break;
      // case RoutePaths.loginView:
      //   return MaterialPageRoute(builder: (context) => LoginView());
      //   break;
      // case RoutePaths.signUpView:
      //   return MaterialPageRoute(builder: (context) => SignUpView());
      //   break;
      // case RoutePaths.verificationView:
      //   return MaterialPageRoute(builder: (context) => VerificationView());
      //   break;
      // case RoutePaths.welcomeView:
      //   return MaterialPageRoute(builder: (context) => WelcomeView());
      //   break;
      // case SignUpViewRoute:
      //   String userReference = settings.arguments;
      //   return MaterialPageRoute(builder: (context) => SignUpView(userReference:userReference));
      //   break;
      default:
        return MaterialPageRoute(
            builder: (context) => UndefinedRoute(name: settings.name));
    }
  }
}
