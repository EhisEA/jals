import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/ui/authentication/components/auth_appBar.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationView extends StatefulWidget {
  @override
  _VerificationViewState createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final TextEditingController verificationController = TextEditingController();
  // ignore: close_sinks
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  String currentText = "";
  @override
  void dispose() {
    verificationController.dispose();
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: UIHelper.kSidePadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AuthAppBar(
                  subtitle: "Please enter code sent to Johndoe@gmail.com",
                  title: "Verify Email",
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Row(
                  children: [
                    Text(
                      "Enter OTP Code",
                      style: GoogleFonts.sourceSansPro(
                          color: Color(0xff1F2230).withOpacity(.64),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: getProportionatefontSize(12)),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                pinCode(),
// !end
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                CustomButton(
                  color: Color(0xff3C8AF0),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RoutePaths.createSignUpPasswordView);
                  },
                  title: "Verify Email",
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Text(
                  "Resend Code",
                  style: TextStyle(
                    fontSize: getProportionatefontSize(14),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: Color(0xff01CC97),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pinCode() {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.blue,
      ),
      child: PinCodeTextField(
        // obsecureText: true,

        length: 6,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          fieldHeight: getProportionateScreenHeight(49),
          fieldWidth: getProportionateScreenWidth(51),
          activeFillColor: Colors.white,
        ),
        animationDuration: Duration(milliseconds: 300),
        // backgroundColor: Colors.blue.shade50,
        // enableActiveFill: true,
        errorAnimationController: errorController,
        controller: verificationController,
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) {
          print(value);
          setState(() {
            currentText = value;
          });
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),
    );
  }
}
