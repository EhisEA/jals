import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/button.dart';

class PaymentPageWithTokenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopBox(),
              SizedBox(
                height: getProportionatefontSize(30),
              ),
              Text(
                "What are JALS Token?",
                style: GoogleFonts.sourceSansPro(
                  fontSize: getProportionatefontSize(20),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(
                height: getProportionatefontSize(10),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth / 8),
                child: Text(
                  "JALS Token are used to purchase contents such as videos, audios and articles on the app.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getProportionateAdjustedfontSize(16),
                    fontWeight: FontWeight.w400,
                    color: Color(0xff222431).withOpacity(0.68),
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              SizedBox(
                height: getProportionatefontSize(10),
              ),
              Column(
                children: List.generate(3, (index) => TokenPriceTile()),
              ),
              SizedBox(
                height: getProportionatefontSize(10),
              ),
              Container(
                margin: UIHelper.kSidePadding,
                child: DefaultButton(
                  color: Color(0xff3C8AF0),
                  onPressed: () {},
                  title: "Purchase JALS Token",
                ),
              ),
              SizedBox(
                height: getProportionatefontSize(40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TokenPriceTile extends StatelessWidget {
  const TokenPriceTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateAdjustedfontSize(72),
      width: SizeConfig.screenWidth,
      child: ListTile(
        title: Text(
          "50 JALS Token",
          style: GoogleFonts.sourceSansPro(
            fontSize: getProportionatefontSize(16),
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontStyle: FontStyle.normal,
          ),
        ),
        trailing: Container(
          height: getProportionatefontSize(36),
          width: getProportionatefontSize(79),
          child: Center(
            child: Text(
              "\$100",
              style: GoogleFonts.sourceSansPro(
                fontSize: getProportionatefontSize(16),
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          decoration: BoxDecoration(
              color: Color(0xff3C8AF0),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              )),
        ),
        leading: Image.asset(
          "icons/time.png",
          height: getProportionatefontSize(36),
        ),
      ),
    );
  }
}

class TopBox extends StatelessWidget {
  const TopBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: getProportionatefontSize(201),
      decoration: BoxDecoration(
        color: Color(0xffFCF7E4),
      ),
      child: Column(
        children: [
          SizedBox(
            height: getProportionatefontSize(20),
          ),
          Stack(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              // SizedBox(
              //   width: getProportionatefontSize(70),
              // ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Buy JALS Token",
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getProportionateAdjustedfontSize(22),
                    fontWeight: FontWeight.w600,
                    color: Color(0xffC16029),
                  ),
                ),
              )
            ],
          ),
          //
          SizedBox(
            height: getProportionatefontSize(30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "icons/time.png",
                height: getProportionatefontSize(48),
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: getProportionatefontSize(15),
              ),
              Text(
                "200",
                style: GoogleFonts.sourceSansPro(
                  fontSize: getProportionatefontSize(32),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          Spacer(),
          Text(
            "JALS Token Balance",
            style: GoogleFonts.sourceSansPro(
              fontSize: getProportionatefontSize(12),
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: getProportionatefontSize(15),
          ),
        ],
      ),
    );
  }
}
