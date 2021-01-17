import 'package:flutter/material.dart';
import 'package:jals/ui/authentication/widgets/auth_appBar.dart';

import 'package:jals/ui/authentication/widgets/custom_textfield.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';

class CreateSignUpPasswordView extends StatefulWidget {
  @override
  _CreateSignUpPasswordViewState createState() =>
      _CreateSignUpPasswordViewState();
}

class _CreateSignUpPasswordViewState extends State<CreateSignUpPasswordView> {
  bool _isObscure = false;
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

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
                subtitle: "Jesus A Lifestyle",
                title: "Create Password",
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
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
                prefixIcon: Image.asset(
                  "icons/lock.png",
                  color: Color(0xff3C8AF0),
                ),
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
                hintText: "Password(8 Characters)",
              ),
              // Sized box
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              buildButton(context),
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildButton(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: getProportionatefontSize(54),
      width: getProportionateScreenWidth(335),
      decoration: BoxDecoration(
        color: Color(0xff),
      ),
      child: RaisedButton(
        onPressed: () {},
        color: Color(0xffF8F9FA),
        child: Text(
          "Confirm Password",
          style: TextStyle(
            // font-family: Source Sans Pro;
            fontSize: getProportionatefontSize(16),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.02,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
