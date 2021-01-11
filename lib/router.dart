import 'package:flutter/material.dart';

import 'ui/undefinedRoute.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case IntroViewRoute:
      //   return MaterialPageRoute(builder: (context) => SplashScreen());
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
