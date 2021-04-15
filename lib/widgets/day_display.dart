import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class DayDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / 261,
      child: Container(
        // height: 100,
        // width: 100,
        alignment: Alignment.centerLeft,
        color: Color(0xff1F2230),
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/svgs/night1.svg",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
