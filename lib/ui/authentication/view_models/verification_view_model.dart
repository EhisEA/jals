import 'dart:async';

import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    verificationController.dispose();
    errorController.close();
    super.dispose();
  }

  verify() async {
    _navigationService.navigateToReplace(PasswordViewRoute);
  }

  onTextChange(String value) {
    print(value);
    currentText = value;
    setBusy(ViewState.Idle);
  }

  resendCode() async {}
}
