import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/services/video_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerViewViewModel extends BaseViewModel {
  VideoService _videoService = locator<VideoService>();
  bool isPaused = false;
  VideoPlayerController videoPlayerController;
  NetworkConfig _networkConfig = new NetworkConfig();
  void togglePlayMode() {
    isPaused = !isPaused;
    notifyListeners();
  }

  Future<void> initializePlayer({@required String videoUrl}) async {
    print("On Model Ready");
    videoPlayerController = VideoPlayerController.network(
      videoUrl,
    )..initialize().then((_) {
        print("Initializing....");
      });
  }

  addVideoToBookmark(String uid) async {
    try {
      await _networkConfig
          .onNetworkAvailabilityToast(onNetworkAddToBookmarks(uid));
    } catch (e) {
      print("The error was $e");
    }
  }

  onNetworkAddToBookmarks(String uid) async {
    try {
      ApiResponse response = await _videoService.addToBookmarks(uid: uid);
      if (response == ApiResponse.Success) {
        notifyListeners();
      } else {
        await Fluttertoast.showToast(msg: "Can not add item to bookmarks");
      }
    } catch (e) {
      print('The Error Was $e');
    }
  }

  removeFrombookmarks(String uid) async {
    try {
      await _networkConfig
          .onNetworkAvailabilityToast(onNetworkRemoveFromBookmarks(uid));
    } catch (e) {
      print("The Error was $e");
    }
  }

  onNetworkRemoveFromBookmarks(String uid) async {
    try {
      ApiResponse response = await _videoService.addToBookmarks(uid: uid);
      if (response == ApiResponse.Success) {
        notifyListeners();
      } else {
        await Fluttertoast.showToast(
            msg: "Cannot remove item remove from bookmarks");
      }
    } catch (e) {
      print("The Error was $e");
    }
  }
}
