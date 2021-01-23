import 'package:flutter/material.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';

import '../../../utils/locator.dart';

class EmailLoginViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  login() async {
    _navigationService.navigateToReplace(HomeViewRoute);
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
