import 'package:flutter/material.dart';

import '../utils/size_config.dart';

class DefaultButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color color;

  const DefaultButton({Key key, this.onPressed, this.title, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: getProportionatefontSize(height < 1000 ? 54 : 38),
      width: getProportionateScreenWidth(335),
      decoration: BoxDecoration(
        color: color,
      ),
      child: RaisedButton(
        onPressed: onPressed,
        color: color,
        child: Text(
          title,
          style: TextStyle(
            // font-family: Source Sans Pro;
            fontSize: getProportionatefontSize(16),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.02,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
