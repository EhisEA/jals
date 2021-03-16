import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/ui/video/view_models/video_player_view_model.dart';
import 'package:jals/utils/jals_icons_icons.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/comments_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';
// import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  final VideoModel videoModel;

  const VideoPlayerView({Key key, @required this.videoModel}) : super(key: key);
  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<VideoPlayerViewViewModel>.reactive(
      onModelReady: (model) =>
          model.initializePlayer(videoUrl: widget.videoModel.dataUrl),
      viewModelBuilder: () => VideoPlayerViewViewModel(),
      builder: (context, model, child) {
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
                        // Image.asset("assets/images/image1.png"),
                        VideoPlayer(
                          model.videoPlayerController,
                        ),

                        // Video
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.fast_rewind,
                                    color: Color(0xffD9D9D9),
                                  ),
                                ),
                                SizedBox(width: 20),
                                CircleAvatar(
                                  radius: 25,
                                  child: IconButton(
                                    onPressed: () {
                                      model.videoPlayerController.value
                                              .isPlaying
                                          ? model.videoPlayerController.pause()
                                          : model.videoPlayerController.play();
                                    },
                                    icon: model.videoPlayerController.value
                                            .isPlaying
                                        ? Icon(Icons.pause)
                                        : Icon(Icons.play_arrow),
                                  ),
                                ),
                                SizedBox(width: 20),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.fast_forward,
                                    color: Color(0xffD9D9D9),
                                  ),
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
                    value = value;
                    setState(() {
                      // model.videoPlayerController
                      //     .seekTo(Duration(seconds: p.toInt()));
                    });
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
                    text: "${widget.videoModel.title}",
                    center: true,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextCaption2(
                    text: "${widget.videoModel.author}",
                    center: true,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("Toogled the bookmark boolean value..");
                        widget.videoModel.is_bookmarked
                            ? model.removeFrombookmarks(widget.videoModel.id)
                            : model.addVideoToBookmark(widget.videoModel.id);
                      },
                      child: buildIcon(
                        JalsIcons.favorite,
                        "Listen Later",
                        color: widget.videoModel.is_bookmarked
                            ? Colors.red
                            : Color(0xff979797),
                      ),
                    ),
                    buildIcon(JalsIcons.download, "Download"),
                    buildIcon(JalsIcons.comment, "Comment"),
                    buildIcon(JalsIcons.comment, "more"),
                  ],
                ),
                SizedBox(height: 25),
                Divider(),
                CommentsWidget()
              ],
            ),
          ),
        );
      },
    );
  }

  var p = 10.0;

  Widget buildIcon(icon, text, {Color color}) {
    return Column(
      children: [
        Icon(
          icon,
          color: color ?? Color(0xff979797),
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
