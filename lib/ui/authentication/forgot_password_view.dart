import 'package:flutter/material.dart';

import 'package:jals/ui/authentication/components/auth_appBar.dart';
import 'package:jals/ui/authentication/components/custom_textfield.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/custom_button.dart';

import '../../route_paths.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          // height: MediaQuery.of(context).size.width,
          // width: MediaQuery.of(context).size.width,
          margin: UIHelper.kSidePadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AuthAppBar(
                  subtitle: "Let us help you reset your password",
                  title: "Forgot your Password?",
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                CustomTextField(
                  fieldColor: Colors.transparent,
                  controller: emailController,
                  hintText: "Johndoe@gmail.com",
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {},
                  suffixIcon: Container(height: 10, width: 10),
                  prefixIcon: Image.asset(
                    "icons/email.png",
                    color: Color(0xff3C8AF0),
                  ),
                  title: "Email",
                  validator: (String value) => value.isEmpty ? "" : null,
                  obscure: false,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                CustomButton(
                  color: Color(0xff3C8AF0),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RoutePaths.verificationForgotPasswordView);
                  },
                  title: "Continue",
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                buildRichText(context),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRichText(context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.loginView);
      },
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
