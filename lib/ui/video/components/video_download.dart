import 'package:flutter/material.dart';
import 'package:jals/ui/video/view_models/video_downloads_view_model.dart';
import 'package:stacked/stacked.dart';

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
        return Center(
          child: Text("Working on it"),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
