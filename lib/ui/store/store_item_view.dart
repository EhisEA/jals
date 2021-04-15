import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jals/models/content_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/jals_icons_icons.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/back_icon.dart';
import 'package:jals/widgets/image.dart';

class StoreItemView extends StatelessWidget {
  final ContentModel content;

  const StoreItemView({Key key, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: Container(
                color: Colors.red,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: ShowNetworkImage(imageUrl: content.coverImage)),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: Center(
                            child: BackIcon(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCaption2(
                    text: content.author,
                    fontSize: 18,
                    color: Color(0xff222431).withOpacity(0.70),
                  ),
                  SizedBox(height: 10),
                  TextHeader(
                    text: content.title,
                  ),
                  SizedBox(height: 10),
                  TextCaption(
                    text: DateFormat("dd MMMM yyyy").format(content.createdAt),
                  ),
                  SizedBox(height: getProportionateAdjustedfontSize(10)),

                  //===========================
                  //===========================Video Card
                  //===========================

                  if (content.postType == ContentType.Video ||
                      content.sermonId != null)
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(getProportionatefontSize(12)),
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            padding: EdgeInsets.all(10),
                            color: kGreen.withOpacity(0.1),
                            child: Center(
                                child: Icon(JalsIcons.video, color: kGreen)),
                          ),
                          title: TextHeader3(
                            text: "Video Stream",
                            fontSize: getProportionateAdjustedfontSize(18),
                            fontWeight: FontWeight.w600,
                          ),
                          // subtitle: Text("23:22 min"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/svgs/coin.svg",
                                width: getProportionatefontSize(20),
                              ),
                              SizedBox(width: 3),
                              TextArticle(
                                text: content.price <= 0
                                    ? "Free"
                                    : content.price.toString(),
                                color: Colors.yellow.shade800,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: getProportionateAdjustedfontSize(19)),

                  //===========================
                  //===========================Audio Card
                  //===========================
                  if (content.postType == ContentType.Audio ||
                      content.sermonId != null)
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(getProportionatefontSize(12)),
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            padding: EdgeInsets.all(10),
                            color: kGreen.withOpacity(0.1),
                            child: Center(
                                child:
                                    Icon(JalsIcons.music_note, color: kGreen)),
                          ),
                          title: TextHeader3(
                            text: "Audio Stream",
                            fontSize: getProportionateAdjustedfontSize(18),
                            fontWeight: FontWeight.w600,
                          ),
                          // subtitle: Text("1:23:22 min"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/svgs/coin.svg",
                                width: getProportionatefontSize(20),
                              ),
                              SizedBox(width: 3),
                              TextArticle(
                                text: content.price <= 0
                                    ? "Free"
                                    : content.price.toString(),
                                color: Colors.yellow.shade800,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            buildButton(),
          ],
        ),
      ),
    );
  }

  buildButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RaisedButton(
        onPressed: () {},
        color: kPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Spacer(
                flex: 9,
              ),
              TextHeader3(
                text: content.price <= 0 ? "Buy Now For" : "Buy Now at",
                color: Colors.white,
              ),
              Spacer(
                flex: 1,
              ),
              SizedBox(width: 10),
              SvgPicture.asset(
                "assets/svgs/coin.svg",
                width: getProportionatefontSize(20),
              ),
              SizedBox(width: 3),
              TextHeader3(
                text: content.price <= 0 ? "Free" : content.price.toString(),
                color: Colors.yellow.shade800,
              ),
              Spacer(
                flex: 9,
              ),
              // SvgPicture.asset(
              //   "assets/svgs/coin.svg",
              //   width: 20,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
