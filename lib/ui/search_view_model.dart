import 'package:flutter/material.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/services/article_services.dart';
import 'package:jals/services/audio_service.dart';
import 'package:jals/services/dynamic_link_service.dart';
import 'package:jals/services/video_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:share/share.dart';
import 'package:jals/enums/content_type.dart' as ct;

class SearchViewModel extends BaseViewModel {
  DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
  final TextEditingController searchController = TextEditingController();
  List<AudioModel> audioList = [];
  List<ArticleModel> articleList = [];
  List<VideoModel> videoList = [];
  AudioService _audioService = AudioService();
  ArticleService _articleService = ArticleService();
  VideoService _videoService = VideoService();

  final ct.ContentType contentType;

  SearchViewModel(this.contentType);

  search() {
    getContent();
  }

  Future<void> getContent() async {
    if (searchController.text.isEmpty) return;
    setBusy(ViewState.Busy);
    switch (contentType) {
      case ct.ContentType.Audio:
        await _getAudioNetworkCall();

        break;
      case ct.ContentType.Video:
        await _getVideoNetworkCall();
        break;
      case ct.ContentType.Article:
        await _getArticleNetworkCall();
        break;
      default:
    }
    setBusy(ViewState.Idle);
  }

  _getAudioNetworkCall() async {
    audioList = await _audioService.searchAudio(searchController.text);
  }

  _getVideoNetworkCall() async {
    videoList = await _videoService.searchVideos(searchController.text);
  }

  _getArticleNetworkCall() async {
    articleList = await _articleService.searchArticles(searchController.text);
  }

  oNewtworkCall() async {
    audioList = await _audioService.searchAudio(searchController.text);
  }

  onOptionSelect(value, AudioModel audio) async {
    final String link =
        await _dynamicLinkService.createEventLink(audio.toContent());
    switch (value.toString().toLowerCase()) {
      case "share":
        Share.share(link);
        break;
      default:
    }
  }
}
