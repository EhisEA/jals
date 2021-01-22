import 'package:flutter/material.dart';
import 'package:jals/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';

import '../../../locator.dart';

class SignUpViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final NavigationService _navigationService = locator<NavigationService>();
  verifyEmail() async {
    _navigationService.navigateToReplace(VerificationViewRoute);
  }

  googleSignIn() async {}
  facebookSignIn() async {}

  toLogin() async {
    _navigationService.navigateToReplace(LoginViewRoute);
  }
}
