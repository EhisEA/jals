import 'package:jals/route_paths.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/utils/base_view_model.dart';

import 'package:jals/services/navigationService.dart';

import '../../../utils/locator.dart';

class SplashScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 3), () async {
      bool isValid = await _authenticationService.autoLogin();
      if (isValid) {
        _navigationService.navigateToReplace(HomeViewRoute);
      } else {
        _navigationService.navigateToReplace(WelcomeViewRoute);
      }
    });
  }
}
