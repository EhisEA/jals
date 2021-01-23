import 'package:flutter/material.dart';

import 'package:jals/ui/authentication/components/auth_appBar.dart';
import 'package:jals/ui/authentication/view_models/login_view_model.dart';
import 'package:jals/utils/ui_helper.dart';

import 'package:jals/widgets/button.dart';
import 'package:jals/ui/authentication/components/social_button.dart';
import 'package:stacked/stacked.dart';

import '../../utils/jals_icons_icons.dart';
import '../../utils/size_config.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<LoginViewModel>.nonReactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, _) {
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
                        icon: JalsIcons.envelope,
                        onPressed: model.toEmailLogin,
                        title: "Log in with your Email",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SocialButton(
                        color: Color(0xff3F51B5),
                        icon: JalsIcons.facebook,
                        onPressed: model.facebookSignIn,
                        title: "Log in with Facebook",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SocialButton(
                        color: Color(0xff1F2230),
                        icon: JalsIcons.google,
                        onPressed: model.googleSignIn,
                        title: "Log in with Google",
                      ),
                      SizedBox(height: SizeConfig.screenHeight / 9.1),
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
                          DefaultButton(
                            color: Color(0xff3C8AF0),
                            onPressed: model.toSignUp,
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
        });
  }
}
