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

class ForgotPasswordViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DialogService _dialogService = locator<DialogService>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NetworkConfig _networkConfig = new NetworkConfig();

  verifyEmail() async {
    if (formKey.currentState.validate()) {
      setBusy(ViewState.Busy);
      await onNetworkCall(); // _networkConfig.onNetworkAvailabilityDialog(onNetworkCall);
      setBusy(ViewState.Busy);
    } else {
      return null;
    }
  }

  onNetworkCall() async {
    try {
      ApiResponse apiResponse = await _authenticationService
          .sendForgotPasswordEmail(email: emailController.text);
      if (apiResponse == ApiResponse.Success) {
        print("Successful");
        VerificationType verificationType = VerificationType.NewUser;
        _navigationService.navigateToReplace(VerificationViewRoute,
            argument: verificationType);
      }
    } catch (e) {
      print(e);
      _dialogService.showDialog(
          buttonTitle: "OK",
          description: "Something went wrong",
          title: "Forgot Password Error");
    }
  }

  toLogin() async {
    _navigationService.navigateToReplace(LoginViewRoute);
  }
}
