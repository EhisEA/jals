import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/enums/small_viewstate.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/services/dynamic_link_service.dart';
import 'package:jals/services/video_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerViewViewModel extends BaseViewModel {
  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
  VideoPlayerController videoPlayerController;
  VideoModel video;
  NetworkConfig _networkConfig = new NetworkConfig();
  VideoService _videoService = VideoService();
  int currentTime = 0;
  int totalTime = 0;
  Duration totalDuration;
  Duration currentDuration;
  String _dynamicLink;
  bool showControl = false;

  toggleShowControl() {
    showControl = !showControl;
    notifyListeners();
  }

  String convertTime(int time) {
    int minutes = (time / 60).truncate();
    String convertedValue = (minutes % 60).toString().padLeft(2, '0');
    return convertedValue;
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.pause();
    videoPlayerController.dispose();
  }

  String convertTotal() {
    return totalDuration == null ? "00:00" : formart(totalDuration);
  }

  String convertCurrent() {
    return currentDuration == null ? "00:00" : formart(currentDuration);
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

  pauseOrPlay() {
    videoPlayerController.value.isPlaying ? _pause() : _play();
  }

  _play() {
    videoPlayerController.play();
    setBusy(ViewState.Idle);
  }

  _pause() {
    videoPlayerController.pause();
    setBusy(ViewState.Idle);
  }

  seek(Duration seekDuration) {
    videoPlayerController.seekTo(seekDuration);
    setBusy(ViewState.Idle);
  }

  void initializeVideo({VideoModel videoModel}) async {
    this.video = videoModel;
    print('========INITIALIZING THE VIDEO LAYER');
    setBusy(ViewState.Busy);
    videoPlayerController = VideoPlayerController.network(videoModel.dataUrl)
      ..initialize().then(
        (value) async {
          if (videoPlayerController.value.initialized) {
            onModelReady();
            print('done =========================');
          } else {
            print("Not yet initialized");
          }
          if (videoModel != null)
            _dynamicLink = await _dynamicLinkService
                .createEventLink(videoModel.toContent());

          setBusy(ViewState.Idle);
        },
      );
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
      video.isBookmarked = true;
      setBusy(ViewState.Idle);
    } else {
      await Fluttertoast.showToast(
          msg: 'Cannot add to watch later list.', fontSize: 16.0);
      video.isBookmarked = false;
      setBusy(ViewState.Idle);
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
      video.isBookmarked = false;
    } else {
      await Fluttertoast.showToast(
          msg: 'Cannot remove video from watch later list.', fontSize: 16.0);
      video.isBookmarked = true;
    }
  }

// sharing

  share() async {
    if (video == null) return;

    if (_dynamicLink == null || _dynamicLink == "") {
      _dynamicLink =
          await _dynamicLinkService.createEventLink(video.toContent());
    }

    if (_dynamicLink == null || _dynamicLink == "") {
      Fluttertoast.showToast(
          msg: "No internet",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
    Share.share(_dynamicLink);
  }
}
