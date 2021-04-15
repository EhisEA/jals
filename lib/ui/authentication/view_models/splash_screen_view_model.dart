import 'package:jals/models/login_status.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/dynamic_link_service.dart';
import 'package:jals/utils/base_view_model.dart';

import 'package:jals/services/navigationService.dart';

import '../../../utils/locator.dart';

class SplashScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
  checkLoginStatus() async {
    // _authenticationService.logOut();
    _dynamicLinkService.handleDynamicLink();
    LoginStatus loginStatus = await _authenticationService.isUserLoggedIn();

    switch (loginStatus) {
      case LoginStatus.NoUser:
        _navigationService.navigateToReplace(WelcomeViewRoute);

        break;
      case LoginStatus.LoginComplete:
        _navigationService.navigateToReplace(HomeViewRoute);
        break;
      case LoginStatus.LoginIncomplete:
        _navigationService.navigateToReplace(AccountInfoViewRoute);
        break;
      default:
        _navigationService.navigateToReplace(WelcomeViewRoute);
    }
  }
}
