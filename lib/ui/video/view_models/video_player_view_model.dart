import 'package:flutter/material.dart';
import 'package:jals/utils/base_view_model.dart';

class VideoPlayerViewViewModel extends BaseViewModel {
  TargetPlatform _platform;
  bool isPaused = false;

  void togglePlayMode() {
    isPaused = !isPaused;
    notifyListeners();
  }

  Future<void> initializePlayer({@required String videoUrl}) async {
    print("On Model Ready");
    // videoPlayerController = VideoPlayerController.network(videoUrl)
    //   ..initialize().then((_) {
    //     print("Initializing....");
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //   });

    // setState(() {});
  }

  void fastFoword() async {
    // await videoPlayerController.seekTo(
    //   Duration(seconds: 5),
    // );
  }
}
