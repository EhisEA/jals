import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/ui/audio/view_model/audio_player_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/jals_icons_icons.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/back_icon.dart';
import 'package:jals/widgets/comment_widget.dart';
import 'package:jals/widgets/image.dart';
import 'package:jals/widgets/view_models/comment_widget_view_model.dart';
import 'package:stacked/stacked.dart';

format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

class AudioPlayerView extends StatelessWidget {
  CommentWidgetViewModel _commentWidgetViewModel;
  final AudioModel audio;

  AudioPlayerView({Key key, this.audio}) {
    _commentWidgetViewModel = CommentWidgetViewModel(audio.id);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<AudioPlayerViewModel>.reactive(
        onModelReady: (model) => model.initiliseAudio(audio.dataUrl),
        viewModelBuilder: () => locator<AudioPlayerViewModel>(),
        disposeViewModel: false,
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
                  ClipOval(
                    child: Container(
                      height: 180,
                      width: 180,
                      child: ShowNetworkImage(
                        imageUrl: audio.coverImage,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //   // alignment: Alignment.center,
                  //   // height: 40,
                  //   // width: 200,
                  //   constraints: BoxConstraints(
                  //     minHeight: 20,
                  //     minWidth: 100,
                  //     maxWidth: 200,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20),
                  //     color: kGreen,
                  //   ),
                  //   child: TextCaptionWhite(text: "Feelings"),
                  // ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.6,
                    child: TextHeader2(
                      text: audio.title,

                      //  "Lord, We Come to Worship",
                      center: true,
                    ),
                  ),
                  SizedBox(height: 15),
                  TextCaption2(
                    text: "By ${audio.author}",
                    center: true,
                  ),
                  SizedBox(height: 15),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fast_rewind,
                        color: Color(0xffD9D9D9),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: model.play_pause,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: kPrimaryColor,
                          child: Icon(
                            model.canPlay ? Icons.play_arrow : Icons.pause,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.fast_forward,
                        color: Color(0xffD9D9D9),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildIcon(JalsIcons.favorite, "Listen Later", () {}),
                      buildIcon(JalsIcons.download, "Download", () {}),
                      buildIcon(JalsIcons.comment, "Comment", () {}),
                      buildIcon(JalsIcons.more, "more", () {
                        displayPlayListOption(context, model);
                      }),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  CommentWidget(
                    commentWidgetViewModel: _commentWidgetViewModel,
                  )
                ],
              ),
            ),
          );
        });
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

  Widget displayPlayListOption(
      BuildContext context, AudioPlayerViewModel viewModel) {
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
                              onTap: () =>
                                  model.addToPlaylist(playlist.id, audio),
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
}
