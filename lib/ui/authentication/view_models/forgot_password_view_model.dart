import 'package:flutter/material.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';

import '../../../utils/locator.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  verifyEmail() async {
    _navigationService.navigateToReplace(VerificationViewRoute);
  }

  toLogin() async {
    _navigationService.navigateToReplace(LoginViewRoute);
  }
}
