import 'package:jals/enums/api_response.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';

import '../../../utils/locator.dart';

class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  toEmailSignUp() async {
    _navigationService.navigateToReplace(SignUpViewRoute);
  }

  googleSignUp() async {
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
      }
    } catch (e) {
      await _dialogService.showDialog(
          buttonTitle: "OK",
          description: "Check your internet connection",
          title: "Login Error");
    }
    setBusy(ViewState.Idle);
  }

  facebookSignUp() async {
    setBusy(ViewState.Busy);
    try {
      ApiResponse apiResponse =
          await _authenticationService.loginWithFacebook();
      if (isDisposed) return;
      if (apiResponse == ApiResponse.Success) {
        if (_authenticationService.currentUser.isDetailsComplete()) {
          await _navigationService.navigateToReplace(HomeViewRoute);
        } else {
          await _navigationService.navigateToReplace(AccountInfoViewRoute);
        }
      }
    } catch (e) {
      await _dialogService.showDialog(
          buttonTitle: "OK",
          description: "Check your internet connection",
          title: "Login Error");
    }
    setBusy(ViewState.Idle);
  }

  toLogin() async {
    _navigationService.navigateToReplace(LoginViewRoute);
  }
}
