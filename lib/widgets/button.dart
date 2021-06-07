import 'package:flutter/material.dart';
import 'package:jals/utils/colors_utils.dart';

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

class DefaultButtonBorderedIcon extends StatelessWidget {
  const DefaultButtonBorderedIcon(
      {Key key, this.text, this.press, @required this.icon})
      : super(key: key);
  final String text;
  final Function press;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(62),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: kPrimaryColor,
        )),
        child: FlatButton(
          onPressed: press,
          child: Padding(
            padding: const EdgeInsets.only(left: 7, right: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18, //getProportionateScreenHeight(20),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  icon,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultButtonBordered extends StatelessWidget {
  const DefaultButtonBordered({Key key, this.text, this.press, this.color})
      : super(key: key);
  final String text;
  final Function press;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(62),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: color ?? kPrimaryColor,
        )),
        child: FlatButton(
          onPressed: press,
          child: Padding(
            padding: const EdgeInsets.only(left: 7, right: 7),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18, //getProportionateScreenHeight(20),
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
