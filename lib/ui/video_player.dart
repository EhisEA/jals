import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/comments_widget.dart';

class VideoPlayer extends StatefulWidget {
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Colors.black),
        title: TextHeader(
          text: "Watch Video",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.33,
              child: Container(
                color: Colors.black,
                child: Stack(
                  children: [
                    Image.asset("assets/images/image1.png"),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              // width: MediaQuery.of(context).size.width / 1.6,
              child: TextHeader3(
                text: "Rainfall (Ft. Tiana Major)",
                center: true,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextCaption2(
                text: "By Jane Doe",
                center: true,
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildIcon(Icons.favorite_border_outlined, "Listen Later"),
                buildIcon(CupertinoIcons.square_arrow_down, "Download"),
                buildIcon(CupertinoIcons.bubble_left, "Comment"),
                buildIcon(Icons.more_vert, "more"),
              ],
            ),
            SizedBox(height: 25),
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
