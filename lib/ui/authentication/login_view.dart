import 'package:flutter/material.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/ui/authentication/widgets/auth_appBar.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/custom_button.dart';
import 'package:jals/ui/authentication/widgets/custom_textfield.dart';

import '../../utils/size_config.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // ignore: unused_field
  bool _isObscure = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: UIHelper.kSidePadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   height: getProportionateScreenHeight(20),
                // )
                AuthAppBar(
                  subtitle: "Jesus A Lifestyle",
                  title: "Login into JALS",
                ),
                // !email textfield
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
                  height: getProportionateScreenHeight(20),
                ),
                // ! password textfield
                CustomTextField(
                  fieldColor: Colors.grey[200],
                  title: "Password",
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.multiline,
                  onSaved: (String value) {},
                  obscure: _isObscure,
                  prefixIcon: Image.asset("icons/pin.png"),
                  suffixIcon: IconButton(
                      icon: _isObscure
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }),
                  controller: passwordController,
                  hintText: "******",
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                buildRow(context),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                // button
                CustomButton(
                  color: Color(0xff3C8AF0),
                  onPressed: () {},
                  title: "Log in",
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                buildRichText(),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRichText() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.signUpView);
      },
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

  Widget buildRow(context) {
    return Row(
      children: [
        Spacer(),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RoutePaths.forgotPasswordView);
          },
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
