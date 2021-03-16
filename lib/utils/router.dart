import 'package:flutter/material.dart';
import 'package:jals/enums/password_type.dart';
import 'package:jals/enums/verification_type.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/ui/article/article_library_view.dart';
import 'package:jals/ui/article/article_view.dart';
import 'package:jals/ui/authentication/account_info_view.dart';
import 'package:jals/ui/authentication/email_login_view.dart';
import 'package:jals/ui/authentication/forgot_password_view.dart';
import 'package:jals/ui/authentication/login_view.dart';
import 'package:jals/ui/authentication/password_view.dart';
import 'package:jals/ui/authentication/sign_up_view.dart';
import 'package:jals/ui/authentication/splashscreen_view.dart';
import 'package:jals/ui/authentication/verification_view.dart';
import 'package:jals/ui/authentication/welcome_view.dart';
import 'package:jals/ui/home/home_base.dart';
import 'package:jals/ui/video/video_library_view.dart';

import '../ui/undefinedRoute.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
        verificationType = settings.arguments as VerificationType;
        return MaterialPageRoute(
            builder: (context) => VerificationView(
                  verificationType: verificationType,
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
      // case :
      //   return MaterialPageRoute(
      //       builder: (context) => VerificationForgotPasswordView());
      //   break;
      // case RoutePaths.createSignUpPasswordView:
      //   return MaterialPageRoute(
      //       builder: (context) => CreateSignUpPasswordView());
      //   break;
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
