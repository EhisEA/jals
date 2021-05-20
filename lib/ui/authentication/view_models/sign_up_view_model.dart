import 'package:flutter/material.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/enums/verification_type.dart';
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
  @override
  dispose() {
    emailController.dispose();
    super.dispose();
  }

  verifyEmail() async {
    if (formKey.currentState.validate()) {
      setBusy(ViewState.Busy);
      await _networkConfig.onNetworkAvailabilityToast(onNetwork);
      setBusy(ViewState.Idle);
    }
    return null;
  }

  onNetwork() async {
    try {
      ApiResponse respone =
          await _authenticationService.verifyEmail(email: emailController.text);

      if (respone == ApiResponse.Success) {
        VerificationType verificationType = VerificationType.NewUser;
        _navigationService.navigateTo(
          VerificationViewRoute,
          argument: {
            "verificationType": verificationType,
            "email": emailController.text
          },
        );
      }
    } catch (e) {
      print(e);
      await _dialogService.showDialog(
        buttonTitle: "OK",
        description: "Something went wrong",
        title: "Sign Up Error",
      );
    }
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

  toLogin() async {
    _navigationService.navigateToReplace(LoginViewRoute);
  }
}
