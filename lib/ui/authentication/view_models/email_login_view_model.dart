import 'package:flutter/material.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';

import '../../../utils/locator.dart';

class EmailLoginViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  login() async {
    try {
      // !I haven't made my network check.
      ApiResponse apiResponse = await _authenticationService.loginWithEmail(
          email: emailController.text, password: passwordController.text);
      if (apiResponse == ApiResponse.Success) {
        _navigationService.navigateToReplace(HomeViewRoute);
      } else {
        // ! show handle error.
      }
    } catch (e) {
      print(e);
    }
  }

  googleSignIn() async {}
  facebookSignIn() async {}

  toSignUp() async {
    _navigationService.navigateToReplace(SignUpViewRoute);
  }

  toForgotPassword() async {
    _navigationService.navigateTo(ForgotPasswordViewRoute);
  }
}
