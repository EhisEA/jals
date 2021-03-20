import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/enums/small_viewstate.dart';
import 'package:jals/services/video_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerViewViewModel extends BaseViewModel {
  VideoPlayerController videoPlayerController;
  bool bookmark = false;
  NetworkConfig _networkConfig = new NetworkConfig();
  VideoService _videoService = locator<VideoService>();
  int currentTime = 0;
  int totalTime = 0;
  Duration totalDuration;
  Duration currentDuration;
  String convertTime(int time) {
    int minutes = (time / 60).truncate();
    String convertedValue = (minutes % 60).toString().padLeft(2, '0');
    return convertedValue;
  }

  String convertTotal() {
    var value = totalTime / 60;
    if (value >= 1) {
      return "${value.toInt()}" +
          ":" +
          "${value.remainder(1.0).roundToDouble()}";
    } else {
      return "$value" + ":" + "00";
    }
  }

  String convertCurrent() {
    var value = currentTime / 60;
    if (value >= 1) {
      return "${value.toInt()}" +
          ":" +
          "${value.remainder(1.0).roundToDouble().toInt()}";
    } else {
      return "$value" + ":" + "00";
    }
  }

  formart(Duration d) => d.toString().split('.').first.padLeft(8, '0');
  onModelReady() {
    videoPlayerController.addListener(() {
      print('listening on a value fom video player controller');
      currentTime = videoPlayerController.value.position.inSeconds;
      totalTime = videoPlayerController.value.duration.inSeconds;
      totalDuration = videoPlayerController.value.duration;
      currentDuration = videoPlayerController.value.position;
      notifyListeners();
    });
  }

  void initializeVideo({String videoUrl}) async {
    print('========INITIALIZING THE VIDEO LAYER');
    setBusy(ViewState.Busy);
    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((value) {
        if (videoPlayerController.value.initialized) {
          setBusy(ViewState.Idle);
          onModelReady();
          print('done =========================');
        } else {
          print("Not yet initialized");
          setBusy(ViewState.Busy);
        }
      });
  }

  void addToBookmarks(String uid) async {
    setSmallViewState(SmallViewState.Occuppied);
    await _networkConfig
        .onNetworkAvailabilityToast(() => onNetworkAddToBookmarks(uid));
    setSmallViewState(SmallViewState.Done);
  }

  void onNetworkAddToBookmarks(String uid) async {
    ApiResponse response = await _videoService.addToBookmarks(uid: uid);
    if (response == ApiResponse.Success) {
      await Fluttertoast.showToast(
          msg: 'Added to watch later list.', fontSize: 16.0);
    } else {
      await Fluttertoast.showToast(
          msg: 'Cannot add to watch later list.', fontSize: 16.0);
    }
  }

  void removeFromBookmarks(String uid) async {
    setSmallViewState(SmallViewState.Occuppied);
    await _networkConfig
        .onNetworkAvailabilityToast(() => onNetworkRemoveFromBookmarks(uid));
    setSmallViewState(SmallViewState.Done);
  }

  void onNetworkRemoveFromBookmarks(String uid) async {
    ApiResponse response = await _videoService.removeFromBookmarks(uid: uid);
    if (response == ApiResponse.Success) {
      await Fluttertoast.showToast(
        msg: 'Removed from  watch later list.',
        fontSize: 16.0,
      );
    } else {
      await Fluttertoast.showToast(
          msg: 'Cannot remove video from watch later list.', fontSize: 16.0);
    }
  }
}
