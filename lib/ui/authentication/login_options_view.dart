import 'package:flutter/material.dart';

import 'package:jals/route_paths.dart';
import 'package:jals/ui/authentication/widgets/auth_appBar.dart';
import 'package:jals/utils/ui_helper.dart';

import 'package:jals/widgets/custom_button.dart';
import 'package:jals/ui/authentication/widgets/social_button.dart';

import '../../utils/size_config.dart';

class LoginOptionsView extends StatelessWidget {
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
                  subtitle: "",
                  title: "How would you like to Log in?",
                ),
                SocialButton(
                  color: Color(0xff1F2230),
                  icon: Image.asset(
                    "icons/email.png",
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.loginView);
                  },
                  title: "Log in with your Email",
                ),
                SizedBox(
                  height: 20,
                ),
                SocialButton(
                  color: Color(0xff3F51B5),
                  icon: Image.asset("icons/facebook.png"),
                  onPressed: () {},
                  title: "Log in with Facebook",
                ),
                SizedBox(
                  height: 20,
                ),
                SocialButton(
                  color: Color(0xff1F2230),
                  icon: Image.asset("icons/apple.png"),
                  onPressed: () {},
                  title: "Log in with Apple",
                ),
                SizedBox(height: SizeConfig.screenHeight / 5.1),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      "New to JALS?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    CustomButton(
                      color: Color(0xff3C8AF0),
                      onPressed: () {
                        Navigator.pushNamed(context, RoutePaths.welcomeView);
                      },
                      title: "Create an Account",
                    ),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
