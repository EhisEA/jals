import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/models/audio_downloading_model.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/ui/audio/view_model/audioService.dart';
import 'package:jals/ui/audio/view_model/audio_player_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/jals_icons_icons.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/back_icon.dart';
import 'package:jals/widgets/image.dart';
import 'package:jals/widgets/view_models/comment_widget_view_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stacked/stacked.dart';
import 'package:rxdart/rxdart.dart';

import 'downloading_audio_view_model.dart';

format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

class AudioPlayerView extends StatefulWidget {
  final List<AudioModel> audios;
  final String playlistName;

  AudioPlayerView({Key key, this.audios, this.playlistName});

  @override
  _AudioPlayerViewState createState() => _AudioPlayerViewState();
}

class _AudioPlayerViewState extends State<AudioPlayerView> {
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);
  CommentWidgetViewModel commentWidgetViewModel;
  double seekPos;

  @override
  Widget build(BuildContext context) {
    SliderThemeData _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
    SizeConfig().init(context);
    return ViewModelBuilder<AudioPlayerViewModel>.reactive(
        onModelReady: (model) => model.startAudioPlayerBtn(widget.audios,
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
              body: StreamBuilder<AudioState>(
                stream: _audioStateStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final audioState = snapshot.data;
                    final queue = audioState?.queue;
                    final mediaItem = audioState?.mediaItem;
                    final playbackState = audioState?.playbackState;
                    final processingState = playbackState?.processingState ??
                        AudioProcessingState.none;
                    final playing = playbackState?.playing ?? false;
                    print(playbackState?.processingState.toString());

                    print('This is the number of mediaitem' +
                        snapshot.data.mediaItem.toString());
                    return processingState != AudioProcessingState.none
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                if (playing)
                                  ClipOval(
                                    child: Container(
                                      height: 180,
                                      width: 180,
                                      child: ShowNetworkImage(
                                        imageUrl: mediaItem?.artUri,
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 20),
                                if (mediaItem?.album != null)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
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
                                      text: "${mediaItem?.album ?? ''}",
                                      centered: true,
                                      maxLine: 3,
                                    ),
                                  ),
                                SizedBox(height: 20),
                                if (playing)
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: TextHeader2(
                                      text: mediaItem?.title != null
                                          ? mediaItem.title
                                          : "",

                                      //  "Lord, We Come to Worship",
                                      center: true,
                                    ),
                                  ),
                                SizedBox(height: 15),
                                if (playing)
                                  TextCaption2(
                                    text: "By ${mediaItem.artist}",
                                    center: true,
                                  ),
                                SizedBox(height: 15),
                                Container(
                                  width: double.infinity,
                                  height: 80,
                                  // color: Colors.red,
                                  child: StreamBuilder(
                                    stream: Rx.combineLatest2<double, double,
                                            double>(
                                        _dragPositionSubject.stream,
                                        Stream.periodic(
                                            Duration(milliseconds: 200)),
                                        (dragPosition, _) => dragPosition),
                                    builder: (context, snapshot) {
                                      double position = snapshot.data ??
                                          playbackState
                                              .currentPosition.inMilliseconds
                                              .toDouble();
                                      double duration = mediaItem
                                          ?.duration?.inMilliseconds
                                          ?.toDouble();
                                      return Stack(
                                        children: [
                                          if (duration != null)
                                            Center(
                                              child: SliderTheme(
                                                data: _sliderThemeData.copyWith(
                                                  thumbShape:
                                                      HiddenThumbComponentShape(),
                                                  activeTrackColor:
                                                      Colors.blue.shade100,
                                                  inactiveTrackColor:
                                                      Colors.grey.shade300,
                                                ),
                                                child: ExcludeSemantics(
                                                  child: Slider(
                                                    min: 0.0,
                                                    max: duration,
                                                    value: seekPos ??
                                                        max(
                                                            0.0,
                                                            min(position,
                                                                duration)),
                                                    onChanged: (value) {
                                                      _dragPositionSubject
                                                          .add(value);
                                                    },
                                                    onChangeEnd: (value) {
                                                      AudioService.seekTo(
                                                          Duration(
                                                              milliseconds: value
                                                                  .toInt()));
                                                      // Due to a delay in platform channel communication, there is
                                                      // a brief moment after releasing the Slider thumb before the
                                                      // new position is broadcast from the platform side. This
                                                      // hack is to hold onto seekPos until the next state update
                                                      // comes through.

                                                      seekPos = value;
                                                      _dragPositionSubject
                                                          .add(null);
                                                    },
                                                    inactiveColor:
                                                        Colors.grey.shade300,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (duration != null)
                                            Slider(
                                              min: 0.0,
                                              max: duration,
                                              value: seekPos ??
                                                  max(0.0,
                                                      min(position, duration)),
                                              onChanged: (value) {
                                                _dragPositionSubject.add(value);
                                              },
                                              onChangeEnd: (value) {
                                                AudioService.seekTo(Duration(
                                                    milliseconds:
                                                        value.toInt()));
                                                // Due to a delay in platform channel communication, there is
                                                // a brief moment after releasing the Slider thumb before the
                                                // new position is broadcast from the platform side. This
                                                // hack is to hold onto seekPos until the next state update
                                                // comes through.

                                                seekPos = value;
                                                _dragPositionSubject.add(null);
                                              },
                                              inactiveColor: Colors.transparent,
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      TextCaption2(
                                        text: model.streamPosition == null
                                            ? "00:00"
                                            : format(model
                                                .streamPosition), //00:09:07
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    !playing
                                        ? IconButton(
                                            icon: Icon(Icons.play_arrow),
                                            iconSize: 64.0,
                                            onPressed: AudioService.play,
                                          )
                                        : IconButton(
                                            icon: Icon(Icons.pause),
                                            iconSize: 64.0,
                                            onPressed: AudioService.pause,
                                          ),
                                    // IconButton(
                                    //   icon: Icon(Icons.stop),
                                    //   iconSize: 64.0,
                                    //   onPressed: AudioService.stop,
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.skip_previous),
                                          iconSize: 64,
                                          onPressed: () {
                                            if (mediaItem == queue.first) {
                                              return;
                                            }
                                            AudioService.skipToPrevious();
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.skip_next),
                                          iconSize: 64,
                                          onPressed: () {
                                            if (mediaItem == queue.last) {
                                              return;
                                            }
                                            AudioService.skipToNext();
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 50),
                                Container(
                                  width: double.infinity,
                                  // height: 500,
                                  // color: Colors.red,
                                  child: !model.isBusy
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            buildIcon(JalsIcons.favorite,
                                                "Listen Later", () {}),
                                            // ViewModelBuilder<
                                            //         DownloadingAudiosViewModel>.reactive(
                                            //     disposeViewModel: false,
                                            //     builder:
                                            //         (context, playerModel, _) {
                                            //       AudioDownloadingModel
                                            //           downloadingAudio =
                                            //           playerModel.downloadList
                                            //               .firstWhere(
                                            //                   (element) =>
                                            //                       element.id ==
                                            //                       model
                                            //                           .currentlyPlaying
                                            //                           .id,
                                            //                   orElse: () =>
                                            //                       null);

                                            //       // if(videoDownloaded){

                                            //       // }
                                            //       //downloading

                                            //       if (downloadingAudio !=
                                            //           null) {
                                            //         return buildDownloadProgress(
                                            //           downloadingAudio
                                            //                   .progress /
                                            //               100,
                                            //         );
                                            //       }
                                            //       //not downloaded and downloaded

                                            //       // if (model.video.downloaded) {
                                            //       return buildIcon(
                                            //           model.currentlyPlaying
                                            //                   .downloaded
                                            //               ? Icons
                                            //                   .download_done_rounded
                                            //               : JalsIcons.download,
                                            //           "Download", () {
                                            //         if (!model.currentlyPlaying
                                            //             .downloaded)
                                            //           playerModel.download(model
                                            //               .currentlyPlaying);
                                            //       },
                                            //           color: model
                                            //                   .currentlyPlaying
                                            //                   .downloaded
                                            //               ? kPrimaryColor
                                            //               : null);
                                            //       // }
                                            //       // playerModel.downloadList
                                            //       //     .firstWhere((element) => false);
                                            //       // return InkWell(
                                            //       //   onTap: () {
                                            //       //     playerModel.download(widget.video);
                                            //       //     print("download");
                                            //       //   },
                                            //       //   child: Text("ssss"),
                                            //       // );
                                            //     },
                                            //     viewModelBuilder: () => locator<
                                            //         DownloadingAudiosViewModel>()),
                                            buildIcon(
                                              JalsIcons.comment,
                                              "Comment",
                                              () {
                                                
                                                if (model.audioPlayer
                                                        .currentIndex !=
                                                    null)
                                                  model.commentWidgetViewModels[
                                                          model.audioPlayer
                                                              .currentIndex]
                                                      .writeComment(context);
                                              },
                                            ),
                                            pop(JalsIcons.more, "more",
                                                (value) {
                                              switch (value.toLowerCase()) {
                                                case "playlist":
                                                  displayPlayListOption(
                                                      context, model);
                                                  break;
                                                case "share":
                                                  model.share();
                                                  break;
                                                default:
                                              }
                                            }),
                                          ],
                                        )
                                      : Center(
                                          child: CircularProgressIndicator()),
                                ),
                                SizedBox(height: 20),
                                Divider(),
                                if (model.playinIndex >= 0 &&
                                    model.playinIndex <=
                                        model.commentWidgets.length)
                                  model.commentWidgets[model.playinIndex],
                              ],
                            ),
                          )
                        : Center(
                            child: Text('Processing'),
                          );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ));
        });
  }
}

Widget buildIcon(icon, text, Function action, {Color color}) {
  return InkWell(
    onTap: action,
    child: Column(
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
    ),
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
        StreamBuilder<AudioState>(
            stream: _audioStateStream,
            builder: (context, snapshot) {
              final audioState = snapshot.data;
              final queue = audioState?.queue;
              final mediaItem = audioState?.mediaItem;
              final playbackState = audioState?.playbackState;
              final processingState =
                  playbackState?.processingState ?? AudioProcessingState.none;
              final playing = playbackState?.playing ?? false;
              return IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: () {
                    if (mediaItem == queue.first) {
                      return;
                    }
                    AudioService.skipToPrevious();
                  });
            }),
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

Stream<AudioState> get _audioStateStream {
  return Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState,
      AudioState>(
    AudioService.queueStream,
    AudioService.currentMediaItemStream,
    AudioService.playbackStateStream,
    (queue, mediaItem, playbackState) => AudioState(
      queue,
      mediaItem,
      playbackState,
    ),
  );
}

// Stream<AudioState2> get mediaStateStream =>
//     Rx.combineLatest2<Duration, MediaItem, AudioState2>(
//         AudioService.positionStream,
//         AudioService.currentMediaItemStream,
//         (position, mediaItem) => AudioState2(position, mediaItem.duration));

void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
