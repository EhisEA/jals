import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';

import '../../../utils/locator.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  toEmailLogin() async {
    _navigationService.navigateToReplace(EmailLoginViewRoute);
  }

  googleSignIn() async {}
  facebookSignIn() async {}

  toSignUp() async {
    _navigationService.navigateToReplace(SignUpViewRoute);
  }
}
