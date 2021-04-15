import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/enums/small_viewstate.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/ui/video/view_models/video_player_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/jals_icons_icons.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/back_icon.dart';
import 'package:jals/widgets/comment_widget.dart';
import 'package:jals/widgets/extended_text_field.dart';
import 'package:jals/widgets/view_models/comment_widget_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  final VideoModel video;

  const VideoPlayerView({Key key, this.video}) : super(key: key);
  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  CommentWidgetViewModel _commentWidgetViewModel;
  @override
  dispose() {
    super.dispose();
    _commentWidgetViewModel.dispose();
  }

  @override
  void initState() {
    _commentWidgetViewModel = CommentWidgetViewModel(widget.video.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<VideoPlayerViewViewModel>.reactive(
      onModelReady: (model) {
        model.initializeVideo(videoModel: widget.video);
      },
      viewModelBuilder: () => VideoPlayerViewViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: BackIcon(),
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
                        VideoPlayer(
                          model.videoPlayerController,
                        ),
                        model.isBusy
                            ? Center(child: CircularProgressIndicator())
                            : Container(),
                        model.videoPlayerController.value.isBuffering
                            ? Center(child: CircularProgressIndicator())
                            : Container(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // model.videoPlayerController
                                    //     .setPlaybackSpeed(5.0);
                                  },
                                  icon: Icon(
                                    Icons.fast_rewind,
                                    color: Color(0xffD9D9D9),
                                  ),
                                ),
                                SizedBox(width: 20),
                                CircleAvatar(
                                  radius: 25,
                                  child: IconButton(
                                    // move this function to viewmodel
                                    onPressed: model.pauseOrPlay,
                                    icon: model.videoPlayerController.value
                                            .isPlaying
                                        ? Icon(Icons.pause)
                                        : Icon(Icons.play_arrow),
                                  ),
                                ),
                                SizedBox(width: 20),
                                IconButton(
                                  onPressed: () {
                                    // model.videoPlayerController
                                    //     .seekTo(position);
                                  },
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
                  min: 0.0,
                  max: model.totalTime.toDouble() ?? 50.0,
                  value: model.currentTime.toDouble(),
                  onChanged: (value) {
                    model.seek(Duration(seconds: value.toInt()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      TextCaption2(
                        text: model.convertCurrent(),
                      ),
                      Spacer(),
                      TextCaption2(
                        text: model.convertTotal(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // width: MediaQuery.of(context).size.width / 1.6,
                  child: TextHeader3(
                    text: "${widget.video.title}",
                    center: true,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextCaption2(
                    text: "${widget.video.author}",
                    center: true,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        model.video.isBookmarked
                            ? model.removeFromBookmarks(widget.video.id)
                            : model.addToBookmarks(widget.video.id);
                      },
                      child: buildIcon(
                        model.smallViewState == SmallViewState.Occuppied
                            ? Icons.wifi_protected_setup
                            : model.video.isBookmarked
                                ? Icons.favorite
                                : JalsIcons.favorite,
                        "Listen Later",
                        color: model.video.isBookmarked
                            ? kPrimaryColor //Colors.red
                            : null,
                      ),
                    ),
                    buildIcon(JalsIcons.download, "Download"),
                    InkWell(
                      onTap: () {
                        showBottomSheet(context, _commentWidgetViewModel);
                      },
                      child: buildIcon(JalsIcons.comment, "Comment"),
                    ),
                    pop(JalsIcons.more, "more", model.share),
                  ],
                ),
                SizedBox(height: 25),
                Divider(),
                CommentWidget(
                  commentWidgetViewModel: _commentWidgetViewModel,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  showBottomSheet(
      BuildContext context, CommentWidgetViewModel commentWidgetViewModel) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ViewModelBuilder<CommentWidgetViewModel>.reactive(
          viewModelBuilder: () => commentWidgetViewModel,
          disposeViewModel: false,
          builder: (context, model, _) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: model.isSecondaryBusy
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Form(
                        key: model.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Center(child: TextHeader(text: "Comment")),
                            SizedBox(height: 20),
                            TextCaption(text: "Comment"),
                            SizedBox(height: 10),
                            ExtendedTextField(
                              title: "Comment",
                              controller: model.commentController,
                              multiline: true,
                            ),
                            SizedBox(height: 30),
                            InkWell(
                              onTap: model.sendComment,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: kPrimaryColor,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 10,
                                  ),
                                  child: TextCaptionWhite(
                                    text: "Post Comment",
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            );
          }),
    );
  }

  Widget buildIcon(IconData icon, text, {Color color}) {
    return Column(
      children: [
        Icon(
          icon,
          color: color ?? Colors.black87,
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

  Widget pop(IconData icon, text, Function onselect, {Color color}) {
    return Column(
      children: [
        Container(
          height: 25,
          child: PopupMenuButton(
            padding: EdgeInsets.all(0),

            icon: Icon(
              icon,
              color: color ?? Colors.black87,
            ),
            // color: kScaffoldColor,
            onSelected: (value) => onselect(),
            // onSelected: (value) => model.showReportDialog(context),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: "Share",
                child: Text("Share"),
              )
            ],
          ),
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
