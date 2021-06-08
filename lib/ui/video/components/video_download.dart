import 'package:flutter/material.dart';
import 'package:jals/ui/video/view_models/video_download_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/widgets/downloaded_video_tile.dart';
import 'package:jals/widgets/downloading_video_tile.dart';
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
              builder: (context, downloadModel, _) {
                return downloadModel.downloadList == null &&
                        model.videos == null
                    ? Column(
                        children: [
                          SizedBox(height: 100),
                          Retry(
                            onRetry: model.getVideos,
                          ),
                        ],
                      )
                    //when only down

                    : downloadModel.downloadList.isEmpty && model.videos.isEmpty
                        ? Column(
                            children: [
                              SizedBox(height: 100),
                              Empty(
                                title: "No Downloaded Video yet",
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              ...List.generate(
                                downloadModel.downloadList.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: DownloadingVideoTile(
                                    videoModel:
                                        downloadModel.downloadList[index].video,
                                    progress: downloadModel
                                        .downloadList[index].progress,
                                  ),
                                ),
                              ),
                              if (downloadModel.downloadList.isNotEmpty)
                                Divider(
                                  thickness: 2,
                                ),
                            ],
                          );
              },
            ),
            model.isBusy
                ? Center(child: CircularProgressIndicator())
                : model.videos == null
                    ? SizedBox()
                    : model.videos.isEmpty
                        ? SizedBox()
                        : Column(
                            children: List.generate(
                              model.videos.length,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: DownloadedVideoTile(
                                  videoModel: model.videos[index],
                                  popOption: ["Delete"],
                                  onOptionSelect: (value) {},
                                ),
                              ),
                            ),
                          ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
