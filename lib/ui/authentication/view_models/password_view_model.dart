import 'package:flutter/material.dart';
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

  confirmPassword() async {
    _navigationService.navigateToReplace(AccountInfoViewRoute);
    try {
      await _networkConfig.onNetworkAvailabilityDialog(onNetwork);
    } catch (e) {}
  }

  onNetwork() async {}
}
