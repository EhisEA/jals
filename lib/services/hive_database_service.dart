import 'dart:io';

import 'package:hive/hive.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/video_model.dart';

class HiveDatabaseService {
  Box<ArticleModel> _articleDownloads;
  Box<VideoModel> _videoDownloads;
  Box<AudioModel> _audioDownloads;

  HiveDatabaseService() {
    Hive.registerAdapter(ArticleModelAdapter());
    Hive.registerAdapter(VideoModelAdapter());
    Hive.registerAdapter(AudioModelAdapter());
  }

  void openBoxes() async {
    _articleDownloads = await Hive.openBox<ArticleModel>('article_downloads');
    _videoDownloads = await Hive.openBox<VideoModel>('video_downloads');
    _audioDownloads = await Hive.openBox<AudioModel>('audio_downloads');

    // _articleDownloads.clear();
    // articleDownloads = await Hive.openBox<ContentModel>('video_downloads');
    // articleDownloads = await Hive.openBox<ContentModel>('audio_downloads');
  }

  deleteAllDB() {
    _articleDownloads.clear();
    _videoDownloads.clear();
    _audioDownloads.clear();
  }

  //]]]]]]]]]=============================
  //]]]]]]]]]=============================
  //                Article section
  //]]]]]]]]]=============================
  //]]]]]]]]]=============================

  //for downloading article
  void downloadArticle(ArticleModel article) {
    article.downloaded = true;
    article.downloadDate = DateTime.now();
    _articleDownloads.put(article.id, article);
  }

  // fro deleting an article
  void deleteArticle(ArticleModel article) {
    _articleDownloads.delete(article.id);
  }

  // for fetching all downloaded article
  List<ArticleModel> getDownloadedArticle() {
    return _articleDownloads.values.toList();
  }

  //for checking if an article has been downloaded
  bool checkArticleDownloadStatus(String id) {
    // if (_articleDownloads == null) return false;
    return _articleDownloads.containsKey(id);
  }

  // for getting the section segment of a single article
  String getSingleDownloadedArticleContent(String id) {
    // if (_articleDownloads == null) return false;
    return _articleDownloads.get(id) == null
        ? null
        : _articleDownloads.get(id).content;
  }

  //]]]]]]]]]=============================
  //]]]]]]]]]=============================
  //                Video section
  //]]]]]]]]]=============================
  //]]]]]]]]]=============================
  void downloadVideo(VideoModel video) {
    video.downloaded = true;
    video.downloadDate = DateTime.now();
    _videoDownloads.put(video.id, video);
  }

  void deleteVideo(VideoModel video) {
    _videoDownloads.delete(video.id);
  }

  List<VideoModel> getDownloadedVideos() {
    return _videoDownloads.values.toList();
  }

  Future<bool> checkVideoDownloadStatus(String id) async {
    if (_videoDownloads.containsKey(id)) {
      VideoModel video = getSingleVideo(id);
      if (await File(video.dataUrl).exists()) {
        //if video is downloaded and file exist
        return true;
      } else {
        //if video is downloaded and file does not exist

        _videoDownloads.delete(video.id);
        return false;
      }
    }
    return false;
  }

  VideoModel getSingleVideo(String id) {
    return _videoDownloads.get(id);
  }

  //]]]]]]]]]=============================
  //]]]]]]]]]=============================
  //                Audio section
  //]]]]]]]]]=============================
  //]]]]]]]]]=============================
  void downloadAudio(AudioModel audio) {
    audio.downloaded = true;
    audio.downloadDate = DateTime.now();
    _audioDownloads.put(audio.id, audio);
  }

  void deleteAudio(AudioModel audio) {
    _audioDownloads.delete(audio.id);
  }

  List<AudioModel> getDownloadedAudios() {
    return _audioDownloads.values.toList();
  }

  Future<bool> checkAudioDownloadStatus(String id) async {
    if (_audioDownloads.containsKey(id)) {
      AudioModel audio = getSingleAudio(id);
      if (await File(audio.dataUrl).exists()) {
        //if video is downloaded and file exist
        return true;
      } else {
        //if video is downloaded and file does not exist

        _audioDownloads.delete(audio.id);
        return false;
      }
    }
    return false;
  }

  AudioModel getSingleAudio(String id) {
    return _audioDownloads.get(id);
  }
}
