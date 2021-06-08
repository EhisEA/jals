import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/ui/audio/view_model/audio_download.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/widgets/downloaded_audio_tile.dart';
import 'package:jals/widgets/downloading_audio_tile.dart';
import 'package:jals/widgets/empty.dart';
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
                builder: (context, downloadingModel, _) {
                  return

                      //show empty if both models are null
                      downloadingModel.downloadList == null &&
                              model.audio == null
                          ? Column(
                              children: [
                                SizedBox(height: 100),
                                Empty(),
                                Text("No Downloaded audio yet")
                              ],
                            )
                          //show empty if both models are empty
                          : downloadingModel.downloadList.isEmpty &&
                                  model.audio.isEmpty
                              ? Column(
                                  children: [
                                    SizedBox(height: 100),
                                    Empty(),
                                    Text("No Downloaded audio yet")
                                  ],
                                )
                              : Column(
                                  children: [
                                    ...List.generate(
                                      downloadingModel.downloadList.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: DownloadingAudioTile(
                                          audio: downloadingModel
                                              .downloadList[index].audio,
                                          progress: downloadingModel
                                              .downloadList[index].progress,
                                        ),
                                      ),
                                    ),
                                    //show only if something is downloading
                                    if (downloadingModel
                                        .downloadList.isNotEmpty)
                                      Divider(
                                        thickness: 2,
                                      ),
                                  ],
                                );
                },
              ),
              model.audio == null
                  ? SizedBox()
                  : Column(
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
