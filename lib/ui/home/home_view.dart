import 'package:flutter/material.dart';
import 'package:jals/ui/home/components/home_list.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:stacked/stacked.dart';

import 'components/view_models/daily_read_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 375 / 261,
              child: Container(
                color: Color(0xff1F2230),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              color: kPrimaryColor,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextCaptionWhite(
                        text: "DAILY READ",
                        fontSize: 14,
                      ),
                      Spacer(),
                      TextCaptionWhite(
                        text: "John 3:16",
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextDailyRead(
                      text: "For God so loved the world, "
                          "as to give his only begotten Son; that"
                          " whosoever believeth in him,",
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => showDailyRead(context),
              child: buildReadMore(),
            ),
            HomeContentDisplay(
              svgimage: "assets/svgs/hearts.svg",
              listTitle: "For You",
            ),
            HomeContentDisplay(
              svgimage: "assets/svgs/badge_new.svg",
              listTitle: "Explore",
            )
          ],
        ),
      ),
    );
  }

  showDailyRead(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ViewModelBuilder<DailyReadViewModel>.reactive(
          viewModelBuilder: () => locator<DailyReadViewModel>(),
          disposeViewModel: false,
          builder: (context, model, _) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        model.dailyScripture.location != null
                            ? model.dailyScripture.location
                            : "", // "JOHN CHAPTER 3 VERSES 16-18 NIV",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionatefontSize(14),
                          color: Color(0xff004DE7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: TextDailyRead(
                            color: kTextColor,
                            maxLine: null,
                            text: model.dailyScripture.content != null
                                ? model.dailyScripture.content
                                : ""
                            /*
                              "16 For God so loved the world that he gave his one"
                              " and only Son, that whoever believes in him shall not perish "
                              "but have eternal life. \n 17 For God did not send his Son into"
                              "the world to condemn the world, but to save the world through"
                              " him. \n 18 Whoever believes in him is not condemned, but whoever"
                              " does not believe stands condemned already because they have"
                              " not believed in the name of God’s one and only Son.",
                        
                        */
                            ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: buildDone(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildDone() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionatefontSize(40),
        vertical: getProportionatefontSize(10),
      ),
      decoration: BoxDecoration(
        color: Color(0xffE7E7E7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "i'm done reading",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: getProportionatefontSize(16),
          color: kTextColor,
        ),
      ),
    );
  }

  Widget buildReadMore() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimaryColor),
      ),
      child: Text(
        "Read Full Scripture",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: getProportionatefontSize(16),
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
