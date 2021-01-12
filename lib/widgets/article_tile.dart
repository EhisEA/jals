import 'package:flutter/material.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/image.dart';

class ArticleTile extends StatelessWidget {
  final String image, title, author;

  const ArticleTile(
      {Key key, @required this.image, @required this.title, this.author = ""})
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
        Expanded(
          child: ListTile(
            title: TextTitle(
              text: "$title",
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: TextCaption(
                text: "$author",
              ),
            ),
          ),
        )
      ],
    );
  }
}
