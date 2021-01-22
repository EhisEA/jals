import 'package:flutter/material.dart';
import 'package:jals/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';

import '../../../locator.dart';

class AccountInfoViewModel extends BaseViewModel {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    dateController.dispose();
    super.dispose();
  }

  uploadDetails() {
    _navigationService.navigateTo(HomeViewRoute);
  }

  skip() {
    _navigationService.navigateTo(HomeViewRoute);
  }
}
