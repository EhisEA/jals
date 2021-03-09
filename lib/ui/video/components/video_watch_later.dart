import 'package:flutter/material.dart';
import 'package:jals/ui/video/view_models/video_watch_late_view_model.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:stacked/stacked.dart';

class VideoWatchLater extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoWatchLaterViewModel>.reactive(
      onModelReady: (model) => model.getAllVideos(),
      disposeViewModel: false,
      viewModelBuilder: () => VideoWatchLaterViewModel(),
      builder: (context, model, child) {
        return model.state == ViewState.Busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: List.generate(
                  model.videoWatchLaterList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: VideoTile(
                      videoModel: model.videoWatchLaterList[index],
                      // videoModel: index,
                      // image:
                      //     "https://cdn.mos.cms.futurecdn.net/yL3oYd7H2FHDDXRXwjmbMf.jpg",
                      // title: "How to Pray and Communicate with God",
                      // author: "Wade Warren",
                      showPrimaryButton: false,
                    ),
                  ),
                ),
              );
      },
    );
  }
}
