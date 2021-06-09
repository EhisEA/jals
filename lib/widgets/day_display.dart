import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/view_models/day_display_view_model.dart';
import 'package:stacked/stacked.dart';

class DayDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DayDisplayViewModel>.reactive(
        viewModelBuilder: () => DayDisplayViewModel(),
        onModelReady: (model) => model.startTimer(),
        builder: (context, model, _) {
          return AspectRatio(
            aspectRatio: 375 / 241,
            child: AnimatedContainer(
                duration: Duration(seconds: 5),
                // height: 100,
                // width: 100,
                // alignment: Alignment.centerLeft,
                color: model.day ? Color(0xffF4C000) : Color(0xff1F2230),
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(seconds: 3),
                      child: model.day
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
                                    "Good ${model.greetingText}, ${model.userFullName.split(" ")[0]} !",
                                color: Colors.white,
                              ),
                              SizedBox(height: 20),
                              TextCaption2(
                                text: model.isEvening
                                    ? "End your day with the word"
                                    : "Meditate on the word through out your day",
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ],
                          ),
                        )),
                  ],
                )),
          );
        });
  }
}
