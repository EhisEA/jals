import 'package:flutter/material.dart';
import '../utils/size_config.dart';

class HeaderText extends StatelessWidget {
  final String title;
  static bool _isCenter = false;

  HeaderText({Key key, @required this.title}) : super(key: key);
  HeaderText.center({Key key, @required this.title}) {
    _isCenter = true;
  }
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: _isCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        fontSize: getProportionateScreenWidth(26),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SubText extends StatelessWidget {
  final String title;
  static bool _isCenter;

  SubText({Key key, @required this.title}) {
    _isCenter = false;
  }
  SubText.center({Key key, @required this.title}) {
    _isCenter = true;
  }
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: _isCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}
