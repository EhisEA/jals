import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/enums/password_type.dart';
import 'package:jals/enums/verification_type.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../utils/locator.dart';

class VerificationViewModel extends BaseViewModel {
  // !==================Declarations=========================
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController verificationController = TextEditingController();
  // ignore: close_sinks
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  String currentText = "";
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  DialogService _dialogService = locator<DialogService>();
  VerificationType _verificationType;
  VerificationType get verificationType => _verificationType;
  //!========Dispose Method===================
  @override
  void dispose() {
    // verificationController.dispose();
    errorController.close();
    super.dispose();
  }

// !==============OnModelReady Function============
  checkVerificationType(VerificationType type) {
    _verificationType = type;
    notifyListeners();
  }

// !=================Verify Email Function===============
  verify() async {
    setBusy(ViewState.Busy);
    ApiResponse response = await _authenticationService.validateOtpCode(
      code: verificationController.text,
    );
    if (response == ApiResponse.Success) {
      PasswordType newPassword = PasswordType.NewPassword;
      PasswordType forgotPassword = PasswordType.ForgotPassword;
      Future.delayed(Duration(seconds: 3), () {
        _navigationService.navigateToReplace(
          PasswordViewRoute,
          argument: _verificationType == VerificationType.NewUser
              ? newPassword
              : forgotPassword,
        );
      });
    } else {
      verificationController.clear();
      await _dialogService.showDialog(
          buttonTitle: "OK",
          description: "The Code does not match",
          title: "Code Error");
    }
    setBusy(ViewState.Idle);
  }

  onTextChange(String value) {
    print(value);
    currentText = value;
    setBusy(ViewState.Idle);
  }

  resendCode() async {
    setBusy(ViewState.Busy);
    print("sending code to email");
    setBusy(ViewState.Idle);
  }
}
