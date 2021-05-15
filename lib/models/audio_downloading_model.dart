import 'audio_model.dart';

class AudioDownloadingModel {
  String id;
  double progress;
  double recieved;
  double total;
  bool downloaded;
  bool downloading;
  AudioModel audio;
  AudioDownloadingModel({
    this.id,
    this.downloaded: false,
    this.downloading,
    this.progress,
    this.recieved,
    this.total,
    this.audio,
  });

  //  {
  //     "id": "mmms",
  //     "progress": 20.3,
  //     "total": 1009,
  //     "received": 92,
  //     "downlaoded": false,
  //   },
}
