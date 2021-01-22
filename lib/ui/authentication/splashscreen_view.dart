import 'package:flutter/material.dart';
import 'package:jals/ui/authentication/view_models/splash_screen_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../utils/size_config.dart';

class SplashScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SplashScreenViewModel>.nonReactive(
        viewModelBuilder: () => SplashScreenViewModel(),
        onModelReady: (model) => model.checkLoginStatus(),
        builder: (context, model, _) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Image.asset("icons/app_logo.png"),
              ),
            ),
          );
        });
  }
}
