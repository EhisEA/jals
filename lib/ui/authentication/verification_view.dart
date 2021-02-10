import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jals/ui/authentication/components/auth_appBar.dart';
import 'package:jals/ui/authentication/view_models/verification_view_model.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

class VerificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<VerificationViewModel>.nonReactive(
        viewModelBuilder: () => VerificationViewModel(),
        builder: (context, model, _) {
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
                      pinCode(model),
// !end
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      model.state == ViewState.Busy
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.blue,
                              ),
                            )
                          : DefaultButton(
                              color: Color(0xff3C8AF0),
                              onPressed: model.verify,
                              title: "Verify Email",
                            ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      InkWell(
                        onTap: model.resendCode,
                        child: Text(
                          "Resend Code",
                          style: TextStyle(
                            fontSize: getProportionatefontSize(14),
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            color: Color(0xff01CC97),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget pinCode(VerificationViewModel model) {
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
        errorAnimationController: model.errorController,
        controller: model.verificationController,
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) => model.onTextChange(value),
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
