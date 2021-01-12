import 'package:flutter/material.dart';
import 'package:jals/utils/size_config.dart';

class TextCaption extends StatelessWidget {
  final String text;

  const TextCaption({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Text(
      "$text",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Color(0xff1F2230).withOpacity(0.8),
        fontSize: getProportionatefontSize(12),
        letterSpacing: 0.1,
      ),
    );
  }
}

class TextHeader extends StatelessWidget {
  final String text;

  const TextHeader({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Text(
      "$text",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: getProportionatefontSize(20.2),
        letterSpacing: 0.1,
      ),
    );
  }
}

class TextTitle extends StatelessWidget {
  final String text;

  const TextTitle({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Text(
      "$text",
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: getProportionatefontSize(16),
        letterSpacing: 0.3,
      ),
    );
  }
}

class TextArticle extends StatelessWidget {
  final String text;

  const TextArticle({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Text(
      "$text",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Color(0xff1F2230),
        fontSize: getProportionatefontSize(16),
        height: 1.5,
      ),
    );
  }
}
