import 'package:flutter/material.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';

import '../../../utils/locator.dart';

class SignUpViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  verifyEmail() async {
    if (formKey.currentState.validate()) {
      await _authenticationService.sendSignUpEmail(emailController.text);
      _navigationService.navigateToReplace(VerificationViewRoute);
    }
  }

  googleSignIn() async {}
  facebookSignIn() async {}

  toLogin() async {
    _navigationService.navigateToReplace(LoginViewRoute);
  }
}
