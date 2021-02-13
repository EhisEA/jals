import 'package:flutter/material.dart';
import 'package:jals/constants/regex.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/jals_icons_icons.dart';

import 'package:jals/ui/authentication/components/auth_appBar.dart';
import 'package:jals/ui/authentication/components/auth_textfield.dart';
import 'package:jals/ui/authentication/view_models/forgot_password_view_model.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/button.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
        viewModelBuilder: () => ForgotPasswordViewModel(),
        builder: (context, model, _) {
          return SafeArea(
            child: Scaffold(
              body: Container(
                margin: UIHelper.kSidePadding,
                child: SingleChildScrollView(
                  child: Form(
                    key: model.formKey,
                    child: Column(
                      children: [
                        AuthAppBar(
                          subtitle: "Let us help you reset your password",
                          title: "Forgot your Password?",
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        AuthTextField(
                          fieldColor: Colors.transparent,
                          controller: model.emailController,
                          hintText: "Johndoe@gmail.com",
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: JalsIcons.envelope,
                          title: "Email",
                          validator: (String value) {
                            if (!emmailRegExp.hasMatch(value)) {
                              return "Invaild Email";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(30),
                        ),
                        model.state == ViewState.Busy
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : DefaultButton(
                                color: Color(0xff3C8AF0),
                                onPressed: model.verifyEmail,
                                title: "Continue",
                              ),
                        SizedBox(
                          height: getProportionateScreenHeight(30),
                        ),
                        buildRichText(context, model),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildRichText(context, ForgotPasswordViewModel model) {
    return InkWell(
      onTap: model.toLogin,
      child: Text.rich(
        TextSpan(
          text: "Remembered your password?",
          style: TextStyle(
            fontSize: getProportionatefontSize(14),
            fontStyle: FontStyle.normal,
            color: Color(0xffA1A2A2),
            fontWeight: FontWeight.w700,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "Log in",
              style: TextStyle(
                fontSize: getProportionatefontSize(14),
                fontStyle: FontStyle.normal,
                color: Color(0xff01CC97),
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
