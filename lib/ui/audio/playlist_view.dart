import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/ui/audio/view_model/playlist_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/audio_tile.dart';
import 'package:jals/widgets/back_icon.dart';
import 'package:stacked/stacked.dart';

class AudioPlaylistView extends StatelessWidget {
  final PlayListModel playList;

  const AudioPlaylistView({Key key, this.playList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<PlaylistViewModel>.reactive(
      viewModelBuilder: () => PlaylistViewModel(playList),
      // onModelReady: (model) => model.getPlaylist(),
      builder: (context, model, _) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                // leadingWidth: 45,

                leading: BackIcon(
                  color: Colors.white,
                ),
                collapsedHeight: getProportionatefontSize(90),
                expandedHeight: getProportionatefontSize(203),
                // snap: true,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHeader(
                        text: model.playList.title,
                        color: Colors.white,
                      ),
                      TextCaptionWhite(
                        fontWeight: FontWeight.w400,
                        text: '${model.playList.count} songs',
                        fontSize: 16,
                      ),
                    ],
                  ),
                ),
                backgroundColor: kPrimaryColor,
                pinned: true,
                // title: Center(child: Text('Motivation')),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    AudioModel _audio = model.playList.tracks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: AudioTile(
                        audio: _audio,
                        popOption: ["remove", "share"],
                        onOptionSelect: (value) =>
                            model.onOptionSelect(value, _audio),
                      ),
                    );
                  },
                  childCount: model.playList.tracks.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
