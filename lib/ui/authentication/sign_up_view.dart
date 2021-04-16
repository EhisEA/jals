import 'package:flutter/material.dart';
import 'package:jals/constants/regex.dart';
import 'package:jals/utils/jals_icons_icons.dart';
import 'package:jals/ui/authentication/components/auth_appBar.dart';
import 'package:jals/ui/authentication/components/auth_textfield.dart';
import 'package:jals/ui/authentication/components/social_button.dart';
import 'package:jals/ui/authentication/view_models/sign_up_view_model.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/button.dart';
import 'package:jals/widgets/loader_page.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, _) {
          return LoaderPageBlank(
            busy: model.isBusy,
            child: SafeArea(
              child: Scaffold(
                body: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    margin: UIHelper.kSidePadding,
                    child: SingleChildScrollView(
                      child: Form(
                        key: model.formKey,
                        child: Column(
                          children: [
                            AuthAppBar(
                              subtitle: "Enter Email to register your account",
                              title: "Sign up to JALS",
                            ),
                            AuthTextField(
                              fieldColor: Colors.white,
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
                            model.isBusy
                                ? CircularProgressIndicator()
                                : DefaultButton(
                                    color: Color(0xff3C8AF0),
                                    onPressed: model.verifyEmail,
                                    title: "Continue",
                                  ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            Text(
                              "or Sign up with",
                              style: TextStyle(
                                fontSize: getProportionatefontSize(12),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff1F2230).withOpacity(0.66),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            SocialButton(
                              color: Color(0xff3F51B5),
                              icon: JalsIcons.facebook,
                              onPressed: model.facebookSignIn,
                              title: "Sign up with Facebook",
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            SocialButton(
                              color: Color(0xff1F2230),
                              icon: JalsIcons.google,
                              onPressed: model.googleSignIn,
                              title: "Sign up with Google",
                            ),
                            SizedBox(height: getProportionateScreenHeight(40)),
                            buildRichText(context, model),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildRichText(context, SignUpViewModel model) {
    return InkWell(
      onTap: model.toLogin,
      child: Text.rich(
        TextSpan(
          text: "I have an account? ",
          style: TextStyle(
            fontSize: getProportionatefontSize(14),
            fontStyle: FontStyle.normal,
            color: Color(0xffA1A2A2),
            fontWeight: FontWeight.w600,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "log me In ",
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
