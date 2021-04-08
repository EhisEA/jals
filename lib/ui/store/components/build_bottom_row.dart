import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';

class BuildBottomRow extends StatelessWidget {
  final int index;
  const BuildBottomRow({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: UIHelper.kSidePadding,
      child: Row(
        children: [
          Text(
            changeTextTitle(index),
            style: GoogleFonts.sourceSansPro(
              fontSize: getProportionatefontSize(20),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: 0.3,
            ),
          ),
          Spacer(),
          Text(
            changeTrailingText(index),
            style: GoogleFonts.sourceSansPro(
              fontSize: getProportionatefontSize(12),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              color: Color(0xff3C8AF0),
            ),
          ),
        ],
      ),
    );
  }

  String changeTrailingText(int index) {
    switch (index) {
      case 0:
        return "";
      case 1:
        return "2019-2021";
      case 2:
        return "All";

        break;
      default:
        return "";
    }
  }

  String changeTextTitle(int index) {
    switch (index) {
      case 0:
        return "Newest Collection";
      case 1:
        return "Explore Timelines";
      case 2:
        return "Trending";
        break;
      default:
        return "";
    }
  }
}
