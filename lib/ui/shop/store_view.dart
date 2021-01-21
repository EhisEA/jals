import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jals/ui/shop/widgets/store_card.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/utils/ui_helper.dart';

class StoreView extends StatefulWidget {
  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  List<String> items = [
    "Newest",
    "Timeline",
    "Purchased",
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all((10)),
              child: builRoundButton(),
            ),
          ],
          title: TextHeader(
            text: "Store",
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: getProportionatefontSize(16),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: getProportionatefontSize(50),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  items.length,
                  (index) => buildRow(index: index),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(margin: UIHelper.kSidePadding, child: buildSecondRow()),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(15, (index) => StoreCard()),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget builRoundButton() {
    return Container(
      padding: EdgeInsets.symmetric(
        // vertical: getProportionatefontSize(5),
        horizontal: getProportionatefontSize(20),
      ),
      decoration: BoxDecoration(
        color: Color(0xffFCF7E4),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "10,000",
            style: GoogleFonts.sourceSansPro(
              fontSize: getProportionatefontSize(12.7),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              color: Color(0xffC16029),
            ),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.add_circle_outline,
            color: Color(0xffC16029),
          )
        ],
      ),
    );
  }

  Widget buildRow({
    int index,
  }) {
    return Container(
      height: getProportionatefontSize(37),
      width: getProportionatefontSize(112),
      decoration: BoxDecoration(
        color: Color(0xff),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() => selectedIndex = index);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: getProportionatefontSize(37),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color:
                    selectedIndex != index ? Colors.white : Color(0xff3C8AF0),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                )),
            child: Text(
              "   ${items[index]}    ",
              style: GoogleFonts.sourceSansPro(
                fontSize: getProportionatefontSize(16),
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: selectedIndex != index ? kTextColor : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSecondRow() {
    return Row(
      children: [buildLeadingText(), Spacer(), buidlTrailingText()],
    );
  }

  Text buildLeadingText() {
    // return Text("");
    if (selectedIndex == 0) {
      return Text(
        "Newest Collection",
        style: GoogleFonts.sourceSansPro(
          fontSize: getProportionatefontSize(20),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          letterSpacing: 0.3,
        ),
      );
    } else if (selectedIndex == 1) {
      return Text(
        "Explore Timelines",
        style: GoogleFonts.sourceSansPro(
          fontSize: getProportionatefontSize(20),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          letterSpacing: 0.3,
        ),
      );
    } else if (selectedIndex == 2) {
      return Text(
        "Trending",
        style: GoogleFonts.sourceSansPro(
          fontSize: getProportionatefontSize(20),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          letterSpacing: 0.3,
        ),
      );
    } else {
      return Text("");
    }
  }

  Widget buidlTrailingText() {
    if (selectedIndex == 0) {
      return Text(
        "",
        style: GoogleFonts.sourceSansPro(
          fontSize: getProportionatefontSize(12),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          color: Color(0xff3C8AF0),
        ),
      );
    } else if (selectedIndex == 1) {
      return Row(
        children: [
          Text(
            "2019-2021",
            style: GoogleFonts.sourceSansPro(
              fontSize: getProportionatefontSize(12),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              color: Color(0xff3C8AF0),
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            size: getProportionatefontSize(8),
            color: Colors.blue,
          )
        ],
      );
    } else if (selectedIndex == 2) {
      return Row(
        children: [
          Text(
            "All",
            style: GoogleFonts.sourceSansPro(
              fontSize: getProportionatefontSize(12),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              color: Color(0xff3C8AF0),
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            size: getProportionatefontSize(8),
            color: Colors.blue,
          )
        ],
      );
    } else {
      return Text("");
    }
  }
}
