import 'package:jals/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';

import '../../../locator.dart';

class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  toEmailSignUp() async {
    _navigationService.navigateToReplace(SignUpViewRoute);
  }

  googleSignUp() async {}

  toLogin() async {
    _navigationService.navigateToReplace(LoginViewRoute);
  }
}
