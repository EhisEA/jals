import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/ui/audio/view_model/audio_all_view_model.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:stacked/stacked.dart';

class AudioAll extends StatefulWidget {
  @override
  _AudioAllState createState() => _AudioAllState();
}

class _AudioAllState extends State<AudioAll> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AudioAllViewModel>.reactive(
        onModelReady: (model) => model.getAudio(),
        viewModelBuilder: () => AudioAllViewModel(),
        builder: (context, model, _) {
          return model.isBusy
              ? Center(child: CircularProgressIndicator())
              : model.audioList == null
                  ? Center(
                      child: IconButton(
                          icon: Icon(Icons.refresh), onPressed: model.getAudio))
                  : ListView(
                      children: List.generate(
                        model.audioList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: AudioTile(
                            audio: model.audioList[index],
                          ),
                        ),
                      ),
                    );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
