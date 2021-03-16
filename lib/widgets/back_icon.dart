import 'package:flutter/material.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/locator.dart';

class BackIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        locator<NavigationService>().goBack();
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
    );
  }
}
