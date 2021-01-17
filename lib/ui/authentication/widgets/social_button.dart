import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/size_config.dart';

class SocialButton extends StatelessWidget {
  final Function onPressed;
  final Widget icon;
  final String title;
  final Color color;

  const SocialButton(
      {Key key, this.onPressed, this.icon, this.title, this.color});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: color),
        height: getProportionatefontSize(54),
        width: getProportionateScreenWidth(335),
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              width: getProportionateScreenWidth(30),
            ),
            Text(
              title,
              style: GoogleFonts.sourceSansPro(
                fontSize: getProportionatefontSize(15),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.02,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
