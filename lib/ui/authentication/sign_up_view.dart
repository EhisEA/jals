import 'package:flutter/material.dart';
import 'package:jals/route_paths.dart';

import 'package:jals/ui/authentication/components/auth_appBar.dart';
import 'package:jals/ui/authentication/components/custom_textfield.dart';
import 'package:jals/ui/authentication/components/social_button.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/custom_button.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
                  subtitle: "Enter Email to register your account",
                  title: "Sign up to JALS",
                ),
                CustomTextField(
                  fieldColor: Colors.white,
                  controller: emailController,
                  hintText: "Johndoe@gmail.com",
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {},
                  prefixIcon: Image.asset(
                    "icons/email.png",
                    color: Colors.black,
                  ),
                  suffixIcon: Container(height: 10, width: 10),
                  title: "Email",
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                CustomButton(
                  color: Color(0xff3C8AF0),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.verificationView);
                  },
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
                  icon: Image.asset("icons/facebook.png"),
                  onPressed: () {},
                  title: "Log in with Facebook",
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                SocialButton(
                  color: Color(0xff1F2230),
                  icon: Image.asset("icons/google.png"),
                  onPressed: () {},
                  title: "Log in with Google",
                ),
                SizedBox(height: getProportionateScreenHeight(40)),
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
