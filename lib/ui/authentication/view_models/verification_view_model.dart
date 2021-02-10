import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../utils/locator.dart';

class VerificationViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final TextEditingController verificationController = TextEditingController();
  // ignore: close_sinks
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  String currentText = "";

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  DialogService _dialogService = locator<DialogService>();
  @override
  void dispose() {
    verificationController.dispose();
    errorController.close();
    super.dispose();
  }

  verify() async {
    setBusy(ViewState.Busy);
    ApiResponse response = await _authenticationService.pushOtpCode(
      code: verificationController.text,
    );
    setBusy(ViewState.Idle);
    if (response == ApiResponse.Success) {
      Future.microtask(
          () => print("The future dot microtask function is running"));
      Future.delayed(Duration(seconds: 2), () {
        print("The future dot delayed function is running");
        _navigationService.navigateToReplace(PasswordViewRoute);
      });
    } else {
      await _dialogService.showDialog(
          buttonTitle: "OK",
          description: "The Code does not match",
          title: "Code Error");
    }
  }

  onTextChange(String value) {
    print(value);
    currentText = value;
    setBusy(ViewState.Idle);
  }

  resendCode() async {}
}
