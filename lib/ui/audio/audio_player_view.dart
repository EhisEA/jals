import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/ui/audio/view_model/audio_player_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/jals_icons_icons.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/back_icon.dart';
import 'package:jals/widgets/comment_widget.dart';
import 'package:jals/widgets/extended_text_field.dart';
import 'package:jals/widgets/image.dart';
import 'package:jals/widgets/view_models/comment_widget_view_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stacked/stacked.dart';

format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

class AudioPlayerView extends StatefulWidget {
  final List<AudioModel> audios;
  final String playlistName;

  AudioPlayerView({Key key, this.audios, this.playlistName}) {}

  @override
  _AudioPlayerViewState createState() => _AudioPlayerViewState();
}

class _AudioPlayerViewState extends State<AudioPlayerView> {
  CommentWidgetViewModel commentWidgetViewModel;

  @override
  Widget build(BuildContext context) {
    SliderThemeData _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
    SizeConfig().init(context);
    return ViewModelBuilder<AudioPlayerViewModel>.reactive(
        onModelReady: (model) => model.initiliseAudio(widget.audios,
            playlistName: widget.playlistName),
        viewModelBuilder: () =>
            AudioPlayerViewModel(), // locator<AudioPlayerViewModel>(),
        // disposeViewModel: false,
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(
              leading: BackIcon(),
              title: TextHeader(
                text: "Listen to Audio",
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  if (model.currentlyPlaying != null)
                    ClipOval(
                      child: Container(
                        height: 180,
                        width: 180,
                        child: ShowNetworkImage(
                          imageUrl: model.currentlyPlaying.coverImage,
                        ),
                      ),
                    ),
                  SizedBox(height: 20),
                  if (model.playlistName != null)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      // alignment: Alignment.center,
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
                      child: TextCaptionWhite(
                        text: "${model.playlistName}",
                        centered: true,
                        maxLine: 3,
                      ),
                    ),
                  SizedBox(height: 20),
                  if (model.currentlyPlaying != null)
                    Container(
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: TextHeader2(
                        text: model.currentlyPlaying.title,

                        //  "Lord, We Come to Worship",
                        center: true,
                      ),
                    ),
                  SizedBox(height: 15),
                  if (model.currentlyPlaying != null)
                    TextCaption2(
                      text: "By ${model.currentlyPlaying..author}",
                      center: true,
                    ),
                  SizedBox(height: 15),
                  Stack(
                    children: [
                      Center(
                        child: SliderTheme(
                          data: _sliderThemeData.copyWith(
                            thumbShape: HiddenThumbComponentShape(),
                            activeTrackColor: Colors.blue.shade100,
                            inactiveTrackColor: Colors.grey.shade300,
                          ),
                          child: ExcludeSemantics(
                            child: Slider(
                              max: model.totalDuration == null
                                  ? 20
                                  : model.totalDuration.inMilliseconds
                                      .toDouble(),
                              value: model.bufferedPosition == null
                                  ? 0
                                  : model.bufferedPosition.inMilliseconds
                                      .toDouble(),
                              onChanged: (value) {},
                              inactiveColor: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                      Slider(
                        max: model.totalDuration == null
                            ? 20
                            : model.totalDuration.inMilliseconds.toDouble(),
                        value: model.streamPosition == null
                            ? 0
                            : model.streamPosition.inMilliseconds.toDouble(),
                        onChanged: (value) {
                          model.seek(value);
                        },
                        inactiveColor: Colors.transparent,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        TextCaption2(
                          text: model.streamPosition == null
                              ? "00:00"
                              : format(model.streamPosition), //00:09:07
                        ),
                        Spacer(),
                        TextCaption2(
                          text: model.totalDuration == null
                              ? "00:00"
                              : format(model.totalDuration),
                        ),
                      ],
                    ),
                  ),
                  ControlButtons(model.audioPlayer),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildIcon(JalsIcons.favorite, "Listen Later", () {}),
                      buildIcon(JalsIcons.download, "Download", () {}),
                      buildIcon(
                        JalsIcons.comment,
                        "Comment",
                        () {
                          if (model.audioPlayer.currentIndex != null)
                            model.commentWidgetViewModels[
                                    model.audioPlayer.currentIndex]
                                .writeComment(context);
                        },
                      ),
                      pop(JalsIcons.more, "more", (value) {
                        switch (value.toLowerCase()) {
                          case "playlist":
                            displayPlayListOption(context, model);
                            break;
                          case "share":
                            model.share();
                            break;
                          default:
                        }
                      }),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  if (model.playinIndex >= 0 &&
                      model.playinIndex <= model.commentWidgets.length)
                    model.commentWidgets[model.playinIndex],
                ],
              ),
            ),
          );
        });
  }

  sendComment(BuildContext context) {
    if (commentWidgetViewModel != null)
      commentWidgetViewModel.writeComment(context);
  }

  writeComment(
      BuildContext context, CommentWidgetViewModel _commentWidgetViewModel) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ViewModelBuilder<CommentWidgetViewModel>.reactive(
          viewModelBuilder: () => _commentWidgetViewModel,
          disposeViewModel: false,
          builder: (context, model, _) {
            return Container(
              height: MediaQuery.of(context).size.height / 2 +
                  MediaQuery.of(context).viewInsets.bottom,
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
                              onTap: () {
                                model.sendComment();
                              },
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
}

Widget buildIcon(icon, text, Function action) {
  return InkWell(
    onTap: action,
    child: Column(
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
    ),
  );
}

displayPlayListOption(BuildContext context, AudioPlayerViewModel viewModel) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: ViewModelBuilder<AudioPlayerViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        disposeViewModel: false,
        builder: (context, model, _) {
          if (!model.isSecondaryBusy && model.playList == null) {
            model.getPlaylist();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //heading==========
              Row(
                children: [
                  TextArticle(text: "Playlist"),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),
              Expanded(
                child: model.isSecondaryBusy
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: model.playList.length,
                        itemBuilder: (context, index) {
                          PlayListModel playlist = model.playList[index];
                          return ListTile(
                            onTap: () => model.addToPlaylist(
                                playlist.id, model.currentlyPlaying),
                            title: Text(playlist.title),
                            subtitle:
                                Text(playlist.count.toString() + " Songs"),
                            trailing: Icon(Icons.add),

                            // subtitle: Text(),
                          );
                        },
                      ),
              )
            ],
          );
        },
      ),
    ),
  );
}

Widget pop(IconData icon, text, Function(String) onselect, {Color color}) {
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
          onSelected: (value) => onselect(value),
          // onSelected: (value) => model.showReportDialog(context),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: "playlist",
              child: Text("Add to platlist"),
            ),
            PopupMenuItem(
              value: "share",
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

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<SequenceState>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: player.hasPrevious ? player.seekToPrevious : null,
          ),
        ),
        SizedBox(width: 20),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return InkWell(
                onTap: player.play,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: kPrimaryColor,
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              );
            } else if (processingState != ProcessingState.completed) {
              return InkWell(
                onTap: player.pause,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: kPrimaryColor,
                  child: Icon(
                    Icons.pause,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              );

              //  IconButton(
              //   icon: Icon(Icons.pause),
              //   iconSize: 64.0,
              //   onPressed: player.pause,
              // );
            } else {
              return InkWell(
                onTap: () => player.seek(Duration.zero,
                    index: player.effectiveIndices.first),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: kPrimaryColor,
                  child: Icon(
                    Icons.replay,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              );
            }
          },
        ),
        SizedBox(width: 20),
        StreamBuilder<SequenceState>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: player.hasNext ? player.seekToNext : null,
          ),
        ),
      ],
    );
  }

  Widget more(IconData icon, text, Function onselect, {Color color}) {
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

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {}
}
