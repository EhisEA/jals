import 'package:flutter/material.dart';
import 'package:jals/ui/video/view_models/video_all_view_model.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/widgets/empty.dart';
import 'package:jals/widgets/retry.dart';
import 'package:jals/widgets/video_tile.dart';
import 'package:stacked/stacked.dart';

class VideoAll extends StatefulWidget {
  @override
  _VideoAllState createState() => _VideoAllState();
}

class _VideoAllState extends State<VideoAll>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<VideoAllViewModel>.reactive(
      onModelReady: (model) {
        if (!model.isBusy && model.allVideoList == null) {
          model.getAllVideos();
        } else if (!model.isBusy && model.allVideoList.isEmpty) {
          model.getAllVideos();
        }
      },
      disposeViewModel: false,
      viewModelBuilder: () => locator<VideoAllViewModel>(),
      builder: (context, model, child) {
        return model.state == ViewState.Busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : model.allVideoList == null
                ? Retry(
                    onRetry: model.getAllVideos,
                  )
                : model.allVideoList.isEmpty
                    ? Empty(
                        title: "No video here",
                      )
                    : RefreshIndicator(
                        onRefresh: model.getAllVideos,
                        child: ListView(
                          children: List.generate(
                            model.allVideoList.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: VideoTile(
                                videoModel: model.allVideoList[index],
                                popOption: ["Share"],
                                onOptionSelect: (value) => model.onOptionSelect(
                                  value,
                                  model.allVideoList[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
