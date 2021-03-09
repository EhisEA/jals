import 'package:flutter/material.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/enums/password_type.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/dialog_service.dart';

import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/network_utils.dart';

import '../../../utils/locator.dart';

class PasswordViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController passwordController = TextEditingController();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  DialogService _dialogService = locator<DialogService>();
  NetworkConfig _networkConfig = new NetworkConfig();
  PasswordType _passwordType;
  PasswordType get passowrdType => _passwordType;
  onModelReady(PasswordType type) {
    _passwordType = type;
    notifyListeners();
  }

  confirmPassword() async {
    setBusy(ViewState.Busy);
    await _networkConfig
        .onNetworkAvailabilityDialog(confirmPasswordNetworkCall);
    setBusy(ViewState.Idle);
  }

  confirmPasswordNetworkCall() async {
    try {
      ApiResponse response = _passwordType == PasswordType.NewPassword
          ? await _authenticationService.registerUser(
              password: passwordController.text,
            )
          : await _authenticationService
              .sendForgotPassword(passwordController.text);
      if (response == ApiResponse.Success) {
        print("Password Updating was succesfull");
        _navigationService.navigateToReplace(AccountInfoViewRoute);
      }
    } catch (e) {
      await _dialogService.showDialog(
          buttonTitle: "OK",
          description: "Something Went Wrong",
          title: "Sign Up Error");
    }
  }
}
