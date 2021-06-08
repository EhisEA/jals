import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jals/utils/text.dart';

class Empty extends StatelessWidget {
  final String title;

  const Empty({Key key, this.title: ""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/svgs/empty.svg"),
            Text(
              "$title",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
