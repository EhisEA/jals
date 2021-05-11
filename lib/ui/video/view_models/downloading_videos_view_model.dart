import 'package:jals/models/downloading_model.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/services/download_sercvice.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';

class DownloadingVideosViewModel extends BaseViewModel {
  final DownloadService _downloadService = locator<DownloadService>();
  List<DownloadingModel> downloadList = [];

  downloadCallback(rcv, total, id) {
    DownloadingModel dow = downloadList
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

  download(VideoModel video) async {
    downloadList.add(DownloadingModel(
      id: video.id,
      progress: 0,
      recieved: 0,
      total: 0,
      downloading: true,
      video: video,
    ));
    print(downloadList.length);
    bool cal = await _downloadService.downloadVideoFile(
      video,
      (rcv, tol) {
        print(((rcv / tol) * 100).toStringAsFixed(0));
        downloadCallback(rcv, tol, video.id);
      },
    );
    int index = downloadList.indexWhere((element) => element.id == video.id);
    downloadList.removeAt(index);
    print("cal=======$cal");
    print(downloadList.length);
    setBusy(ViewState.Idle);
  }
}
