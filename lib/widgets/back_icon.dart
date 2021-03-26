import 'package:flutter/material.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/locator.dart';

class BackIcon extends StatelessWidget {
  final Color color;

  const BackIcon({Key key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        locator<NavigationService>().goBack();
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: color??Colors.black,
      ),
    );
  }
}
