import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jals/enums/verification_type.dart';
import 'package:jals/ui/authentication/components/auth_appBar.dart';
import 'package:jals/ui/authentication/components/pin_code_text_field.dart';
import 'package:jals/ui/authentication/view_models/verification_view_model.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/button.dart';
import 'package:jals/widgets/loader_page.dart';
import 'package:stacked/stacked.dart';

import 'components/pin_theme.dart';

class VerificationView extends StatelessWidget {
  final VerificationType verificationType;
  VerificationView({@required this.verificationType});
  @override
  Widget build(BuildContext context) {
    verificationType == VerificationType.ForgotPassword
        ? print("VerificationType Password")
        : print("VerificationType NewUser");
    SizeConfig().init(context);
    return ViewModelBuilder<VerificationViewModel>.reactive(
        viewModelBuilder: () => VerificationViewModel(),
        onModelReady: (model) => model.checkVerificationType(verificationType),
        builder: (context, model, _) {
          return LoaderPageBlank(
            busy: model.isBusy,
            child: SafeArea(
              child: Scaffold(
                body: Container(
                  margin: UIHelper.kSidePadding,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AuthAppBar(
                          subtitle:
                              "Please enter code sent to Johndoe@gmail.com",
                          title: verificationType ==
                                  VerificationType.ForgotPassword
                              ? "Enter Verification Code"
                              : "Verify Email",
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
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        model.isBusy
                            ? CircularProgressIndicator()
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
          inactiveFillColor: Colors.grey.shade100,
          inactiveColor: Colors.transparent,
          activeColor: Colors.grey.shade100,
          // selectedColor: ,
          selectedFillColor: Colors.white,
          shape: PinCodeFieldShape.box,
          fieldHeight: getProportionateScreenHeight(49),
          fieldWidth: getProportionateScreenWidth(51),
          activeFillColor: Colors.grey.shade100,
        ),
        animationDuration: Duration(milliseconds: 300),
        // backgroundColor: Colors.blue.shade50,
        enableActiveFill: true,
        // errorAnimationController: model.errorController,
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
