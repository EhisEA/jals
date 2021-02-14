import 'package:flutter/material.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/network_utils.dart';

import '../../../utils/locator.dart';

class AccountInfoViewModel extends BaseViewModel {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  DialogService _dialogService = locator<DialogService>();
  NetworkConfig _networkConfig = new NetworkConfig();
  DateTime pickedDate;
  TimeOfDay pickedTime;
  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    dateController.dispose();
    super.dispose();
  }

  onModelReady() {
    pickedDate = DateTime.now();
    pickedTime = TimeOfDay.now();
  }

  pickDate(BuildContext context) async {
    DateTime date = await showDatePicker(
      initialDate: pickedDate,
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (date != null) {
      pickedDate = date;
      notifyListeners();
    }
  }

  uploadDetails() {
    if (formKey.currentState.validate()) {
      setBusy(ViewState.Busy);
      _networkConfig.onNetworkAvailabilityDialog(onNetwork);
      setBusy(ViewState.Idle);
    } else {
      return null;
    }
  }

  onNetwork() async {
    try {
      ApiResponse apiResponse =
          await _authenticationService.createUserAccountIfno(
              avatarUrl: "",
              dateOfBirth: pickedDate.toString(),
              phoneNumber: phoneNumberController.text,
              userName: nameController.text);
      if (apiResponse == ApiResponse.Success) {
        _navigationService.navigateTo(HomeViewRoute);
      }
    } catch (e) {
      print(e);
      _dialogService.showDialog(
          buttonTitle: "OK",
          description: "Something went wrong",
          title: "Account Verification Error");
    }
  }

  skip() {
    _navigationService.navigateTo(HomeViewRoute);
  }
}
