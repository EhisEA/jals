import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/comments_widget.dart';

class AudioPlayer extends StatefulWidget {
  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Colors.black),
        title: TextHeader(
          text: "Listen to Audio",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            CircleAvatar(radius: 80),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              // alignment: TextAlignment.,
              // height: 40,
              // width: 200,
              constraints: BoxConstraints(
                minHeight: 20,
                minWidth: 100,
                maxWidth: 200,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kGreen,
              ),
              child: TextCaptionWhite(text: "Feelings"),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width / 1.6,
              child: TextHeader2(
                text: "Lord, We Come to Worship",
                center: true,
              ),
            ),
            SizedBox(height: 15),
            TextCaption2(
              text: "By Jane Doe",
              center: true,
            ),
            SizedBox(height: 15),
            Slider(
              max: 100,
              value: p,
              onChanged: (value) {
                p = value;
                setState(() {});
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  TextCaption2(
                    text: "23:02",
                  ),
                  Spacer(),
                  TextCaption2(
                    text: "23:02",
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fast_rewind,
                  color: Color(0xffD9D9D9),
                ),
                SizedBox(width: 20),
                CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.play_arrow),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.fast_forward,
                  color: Color(0xffD9D9D9),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildIcon(Icons.favorite_border_outlined, "Listen Later"),
                buildIcon(CupertinoIcons.square_arrow_down, "Download"),
                buildIcon(CupertinoIcons.bubble_left, "Comment"),
                buildIcon(Icons.more_vert, "more"),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            CommentsWidget()
          ],
        ),
      ),
    );
  }

  var p = 10.0;

  Widget buildIcon(icon, text) {
    return Column(
      children: [
        Icon(
          icon,
          color: Color(0xff979797),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: getProportionatefontSize(12),
            fontWeight: FontWeight.w400,
            color: Color(0xff999CAD),
          ),
        )
      ],
    );
  }
}
