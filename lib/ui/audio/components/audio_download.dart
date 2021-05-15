import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/ui/audio/view_model/audio_download.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:stacked/stacked.dart';

import '../downloading_audio_view_model.dart';

class AudioDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AudioDownloadViewModel>.reactive(
        onModelReady: (model) => model.getAudios(),
        disposeViewModel: false,
        viewModelBuilder: () => locator<AudioDownloadViewModel>(),
        builder: (context, model, _) {
          return ListView(
            children: [
              ViewModelBuilder<DownloadingAudiosViewModel>.reactive(
                viewModelBuilder: () => locator<DownloadingAudiosViewModel>(),
                disposeViewModel: false,
                builder: (context, model, _) {
                  return model.downloadList == null
                      ? SizedBox()
                      : model.downloadList.isEmpty
                          ? SizedBox()
                          : Column(
                              children: [
                                ...List.generate(
                                  model.downloadList.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: DownloadinAudioTile(
                                      audio: model.downloadList[index].audio,
                                      progress:
                                          model.downloadList[index].progress,
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                ),
                              ],
                            );
                },
              ),
              Column(
                children: List.generate(
                  model.audio.length,
                  (index) => DownloadedAudioTile(
                    audio: model.audio[index],
                  ),
                ),
              )
            ],
          );
        });
  }
}
