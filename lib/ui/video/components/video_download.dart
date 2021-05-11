import 'package:flutter/material.dart';
import 'package:jals/ui/video/view_models/video_download_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/empty.dart';
import 'package:jals/widgets/retry.dart';
import 'package:stacked/stacked.dart';

import '../view_models/downloading_videos_view_model.dart';

class VideoDownload extends StatefulWidget {
  @override
  _VideoDownloadState createState() => _VideoDownloadState();
}

class _VideoDownloadState extends State<VideoDownload>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<VideoDownloadViewModel>.reactive(
      viewModelBuilder: () => VideoDownloadViewModel(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return ListView(
          children: [
            ViewModelBuilder<DownloadingVideosViewModel>.reactive(
              viewModelBuilder: () => locator<DownloadingVideosViewModel>(),
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
                                  child: DownloadingVideoTile(
                                    videoModel: model.downloadList[index].video,
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
            ViewModelBuilder<VideoDownloadViewModel>.reactive(
              viewModelBuilder: () => locator<VideoDownloadViewModel>(),
              onModelReady: (model) => model.getVideos(),
              builder: (context, model, _) {
                return model.isBusy
                    ? Center(child: CircularProgressIndicator())
                    : model.videos == null
                        ? Retry(
                            onRetry: model.getVideos,
                          )
                        : model.videos.isEmpty
                            ? Empty(
                                title: "No Downloaded Video yet",
                              )
                            : Column(
                                children: List.generate(
                                  model.videos.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: DownloadedVideoTile(
                                      videoModel: model.videos[index],
                                      popOption: ["Delete"],
                                      onOptionSelect: (value) {},
                                    ),
                                  ),
                                ),
                              );
              },
            )
          ],
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
