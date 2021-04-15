import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/content_model.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/article_services.dart';
import 'package:jals/services/audio_service.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/services/video_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';

class DynamicLinkEntryViewModel extends BaseViewModel {
  final AudioService _audioService = AudioService();
  final VideoService _videoService = VideoService();
  final ArticleService _articleService = ArticleService();
  final NavigationService _navigationService = locator<NavigationService>();
  //
  //
  ///
  getPost(String contentId, String contentType) async {
    ContentModel contentModel = ContentModel();

    switch (contentModel.getContentType(contentType)) {
      case ContentType.Article:
        article(contentId);
        break;
      case ContentType.Audio:
        audio(contentId);
        break;
      case ContentType.News:
        article(contentId);
        break;
      case ContentType.Video:
        video(contentId);
        break;
      default:
        Navigator.of(_navigationService.navigatorKey.currentContext).pop();
        Fluttertoast.showToast(
          msg: "Failed To get content",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
    }
  }

  audio(String contentId) async {
    final AudioModel audio = await _audioService.getAudio(contentId);
    Navigator.of(_navigationService.navigatorKey.currentContext).pop();
    if (audio == null) {
      Fluttertoast.showToast(
        msg: "Failed To get content",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    if (audio.isPurchased || audio.price == 0) {
      _navigationService.navigateTo(AudioPlayerViewRoute, argument: {
        "audios": [audio],
        "playlistName": null
      });
    } else {
      _navigationService.navigateTo(StoreItemViewRoute,
          argument: audio.toContent());
    }
  }

  video(String contentId) async {
    final VideoModel video = await _videoService.getVideo(contentId);
    Navigator.of(_navigationService.navigatorKey.currentContext).pop();
    if (video == null) {
      Fluttertoast.showToast(
        msg: "Failed To get content",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    print("vid");
    if (video.isPurchased || video.price == 0) {
      _navigationService.navigateTo(VideoPlayerViewRoute, argument: video);
    } else {
      _navigationService.navigateTo(
        StoreItemViewRoute,
        argument: video.toContent(),
      );
    }
  }

  article(String contentId) async {
    final ArticleModel vedio = await _articleService.getArticle(contentId);
    Navigator.of(_navigationService.navigatorKey.currentContext).pop();
    if (vedio == null) {
      Fluttertoast.showToast(
        msg: "Failed To get content",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    _navigationService.navigateTo(
      ArticleViewRoute,
      argument: {
        "audios": [audio],
        "playlistName": null
      },
    );
  }
}
