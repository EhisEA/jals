import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class DayDisplay extends StatefulWidget {
  @override
  _DayDisplayState createState() => _DayDisplayState();
}

class _DayDisplayState extends State<DayDisplay> {
  bool day = false;

  @override
  initState() {
    super.initState();
    Timer.periodic(Duration(minutes: 5), (timer) {
      greeting();
    });
  }

  String greeting() {
    setState(() {
      var hour = DateTime.now().hour;
      if (hour < 7) {
        day = false;
        return 'Morning';
      }
      if (hour < 19) {
        day = true;
        return 'Afternoon';
      }
      day = false;
      return 'Evening';
    });
  }

  @override
  Widget build(BuildContext context) {
    greeting();
    return AspectRatio(
      aspectRatio: 375 / 241,
      child: AnimatedContainer(
          duration: Duration(seconds: 5),
          // height: 100,
          // width: 100,
          // alignment: Alignment.centerLeft,
          color: day ? Color(0xffF4C000) : Color(0xff1F2230),
          child: AnimatedSwitcher(
            duration: Duration(seconds: 3),
            child: day
                ? SvgPicture.asset(
                    "assets/svgs/d1.svg",
                    fit: BoxFit.cover,
                    key: Key("1"),
                  )
                : SvgPicture.asset(
                    "assets/svgs/n1.svg",
                    fit: BoxFit.cover,
                    key: Key("2"),
                  ),
          )),
    );
  }
}
