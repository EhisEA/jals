import 'package:flutter/material.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/ui/authentication/account_info_view.dart';
import 'package:jals/ui/authentication/create_new_password_view.dart';
import 'package:jals/ui/authentication/create_sign_up_password_view.dart';
import 'package:jals/ui/authentication/forgot_password_view.dart';
import 'package:jals/ui/authentication/login_options_view.dart';
import 'package:jals/ui/authentication/login_view.dart';
import 'package:jals/ui/authentication/sign_up_view.dart';
import 'package:jals/ui/authentication/splashscreen_view.dart';
import 'package:jals/ui/authentication/verification_forgot_password_view.dart.dart';
import 'package:jals/ui/authentication/verification_view.dart';
import 'package:jals/ui/authentication/welcome_view.dart';

import 'ui/undefinedRoute.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.verificationForgotPasswordView:
        return MaterialPageRoute(
            builder: (context) => VerificationForgotPasswordView());
        break;
      case RoutePaths.createSignUpPasswordView:
        return MaterialPageRoute(
            builder: (context) => CreateSignUpPasswordView());
        break;
      case RoutePaths.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreenView());
        break;
      case RoutePaths.createNewPasswordView:
        return MaterialPageRoute(builder: (context) => CreateNewPasswordView());
        break;
      case RoutePaths.accountInfoView:
        return MaterialPageRoute(builder: (context) => AccountInfoView());
        break;
      case RoutePaths.forgotPasswordView:
        return MaterialPageRoute(builder: (context) => ForgotPasswordView());
        break;
      case RoutePaths.loginOptionsView:
        return MaterialPageRoute(builder: (context) => LoginOptionsView());
        break;
      case RoutePaths.loginView:
        return MaterialPageRoute(builder: (context) => LoginView());
        break;
      case RoutePaths.signUpView:
        return MaterialPageRoute(builder: (context) => SignUpView());
        break;
      case RoutePaths.verificationView:
        return MaterialPageRoute(builder: (context) => VerificationView());
        break;
      case RoutePaths.welcomeView:
        return MaterialPageRoute(builder: (context) => WelcomeView());
        break;
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
