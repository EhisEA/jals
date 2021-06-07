import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/ui/home/components/edit_text_field.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/image_select.dart';
import 'package:jals/utils/jals_icons_icons.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/widgets/button.dart';
import 'package:stacked/stacked.dart' as viewmodel;
import 'package:velocity_x/velocity_x.dart';

enum UserUpdateType { FULLNAME, PHONE, DATEOFBIRTH, PASSWORD }

class SettingsViewModel extends BaseViewModel with ImageSelect {
  FocusNode _focusDateField = FocusNode();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String get avatar => _authenticationService.currentUser.avatar;
  String get email => _authenticationService.currentUser.email;
  String get fullname => _authenticationService.currentUser.fullName;
  String get phone => _authenticationService.currentUser.phoneNumber;
  DateTime get dateOfBirth => _authenticationService.currentUser.dateOfBirth;

  update(BuildContext context, UserUpdateType updateType,
      SettingsViewModel model) {
    switch (updateType) {
      case UserUpdateType.FULLNAME:
        changeNameOrPhone(context, updateType, model);
        break;
      case UserUpdateType.PHONE:
        changeNameOrPhone(context, updateType, model);
        break;
      case UserUpdateType.DATEOFBIRTH:
        changBirthDate(context, model);
        break;
      case UserUpdateType.PASSWORD:
        changePassword(context, model);
        break;
      default:
    }
  }

// ============================================================
// ============================================================
// ========================== Change Image=====================
// ============================================================

  final picker = ImagePicker();
  Future _updateProfileImage(ImageSource imageSource) async {
    File image;
    setSecondaryBusy(ViewState.Busy);

    // final pickedFile = await select(context);
    final pickedFile = await picker.getImage(source: imageSource);
    if (pickedFile == null) {
      print('empty');
      setSecondaryBusy(ViewState.Idle);
      return;
    }

    if (pickedFile != null) {
      image = File(pickedFile.path);

      ApiResponse response =
          await _authenticationService.createUserAccountInfo(avatar: image);
      if (response == ApiResponse.Success) {
        Fluttertoast.showToast(
          msg: "Profile image updated",
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Profile image failed to updated",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    }
    setSecondaryBusy(ViewState.Idle);
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
                      _updateProfileImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    text: "Gallery"),
                Padding(padding: EdgeInsets.all(8.0)),
                DefaultButtonBorderedIcon(
                    icon: Icons.camera_alt,
                    press: () {
                      _updateProfileImage(ImageSource.camera);
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

// ============================================================
// ============================================================
// ==================== Change Name or phone no================
// ============================================================
// ============================================================
  changeNameOrPhone(
      context, UserUpdateType updateType, SettingsViewModel settingModel) {
    bool isName = updateType == UserUpdateType.FULLNAME;
    TextEditingController _controller =
        TextEditingController(text: isName ? fullname ?? "" : phone ?? "");

    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) => viewmodel
              .ViewModelBuilder<SettingsViewModel>.reactive(
          viewModelBuilder: () => settingModel,
          disposeViewModel: false,
          builder: (context, model, _) {
            return AlertDialog(
                backgroundColor: Colors.transparent,
                content: StatefulBuilder(
                  builder: (context, setState) {
                    return model.isBusy
                        ? buildCard2(children: [
                            Center(child: CircularProgressIndicator())
                          ])
                        : buildCard2(
                            children: [
                              Text(
                                "Edit Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: getProportionatefontSize(16)),
                              ).p(30),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Full Name",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              EditTextField(
                                borderType: EditTextFieldBorderType.roundLine,
                                borderRadius: 0,
                                maxLine: 1,
                                controller: _controller,
                                // isPassword: true,
                                borderColor: Colors.grey.shade300,
                                onChanged: (value) => setState(() {}),
                                clear: false,
                                fillColor: Colors.white,
                                prefixIcon:
                                    Icon(isName ? Icons.person : Icons.phone),
                              ),
                              SizedBox(height: 30),
                              InkWell(
                                onTap: () {
                                  fullname != _controller.text.trim() ||
                                          phone != _controller.text.trim()
                                      ? changeNameOrPhoneNetworkCall(
                                          isName, _controller.text)
                                      : print("");
                                },
                                child: Center(
                                  child: Text(
                                    "Save Changes",
                                    style: TextStyle(
                                        color: isName
                                            ? fullname !=
                                                    _controller.text.trim()
                                                ? Colors.white
                                                : kTextColor
                                            : phone != _controller.text.trim()
                                                ? Colors.white
                                                : kTextColor),
                                  ),
                                ),
                              ).p20().backgroundColor(isName
                                  ? fullname != _controller.text.trim()
                                      ? kPrimaryColor
                                      : Colors.grey.shade100
                                  : phone != _controller.text.trim()
                                      ? kPrimaryColor
                                      : Colors.grey.shade100),
                              // SizedBox(height: 10),
                              Text("Cancel").p20().onTap(() {
                                Navigator.of(context).pop();
                              })
                            ],
                          );
                  },
                ));
          }),
    );
  }

  changeNameOrPhoneNetworkCall(bool isName, String value) async {
    setBusy(ViewState.Busy);
    ApiResponse response = isName
        ? await _authenticationService.createUserAccountInfo(fullName: value)
        : await _authenticationService.createUserAccountInfo(
            phoneNumber: value);

    if (response == ApiResponse.Success) {
      Fluttertoast.showToast(
        msg: isName ? "Fullname updated" : "Phone number updated",
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: isName
            ? "Fullname failed to updated"
            : "Phone number failed to updated",
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
    setBusy(ViewState.Idle);
  }
// ============================================================
// ============================================================
// ==================== Change Password================
// ============================================================
// ============================================================

  changePassword(context, SettingsViewModel settingModel) {
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();

    return showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) =>
            viewmodel.ViewModelBuilder<SettingsViewModel>.reactive(
              viewModelBuilder: () => settingModel,
              disposeViewModel: false,
              builder: (context, model, _) => AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: StatefulBuilder(
                    builder: (context, setState) {
                      return model.isBusy
                          ? buildCard2(
                              children: [
                                Center(child: CircularProgressIndicator())
                              ],
                            )
                          : buildCard2(
                              children: [
                                Text(
                                  "Edit Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: getProportionatefontSize(16)),
                                ).p(30),
                                SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Old Password",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                EditTextField(
                                  borderType: EditTextFieldBorderType.roundLine,
                                  borderRadius: 0,
                                  isPassword: true,
                                  obscureText: true,
                                  maxLine: 1,
                                  controller: oldPasswordController,
                                  // isPassword: true,
                                  borderColor: Colors.grey.shade300,
                                  onChanged: (value) => setState(() {}),
                                  clear: false,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(JalsIcons.password),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "New Password",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                EditTextField(
                                  borderType: EditTextFieldBorderType.roundLine,
                                  borderRadius: 0,
                                  isPassword: true,
                                  obscureText: true,
                                  maxLine: 1,
                                  controller: newPasswordController,
                                  borderColor: Colors.grey.shade300,
                                  onChanged: (value) => setState(() {}),
                                  clear: false,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(JalsIcons.password),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        if (oldPasswordController.text.length >=
                                                8 &&
                                            newPasswordController.text.length >=
                                                8)
                                          _changePasswordNetworkCall(
                                              oldPasswordController.text,
                                              newPasswordController.text);
                                      },
                                      child: Text(
                                        "Save Changes",
                                        style: TextStyle(
                                            color: oldPasswordController
                                                            .text.length >=
                                                        8 &&
                                                    newPasswordController
                                                            .text.length >=
                                                        8
                                                ? Colors.white
                                                : kTextColor),
                                      ),
                                    ),
                                  ),
                                ).p20().backgroundColor(
                                    oldPasswordController.text.length >= 8 &&
                                            newPasswordController.text.length >=
                                                8
                                        ? kPrimaryColor
                                        : Colors.grey.shade100),
                                // SizedBox(height: 10),
                                Text("Cancel").p20().onTap(() {
                                  Navigator.of(context).pop();
                                })
                              ],
                            );
                    },
                  )),
            ));
  }

  _changePasswordNetworkCall(String oldPassword, String newPassword) async {
    setBusy(ViewState.Busy);
    ApiResponse response = await _authenticationService.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);

    switch (response) {
      case ApiResponse.Success:
        Fluttertoast.showToast(
          msg: "Password updated",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
        );

        break;
      case ApiResponse.Error:
        Fluttertoast.showToast(
          msg: "Incorrect old password",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

        break;
      default:
        Fluttertoast.showToast(
          msg: "Password failed to updated",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
    }
    setBusy(ViewState.Idle);
  }
// ============================================================
// ============================================================
// ========================= Change Date ======================
// ============================================================
// ============================================================

  pickDate(BuildContext context, DateTime currentDate) async {
    DateTime date = await showDatePicker(
      initialDate: currentDate,
      context: context,
      firstDate: DateTime(1800),
      lastDate: DateTime(DateTime.now().year - 4),
    );
    if (date != null) {
      return date;
    }
    return null;
  }

  changBirthDate(BuildContext context, SettingsViewModel settingsModel) {
    // created a temp date variable to hold date of birth value
    //and also make it safe to alter it value
    //to avoid tampering with the main date of birth values
    DateTime tempPickedDate = dateOfBirth;
    //create a controller for date text field
    //assigning the textfield the current date value
    TextEditingController _controller = TextEditingController();
    // created a function for altering controller value
    //to avoid repeated code
    _changeControllerValue() {
      _controller.text = tempPickedDate == null
          ? ""
          : "${DateFormat('dd/MM/yyyy').format(tempPickedDate)}";
    }

    _changeControllerValue();
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) =>
          viewmodel.ViewModelBuilder<SettingsViewModel>.reactive(
        viewModelBuilder: () => settingsModel,
        disposeViewModel: false,
        builder: (context, model, _) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: StatefulBuilder(
              builder: (context, setState) {
                _focusDateField.unfocus();
                return model.isBusy
                    ? buildCard2(
                        children: [Center(child: CircularProgressIndicator())])
                    : buildCard2(
                        children: [
                          Text(
                            "Edit Birth Date",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: getProportionatefontSize(16)),
                          ).p(30),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Birth Date",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Container(
                            width: getProportionateScreenWidth(334),
                            color: Colors.white,
                            child: TextFormField(
                              focusNode: _focusDateField,
                              validator: (value) => value.isEmpty
                                  ? "Date of birth cannot be empty"
                                  : null,
                              controller: _controller,
                              onTap: () async {
                                tempPickedDate = await pickDate(context,
                                        tempPickedDate ?? DateTime.now()) ??
                                    tempPickedDate;
                                setState(() {
                                  _changeControllerValue();
                                  _focusDateField.unfocus();
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(JalsIcons.date),
                                hintText: "31/07/1986",
                                contentPadding: const EdgeInsets.only(top: 7),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              if (dateOfBirth != tempPickedDate)
                                changeDateNetworkCall(
                                    "${tempPickedDate.year}-${tempPickedDate.month}-${tempPickedDate.day}");
                            },
                            child: Center(
                              child: Text(
                                "Save Changes",
                                style: TextStyle(
                                  color: dateOfBirth != tempPickedDate
                                      ? Colors.white
                                      : kTextColor,
                                ),
                              ),
                            ).p20().backgroundColor(
                                dateOfBirth != tempPickedDate
                                    ? kPrimaryColor
                                    : Colors.grey.shade100),
                          ),
                          SizedBox(height: 10),
                          Text("Cancel").p20().onTap(() {
                            Navigator.of(context).pop();
                          })
                        ],
                      );
              },
            ),
          );
        },
      ),
    );
  }

  changeDateNetworkCall(String value) async {
    setBusy(ViewState.Busy);
    ApiResponse response =
        await _authenticationService.createUserAccountInfo(dateOfBirth: value);

    if (response == ApiResponse.Success) {
      Fluttertoast.showToast(
        msg: "Date of birth updated",
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Date of birth failed to updated",
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
    setBusy(ViewState.Idle);
  }
// ============================================================
// ============================================================
// ============================ widgets =======================
// ============================================================
// ============================================================

  buildCard2({String title, IconData icon, List<Widget> children}) {
    return Container(
      width: 300,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          child: Column(children: children).pLTRB(30, 10, 30, 25),
        ),
      ).p12(),
    );
  }

  Widget buildDateOfBirthField(BuildContext context,
      {@required VoidCallback callBack,
      @required TextEditingController controller}) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Date of Birth",
            style: TextStyle(
              fontSize: getProportionatefontSize(12),
              color: Color(0xff1F2230).withOpacity(0.64),
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            )),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Container(
          width: getProportionateScreenWidth(334),
          color: Colors.white,
          child: TextFormField(
            focusNode: _focusDateField,
            validator: (value) =>
                value.isEmpty ? "Date of birth cannot be empty" : null,
            controller: controller,
            onTap: callBack,
            decoration: InputDecoration(
              prefixIcon: Icon(JalsIcons.date),
              hintText: "31/07/1986",
              contentPadding: const EdgeInsets.only(top: 7),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
            ),
          ),
        )
      ],
    );
  }

  void logOut() {
    _authenticationService.logOut();
  }

  void toFeedback() {
    _navigationService.navigateTo(FeedbackViewRoute);
  }
}
