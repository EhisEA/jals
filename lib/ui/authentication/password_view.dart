import 'package:flutter/material.dart';
import 'package:jals/utils/jals_icons_icons.dart';
import 'package:jals/ui/authentication/components/auth_appBar.dart';

import 'package:jals/ui/authentication/components/auth_textfield.dart';
import 'package:jals/ui/authentication/view_models/password_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/widgets/button.dart';
import 'package:stacked/stacked.dart';

class PasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<PasswordViewModel>.nonReactive(
        viewModelBuilder: () => PasswordViewModel(),
        builder: (context, model, _) {
          return SafeArea(
              child: Scaffold(
            body: Container(
              // margin: UIHelper.kSidePadding,
              alignment: Alignment.topCenter,
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
                    AuthTextField(
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
                      prefixIcon: JalsIcons.password,
                      controller: model.passwordController,
                      isPassword: true,
                      hintText: "Password(8 Characters)",
                    ),
                    // Sized box
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    DefaultButton(
                      title: "Confirm Password",
                      onPressed: model.confirmPassword,
                      color: kPrimaryColor,
                    )
                  ],
                ),
              ),
            ),
          ));
        });
  }
}
