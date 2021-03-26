import 'package:flutter/cupertino.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/ui/audio/view_model/audio_all_view_model.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:stacked/stacked.dart';

class AudioDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AudioAllViewModel>.reactive(
        onModelReady: (model) => model.getAudio,
        viewModelBuilder: () => AudioAllViewModel(),
        builder: (context, model, _) {
          return ListView(
            children: List.generate(
              10,
              (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: AudioTile(
                    audio: AudioModel(
                      coverImage:
                          "https://miro.medium.com/max/3182/1*ZdpBdyvqfb6qM1InKR2sQQ.png",
                      title: "How to Pray and Communicate with God",
                      author: "Lecrae - Download 2020/30/03",
                    ),
                  )),
            ),
          );
        });
  }
}
