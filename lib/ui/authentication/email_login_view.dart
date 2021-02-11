import 'package:flutter/material.dart';
import 'package:jals/constants/regex.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/jals_icons_icons.dart';

import 'package:jals/ui/authentication/components/auth_appBar.dart';
import 'package:jals/ui/authentication/components/auth_textfield.dart';
import 'package:jals/ui/authentication/view_models/email_login_view_model.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/button.dart';
import 'package:stacked/stacked.dart';

import '../../utils/size_config.dart';

class EmailLoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<EmailLoginViewModel>.nonReactive(
        viewModelBuilder: () => EmailLoginViewModel(),
        builder: (context, model, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: UIHelper.kSidePadding,
              child: SingleChildScrollView(
                child: Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      AuthAppBar(
                        subtitle: "Jesus A Lifestyle",
                        title: "Login into JALS",
                      ),
                      // !email textfield
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
                        height: getProportionateScreenHeight(20),
                      ),
                      // ! password textfield
                      AuthTextField(
                        fieldColor: Colors.grey[200],
                        title: "Password",
                        isPassword: true,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: JalsIcons.password,
                        controller: model.passwordController,
                        hintText: "******",
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      buildRow(context, model),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      // button
                      model.state == ViewState.Busy
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : DefaultButton(
                              color: Color(0xff3C8AF0),
                              onPressed: model.login,
                              title: "Log in",
                            ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      buildRichText(model),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildRichText(EmailLoginViewModel model) {
    return InkWell(
      onTap: model.toSignUp,
      child: Text.rich(
        TextSpan(
          text: "I don't have an account? ",
          style: TextStyle(
            fontSize: getProportionatefontSize(14),
            fontStyle: FontStyle.normal,
            color: Color(0xffA1A2A2),
            fontWeight: FontWeight.w600,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "Sign me up",
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

  Widget buildRow(BuildContext context, EmailLoginViewModel model) {
    return Row(
      children: [
        Spacer(),
        InkWell(
          onTap: model.toForgotPassword,
          child: Text(
            "Forgot Password",
            style: TextStyle(
              fontSize: getProportionatefontSize(12),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: Color(0xff1F2230).withOpacity(0.64),
            ),
          ),
        )
      ],
    );
  }
}
