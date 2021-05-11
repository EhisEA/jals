import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/enums/small_viewstate.dart';
import 'package:jals/models/downloading_model.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/ui/video/view_models/downloading_videos_view_model.dart';
import 'package:jals/ui/video/view_models/video_player_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/jals_icons_icons.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/back_icon.dart';
import 'package:jals/widgets/comment_widget.dart';
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
                InkWell(
                  onTap: model.toggleShowControl,
                  child: AspectRatio(
                    aspectRatio: 1.33,
                    child: model.isBusy
                        ? Container(
                            color: Colors.black,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : Container(
                            color: Colors.black,
                            child: Stack(
                              children: [
                                VideoPlayer(
                                  model.videoPlayerController,
                                ),
                                model.videoPlayerController.value.isBuffering
                                    ? Center(child: CircularProgressIndicator())
                                    : Container(),
                                if (!model.isBusy)
                                  AnimatedPositioned(
                                    curve: Curves.easeInOut,
                                    bottom: model.showControl ? 0 : -100,
                                    left: 0,
                                    right: 0,
                                    duration: Duration(seconds: 1),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                              icon: model.videoPlayerController
                                                      .value.isPlaying
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
                if (!model.isBusy)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!model.isSmallViewStateBusy)
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
                      ViewModelBuilder<DownloadingVideosViewModel>.reactive(
                          disposeViewModel: false,
                          builder: (context, playerModel, _) {
                            DownloadingModel downloadingVideo =
                                playerModel.downloadList.firstWhere(
                                    (element) => element.id == widget.video.id,
                                    orElse: () => null);

                            // if(videoDownloaded){

                            // }
                            //downloading

                            if (downloadingVideo != null) {
                              return buildDownloadProgress(
                                downloadingVideo.progress / 100,
                              );
                            }
                            //not downloaded and downloaded

                            // if (model.video.downloaded) {
                            return InkWell(
                              onTap: () {
                                if (!model.video.downloaded)
                                  playerModel.download(widget.video);
                              },
                              child: buildIcon(
                                  model.video.downloaded
                                      ? Icons.download_done_rounded
                                      : JalsIcons.download,
                                  "Download",
                                  color: model.video.downloaded
                                      ? kPrimaryColor
                                      : null),
                            );
                            // }
                            // playerModel.downloadList
                            //     .firstWhere((element) => false);
                            // return InkWell(
                            //   onTap: () {
                            //     playerModel.download(widget.video);
                            //     print("download");
                            //   },
                            //   child: Text("ssss"),
                            // );
                          },
                          viewModelBuilder: () =>
                              locator<DownloadingVideosViewModel>()),
                      InkWell(
                        onTap: () =>
                            _commentWidgetViewModel.writeComment(context),
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

  Widget buildDownloadProgress(value) {
    return Column(
      children: [
        Container(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            value: value,
            backgroundColor: kPrimaryColor.shade100,
          ),
        ),
        SizedBox(height: 2),
        Text(
          "Downloading",
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
