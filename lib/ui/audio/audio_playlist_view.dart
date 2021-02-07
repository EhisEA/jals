import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/article_tile.dart';

class AudioPlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // leadingWidth: 45,

            leading: Icon(Icons.arrow_back_ios),
            collapsedHeight: getProportionatefontSize(90),
            expandedHeight: getProportionatefontSize(203),
            // snap: true,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextHeader(
                    text: "Motivation",
                    color: Colors.white,
                  ),
                  TextCaptionWhite(
                    fontWeight: FontWeight.w400,
                    text: '12 songs',
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            backgroundColor: kPrimaryColor,
            pinned: true,
            // title: Center(child: Text('Motivation')),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: AudioTile(
                  image:
                      "https://media.wired.com/photos/598e35fb99d76447c4eb1f28/master/pass/phonepicutres-TA.jpg",
                  title: "Drown",
                  author: "Lecrae - Restoration",
                ),
              );
            }, childCount: 20),
          ),
        ],
      ),
    );
  }
}
