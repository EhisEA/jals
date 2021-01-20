import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';

class PaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBox(),
              SizedBox(
                height: getProportionatefontSize(30),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "CAC Sermon",
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getProportionatefontSize(16),
                    color: Color(0xff222431).withOpacity(.54),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: getProportionatefontSize(10),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Medititating with the Spirit",
                  style: GoogleFonts.sourceSansPro(
                      fontSize: getProportionatefontSize(22),
                      color: Color(0xff1F2230),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.1),
                ),
              ),
              SizedBox(
                height: getProportionatefontSize(10),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "21 December 2020",
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getProportionatefontSize(12),
                    color: Color(0xff222431).withOpacity(.54),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              // !tile
              SizedBox(height: 20),

              ItemDescriptionCard(
                imagePath: "icons/video.png",
                price: "12.0",
                subtitle: "23:22 mins",
                title: "Video Stream",
              ),
              SizedBox(height: 10),
              ItemDescriptionCard(
                imagePath: "icons/music.png",
                price: "12",
                subtitle: "23:22 mins",
                title: "Video Stream",
              ),

              SizedBox(height: 20),
              Container(
                height: getProportionatefontSize(56),
                width: SizeConfig.screenWidth,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    buildButton(context),
                    Spacer(),
                    Card(
                      child: Container(
                        height: getProportionatefontSize(54),
                        width: getProportionatefontSize(48),
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.blue,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      alignment: Alignment.center,
      height: getProportionatefontSize(54),
      width: getProportionateScreenWidth(224),
      decoration: BoxDecoration(
        color: Color(0xff3C8AF0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 20),
          Text(
            "Buy Now at \$24",
            style: GoogleFonts.sourceSansPro(
              fontSize: getProportionatefontSize(16),
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontStyle: FontStyle.normal,
            ),
          ),
          SizedBox(width: 3),
          Image.asset("icons/card_payment.png"),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}

class ItemDescriptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String price;
  const ItemDescriptionCard({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.imagePath,
    @required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20),
      elevation: 1.0,
      child: Container(
        margin: UIHelper.kSidePadding,
        decoration: BoxDecoration(),
        height: getProportionatefontSize(75),
        width: SizeConfig.screenWidth,
        child: ListTile(
          title: Text(
            title,
            style: GoogleFonts.sourceSansPro(
              fontSize: getProportionatefontSize(16),
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: GoogleFonts.sourceSansPro(
              fontSize: getProportionatefontSize(12),
              color: Color(0xff222431),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: Container(
            height: getProportionatefontSize(43),
            width: getProportionatefontSize(40),
            child: Center(
              child: Image.asset(imagePath),
            ),
            decoration: BoxDecoration(
              color: Color(0xffEEFFFA),
            ),
          ),
          trailing: Text(
            "\$$price",
            style: GoogleFonts.sourceCodePro(
              fontSize: getProportionatefontSize(18),
              color: Color(0xff3C8AF0),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
          ),
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
      height: getProportionatefontSize(271),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/girl.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
