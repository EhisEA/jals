import 'package:jals/models/video_model.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/services/video_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';

class VideoAllViewModel extends BaseViewModel {
  VideoService _videoService = locator<VideoService>();
  NetworkConfig _networkConfig = new NetworkConfig();
  DialogService _dialogService = locator<DialogService>();
  List<VideoModel> _allVideoList = [];
  List<VideoModel> get allVideoList => [..._allVideoList];
  bool hasError = false;
  getAllVideos() async {
    setBusy(ViewState.Busy);
    await _networkConfig.onNetworkAvailabilityDialog(onNetwork);
    setBusy(ViewState.Idle);
  }

  onNetwork() async {
    try {
      List<VideoModel> videos = await _videoService.getVideoList();
      if (videos.length >= 1) {
        _allVideoList = videos;
        hasError = false;
        notifyListeners();
      } else {
        hasError = true;
        _allVideoList = [];
        notifyListeners();
        // await _dialogService.showDialog(
        //     title: "Fetching Videos Error",
        //     buttonTitle: "OK",
        //     description:
        //         "An Error Occured while trying to fetch your video list, Please try again.");
      }
    } catch (e) {
      print(e);
      hasError = true;
    }
  }
}
