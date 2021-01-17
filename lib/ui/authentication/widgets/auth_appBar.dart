import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jals/utils/size_config.dart';

class AuthAppBar extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthAppBar({Key key, this.title, this.subtitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight / 11,
        ),
        Image.asset(
          "icons/app_logo.png",
          height: getProportionatefontSize(110),
        ),
        SizedBox(
          height: getProportionateScreenHeight(3),
        ),
        Text(
          title,
          style: GoogleFonts.sourceSansPro(
            fontSize: getProportionatefontSize(22),
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            color: Color(0xff373737),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        Text(
          subtitle,
          style: GoogleFonts.sourceSansPro(
            fontSize: getProportionatefontSize(14),
            color: Color(0xffA1A2A2),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
      ],
    );
  }
}
