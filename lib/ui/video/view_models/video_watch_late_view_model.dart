import 'package:jals/models/video_model.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/services/video_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';

class VideoWatchLaterViewModel extends BaseViewModel {
  VideoService _videoService = locator<VideoService>();
  NetworkConfig _networkConfig = new NetworkConfig();
  DialogService _dialogService = locator<DialogService>();
  List<VideoModel> _videoWatchLaterList = [];
  List<VideoModel> get videoWatchLaterList => [..._videoWatchLaterList];

  getAllVideos() async {
    setBusy(ViewState.Busy);
    await _networkConfig.onNetworkAvailabilityDialog(onNetwork);
    setBusy(ViewState.Idle);
  }

  onNetwork() async {
    try {
      var videos = await _videoService.getVideoList();
      if (videos.length >= 1) {
        _videoWatchLaterList = videos;
        notifyListeners();
      } else {
        _videoWatchLaterList = [];
        notifyListeners();
        print("Notified Listeners");
        await _dialogService.showDialog(
            title: "Fetching Videos Error",
            buttonTitle: "OK",
            description:
                "An Error Occured while trying to fetch your video list, Please try again.");
      }
    } catch (e) {
      print(e);
    }
  }
}
