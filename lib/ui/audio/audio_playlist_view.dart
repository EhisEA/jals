import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/ui/audio/view_model/audio_playlist_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/back_icon.dart';
import 'package:stacked/stacked.dart';

class AudioPlaylistView extends StatelessWidget {
  final PlayListModel playList;

  const AudioPlaylistView({Key key, this.playList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<AudioPlaylsitViewModel>.reactive(
      viewModelBuilder: ()=>AudioPlaylsitViewModel(),
      onModelReady: (model)=>model.getPlaylist(),
      builder: (context, model,_) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                // leadingWidth: 45,

                leading: BackIcon(color: Colors.white,),
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
                        text: playList.title,
                        color: Colors.white,
                      ),
                      TextCaptionWhite(
                        fontWeight: FontWeight.w400,
                        text: '${playList.count} songs',
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
                delegate:
                    SliverChildBuilderDelegate((BuildContext context, int index) {
                  AudioModel _audio=playList.tracks[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    child: AudioTile(
                      audio: AudioModel(
                        coverImage:_audio.coverImage,
                        title:_audio.title ,
                        author:"${_audio.author }"
                        //  "Lecrae - Restoration",
                      ),
                    ),
                  );
                }, childCount: playList.tracks.length,),
              ),
            ],
          ),
        );
      }
    );
  }
}
