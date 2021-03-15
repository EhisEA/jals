import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/article_tile.dart';

class LibraryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 375 / 261,
              child: Container(
                // height: 100,
                // width: 100,
                alignment: Alignment.centerLeft,
                color: Color(0xff1F2230),
                child: Stack(
                  children: [
                    SvgPicture.asset("assets/svgs/night1.svg"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextHeader(
                text: "Browse Categories",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildCategory(
                    color: kPrimaryColor,
                    title: "Video",
                    icon: Icons.videocam,
                    routeName: VideoLibraryRoute),
                buildCategory(
                  color: Color(0xff6FCF97),
                  title: "Audio",
                  icon: CupertinoIcons.double_music_note,
                  routeName: ArticleLibraryViewRoute,
                ),
                buildCategory(
                  color: Color(0xff4E3FCE),
                  title: "Articles",
                  icon: CupertinoIcons.book,
                  routeName: ArticleLibraryViewRoute,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextHeader(
                text: "Suggested For You",
              ),
            ),
            ...List.generate(
              11,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: ProductTile(
                  type: "AUDIO",
                  image:
                      "https://cdn.mos.cms.futurecdn.net/yL3oYd7H2FHDDXRXwjmbMf.jpg",
                  title: "Almighty God",
                  author: "Play Time 3 mins",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildCategory({
    @required String title,
    @required Color color,
    @required IconData icon,
    @required String routeName,
  }) {
    return InkWell(
      onTap: () {
        locator<NavigationService>().navigateTo(routeName);
      },
      child: Container(
        height: getProportionatefontSize(100),
        width: getProportionatefontSize(100),
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: getProportionatefontSize(40),
              color: Colors.white,
            ),
            SizedBox(height: 5),
            Text(
              "$title",
              style: TextStyle(
                color: Colors.white,
                fontSize: getProportionatefontSize(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
