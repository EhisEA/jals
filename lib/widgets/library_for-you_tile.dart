import 'package:flutter/material.dart';
import 'package:jals/enums/content_type.dart';
import 'package:jals/models/content_model.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';

import 'image.dart';

class LibraryForYouTile extends StatelessWidget {
  final ContentModel content;

  const LibraryForYouTile({Key key, @required this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        children: [
          Container(
            height: getProportionatefontSize(80),
            width: getProportionatefontSize(80),
            child: AspectRatio(
              aspectRatio: 1,
              child: ShowNetworkImage(imageUrl: content.coverImage),
            ),
          ),
          SizedBox(
            width: getProportionatefontSize(20),
          ),
          Expanded(
            child: Container(
              height: getProportionatefontSize(80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCaption(
                    text: getTypeString(),
                  ),
                  SizedBox(
                    height: getProportionatefontSize(5),
                  ),
                  TextTitle(
                    maxLines: 1,
                    text: content.title,
                  ),
                  SizedBox(
                    height: getProportionatefontSize(5),
                  ),
                  TextCaption(
                    text: content.price <= 0
                        ? "Free"
                        : "${content.price} Credits",
                  ),
                  // TextCaption(
                  //   text: getTypeString(),
                  // ),
                  // Text.rich(
                  //   TextSpan(
                  //     text: getTypeString() + " . ",
                  //     style: TextStyle(
                  //       color: Color(0xff1F2230).withOpacity(0.8),
                  //     ),
                  //     children: [
                  //       TextSpan(
                  //         text: content.price <= 0
                  //             ? "Free"
                  //             : "${content.price} Credits",
                  //         style: TextStyle(
                  //           color: kPrimaryColor,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Center(
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  String getTypeString() {
    switch (content.postType) {
      case ContentType.Audio:
        return "Audio";
      case ContentType.Article:
        return "Article";
      case ContentType.News:
        return "News";
      case ContentType.Video:
        return "Video";
      default:
        return "";
    }
  }
}