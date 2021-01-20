import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/custom_button.dart';
import 'package:jals/ui/authentication/components/social_button.dart';

import '../../utils/size_config.dart';

class WelcomeView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: UIHelper.kSidePadding,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight / 11,
                ),
                Image.asset(
                  "icons/app_logo.png",
                  height: getProportionatefontSize(110),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text("Welcome to JALS",
                    style: GoogleFonts.sourceSansPro(
                      color: Color(0xff373737),
                      fontSize: getProportionatefontSize(22),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    )),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                SocialButton(
                  color: Color(0xff1F2230),
                  icon: Image.asset("icons/email.png"),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.signUpView);
                  },
                  title: "Sign up with your Email",
                ),
                SizedBox(
                  height: 25,
                ),
                SocialButton(
                  color: Color(0xff1F2230),
                  icon: Image.asset("icons/apple.png"),
                  onPressed: () {
                    // Navigator.pushNamed(context, RoutePaths.verificationView);
                  },
                  title: "Sign up with Apple",
                ),
                // Spacer(),
                SizedBox(height: SizeConfig.screenHeight / 4),
                bottomWidgets(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomWidgets(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(
            color: Color(0xff373737),
            fontSize: getProportionatefontSize(16),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(24),
        ),
        CustomButton(
          color: Color(0xff3C8AF0),
          onPressed: () {
            Navigator.pushNamed(context, RoutePaths.loginOptionsView);
          },
          title: "Log in",
        ),
        SizedBox(
          height: getProportionateScreenHeight(50),
        ),
      ],
    );
  }
}
