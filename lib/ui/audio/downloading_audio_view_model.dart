import 'package:jals/models/audio_downloading_model.dart';
import 'package:jals/models/video_downloading_model.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/services/download_sercvice.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';

class DownloadingAudiosViewModel extends BaseViewModel {
  final DownloadService _downloadService = locator<DownloadService>();
  List<AudioDownloadingModel> downloadList = [];

  downloadCallback(rcv, total, id) {
    AudioDownloadingModel dow = downloadList
        .firstWhere((element) => element.id == id, orElse: () => null);
    dow.recieved = double.parse(rcv.toString());
    dow.progress = double.parse(((rcv / total) * 100).toStringAsFixed(0));
    dow.total = double.parse(total.toString());
    if (dow.progress == 100) {
      dow.downloaded = true;
      dow.downloading = false;
      print("finished downloading");
    }

    setBusy(ViewState.Busy);
    // downloadList.contains({});
  }

  download(AudioModel audio) async {
    downloadList.add(AudioDownloadingModel(
      id: audio.id,
      progress: 0,
      recieved: 0,
      total: 0,
      downloading: true,
      audio: audio,
    ));
    print(downloadList.length);
    bool cal = await _downloadService.downloadAudioFile(
      audio,
      (rcv, tol) {
        print(((rcv / tol) * 100).toStringAsFixed(0));
        downloadCallback(rcv, tol, audio.id);
      },
    );
    int index = downloadList.indexWhere((element) => element.id == audio.id);
    downloadList.removeAt(index);
    print("cal=======$cal");
    print(downloadList.length);
    setBusy(ViewState.Idle);
  }
}
