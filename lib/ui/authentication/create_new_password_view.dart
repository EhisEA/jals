import 'package:flutter/material.dart';
import 'package:jals/ui/authentication/widgets/auth_appBar.dart';

import 'package:jals/ui/authentication/widgets/custom_textfield.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/custom_button.dart';

class CreateNewPasswordView extends StatefulWidget {
  @override
  _CreateNewPasswordViewState createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
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
              // Sized box
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              CustomButton(
                color: Color(0xff3C8AF0),
                onPressed: () {},
                title: "Save my new password",
              )
            ],
          ),
        ),
      ),
    ));
  }
}
