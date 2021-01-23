import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';

class StoreCard extends StatelessWidget {
  final String date, title, productType, prcie, image;

  const StoreCard(
      {Key key,
      this.date,
      this.title,
      this.productType,
      this.prcie,
      this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      child: Container(
        margin: UIHelper.kSidePadding,
        width: SizeConfig.screenWidth,
        height: getProportionatefontSize(71),
        child: Row(
          children: [
            Container(
              height: getProportionatefontSize(69),
              width: getProportionatefontSize(69),
              child: Image.asset(
                "icons/tree.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 2),
                Text(
                  "23 october, 2020",
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getProportionatefontSize(12),
                    fontWeight: FontWeight.w400,
                    color: Color(0xff1F2230).withOpacity(0.55),
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Text(
                  "Almighty God",
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getProportionatefontSize(16),
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Audio",
                      style: GoogleFonts.sourceSansPro(
                        fontSize: getProportionatefontSize(12),
                        fontWeight: FontWeight.w400,
                        color: Color(0xff1F2230).withOpacity(0.55),
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    SizedBox(width: 2),
                    Text(
                      ". 20 credits",
                      style: GoogleFonts.sourceSansPro(
                        fontSize: getProportionatefontSize(12),
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Spacer(),
            IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: getProportionatefontSize(16),
                ),
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}
