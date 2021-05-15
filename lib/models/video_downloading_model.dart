import 'package:jals/models/video_model.dart';

class VideoDownloadingModel {
  String id;
  double progress;
  double recieved;
  double total;
  bool downloaded;
  bool downloading;
  VideoModel video;
  VideoDownloadingModel({
    this.id,
    this.downloaded: false,
    this.downloading,
    this.progress,
    this.recieved,
    this.total,
    this.video,
  });

  //  {
  //     "id": "mmms",
  //     "progress": 20.3,
  //     "total": 1009,
  //     "received": 92,
  //     "downlaoded": false,
  //   },
}
