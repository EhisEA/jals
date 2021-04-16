import 'package:jals/enums/api_response.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';

import '../../../utils/locator.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  toEmailLogin() async {
    _navigationService.navigateToReplace(EmailLoginViewRoute);
  }

  googleSignIn() async {
    setBusy(ViewState.Busy);
    try {
      ApiResponse apiResponse = await _authenticationService.loginWithGoogle();
      if (isDisposed) return;
      if (apiResponse == ApiResponse.Success) {
        if (_authenticationService.currentUser.isDetailsComplete()) {
          await _navigationService.navigateToReplace(HomeViewRoute);
        } else {
          await _navigationService.navigateToReplace(AccountInfoViewRoute);
        }
      } else {
        // ! show handle error.
        await _dialogService.showDialog(
            buttonTitle: "OK",
            description: "Invalid Credentials",
            title: "Login Error");
      }
    } catch (e) {
      await _dialogService.showDialog(
          buttonTitle: "OK",
          description: "Check your internet connection",
          title: "Login Error");
    }
    setBusy(ViewState.Idle);
  }

  facebookSignIn() async {}

  toSignUp() async {
    _navigationService.navigateToReplace(SignUpViewRoute);
  }
}
