import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/network_utils.dart';
import 'package:jals/widgets/button.dart';

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
  DateTime pickedDate = DateTime(2000);
  String currentAvatar;
  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    dateController.dispose();
    super.dispose();
  }

  AccountInfoViewModel() {
    currentAvatar = _authenticationService.currentUser.avatar;
    nameController.text = _authenticationService.currentUser.fullName;
    phoneNumberController.text = _authenticationService.currentUser.phoneNumber;
    dateController.text = _authenticationService.currentUser.dateOfBirth == null
        ? null
        : "${DateFormat('dd/MM/yyyy').format(_authenticationService.currentUser.dateOfBirth)}";
    pickedDate =
        _authenticationService.currentUser.dateOfBirth ?? DateTime(2000, 2, 2);
  }
  pickDate(BuildContext context) async {
    DateTime date = await showDatePicker(
      initialDate: pickedDate,
      context: context,
      firstDate: DateTime(1800),
      lastDate: DateTime(DateTime.now().year - 4),
    );
    if (date != null) {
      pickedDate = date;
    }
    notifyListeners();
  }

  uploadDetails() async {
    if (formKey.currentState.validate()) {
      setBusy(ViewState.Busy);
      await _networkConfig.onNetworkAvailabilityDialog(onNetwork);
      setBusy(ViewState.Idle);
    } else {
      return null;
    }
  }

  onNetwork() async {
    try {
      ApiResponse apiResponse =
          await _authenticationService.createUserAccountInfo(
              avatar: image,
              dateOfBirth:
                  "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}",
              phoneNumber: phoneNumberController.text,
              fullName: nameController.text);
      if (apiResponse == ApiResponse.Success) {
        print("Success");
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

  // ===============================================
  // ===================== Image ================
  // ================================================

  final picker = ImagePicker();
  String imageUrl;
  File image;

  Future _getImage(source) async {
    setSecondaryBusy(ViewState.Busy);
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setSecondaryBusy(ViewState.Idle);
    }
  }

  showImageSelectionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kScaffoldColor,
          title: Text("Select photo from"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                DefaultButtonBorderedIcon(
                    icon: Icons.perm_media,
                    press: () {
                      _getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    text: "Gallery"),
                Padding(padding: EdgeInsets.all(8.0)),
                DefaultButtonBorderedIcon(
                    icon: Icons.camera_alt,
                    press: () {
                      _getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    text: "Camera"),
              ],
            ),
          ),
        );
      },
    );
  }
}
