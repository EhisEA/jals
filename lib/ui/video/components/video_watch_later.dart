import 'package:flutter/material.dart';
import 'package:jals/ui/video/view_models/video_watch_late_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/empty.dart';
import 'package:jals/widgets/retry.dart';
import 'package:stacked/stacked.dart';

class VideoWatchLater extends StatefulWidget {
  @override
  _VideoWatchLaterState createState() => _VideoWatchLaterState();
}

class _VideoWatchLaterState extends State<VideoWatchLater>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<VideoWatchLaterViewModel>.reactive(
      onModelReady: (model) => model.getAllVideos(),
      disposeViewModel: false,
      viewModelBuilder: () => locator<VideoWatchLaterViewModel>(),
      builder: (context, model, child) {
        return model.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : model.videoWatchLaterList == null
                ? Retry(
                    onRetry: model.getAllVideos,
                  )
                : model.videoWatchLaterList.isEmpty
                    ? Empty(
                        title: "No video here",
                      )
                    : ListView(
                        children: List.generate(
                          model.videoWatchLaterList.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: VideoTile(
                              videoModel: model.videoWatchLaterList[index],
                              popOption: ["Share"],
                              onOptionSelect: (value) => model.onOptionSelect(
                                value,
                                model.videoWatchLaterList[index],
                              ),
                              showPrimaryButton: false,
                            ),
                          ),
                        ),
                      );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
