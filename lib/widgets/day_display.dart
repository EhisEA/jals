import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/text.dart';

class DayDisplay extends StatefulWidget {
  @override
  _DayDisplayState createState() => _DayDisplayState();
}

class _DayDisplayState extends State<DayDisplay> {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  bool day = false;
  String greetingText;

  @override
  initState() {
    super.initState();
    greeting();
    Timer.periodic(Duration(minutes: 1), (timer) {
      greeting();
    });
  }

  void greeting() {
    setState(() {
      var hour = DateTime.now().hour;
      if (hour < 6) {
        day = false;
        greetingText = 'Morning';
      } else if (hour < 12) {
        day = true;
        greetingText = 'Morning';
      } else if (hour < 16) {
        day = true;
        greetingText = 'Afternoon';
      } else if (hour < 19) {
        day = true;
        greetingText = 'Evening';
      }
      day = false;
      greetingText = 'Evening';
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / 241,
      child: AnimatedContainer(
          duration: Duration(seconds: 5),
          // height: 100,
          // width: 100,
          // alignment: Alignment.centerLeft,
          color: day ? Color(0xffF4C000) : Color(0xff1F2230),
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: Duration(seconds: 3),
                child: day
                    ? AspectRatio(
                        key: Key("101"),
                        aspectRatio: 375 / 241,
                        child: SvgPicture.asset(
                          "assets/svgs/d1.svg",
                          fit: BoxFit.cover,
                          key: Key("1"),
                        ),
                      )
                    : AspectRatio(
                        key: Key("202"),
                        aspectRatio: 375 / 241,
                        child: SvgPicture.asset(
                          "assets/svgs/n1.svg",
                          fit: BoxFit.cover,
                          key: Key("2"),
                        ),
                      ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextHeader2(
                          text:
                              "Good $greetingText, ${_authenticationService.currentUser.fullName.split(" ")[0]} !",
                          color: Colors.white,
                        ),
                        SizedBox(height: 20),
                        TextCaption2(
                          text: day
                              ? "Meditate on the word through out your day"
                              : "End your day with the word",
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
