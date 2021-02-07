import 'package:flutter/material.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/network_utils.dart';

import '../../../utils/locator.dart';

class SignUpViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NetworkConfig _networkConfig = new NetworkConfig();
  DialogService _dialogService = locator<DialogService>();
  verifyEmail() async {
    if (formKey.currentState.validate()) {
      setBusy(ViewState.Busy);
      await _networkConfig.onNetworkAvailabilityDialog(onNetwork);
      setBusy(ViewState.Idle);
    }
    return null;
  }

  onNetwork() async {
    try {
      setBusy(ViewState.Busy);
      ApiResponse respone =
          await _authenticationService.checkEmail(email: emailController.text);
      setBusy(ViewState.Idle);
      if (respone == ApiResponse.Success) {
        _navigationService.navigateToReplace(VerificationViewRoute);
      } else {
        await _dialogService.showDialog(
          buttonTitle: "OK",
          description:
              "Sorry, this email address has been registered with already. Please try a new one .",
          title: "Sign Up Error",
        );
      }
    } catch (e) {
      print(e);
    }
  }

  googleSignIn() async {}
  facebookSignIn() async {}

  toLogin() async {
    _navigationService.navigateToReplace(LoginViewRoute);
  }
}
