import 'package:flutter/material.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';

import 'image.dart';

class ProductTile extends StatelessWidget {
  final String image, title, author, type;

  const ProductTile(
      {Key key,
      @required this.image,
      @required this.title,
      this.author = "",
      @required this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        Container(
          height: getProportionatefontSize(80),
          width: getProportionatefontSize(80),
          child: AspectRatio(
            aspectRatio: 1,
            child: ShowNetworkImage(imageUrl: image),
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
                  text: "$type",
                ),
                SizedBox(
                  height: getProportionatefontSize(5),
                ),
                TextTitle(
                  maxLines: 1,
                  text: "$title+",
                ),
                SizedBox(
                  height: getProportionatefontSize(5),
                ),
                TextCaption(
                  text: "$author",
                ),
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
    );
  }
}
