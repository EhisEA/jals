import 'package:flutter/material.dart';
import 'package:jals/ui/video/view_models/video_downloads_view_model.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:stacked/stacked.dart';

class VideoDownload extends StatefulWidget {
  @override
  _VideoDownloadState createState() => _VideoDownloadState();
}

class _VideoDownloadState extends State<VideoDownload> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<VideoDownloadViewModel>.reactive(
      onModelReady: (model) => model.getAllVideos(),
      viewModelBuilder: () => VideoDownloadViewModel(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: List.generate(
                  model.videoDownloadList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: VideoTile(
                      videoModel: model.videoDownloadList[index],
                      // image:
                      //     "https://cdn.mos.cms.futurecdn.net/yL3oYd7H2FHDDXRXwjmbMf.jpg",
                      // title: "How to Pray and Communicate with God",
                      // author: "Download 2020/30/03",
                      showPrimaryButton: false,
                      showSecondaryButton: false,
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
