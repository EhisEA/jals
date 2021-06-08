import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/services/hive_database_service.dart';
import 'package:jals/ui/audio/view_model/audio_download.dart';
import 'package:jals/ui/video/view_models/video_download_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  String progress = "";
  bool downloading = false;
  bool isDownloaded = false;

  Future<String> getVideoFilePath(String uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/videos/$uniqueFileName.mp4';

    return path;
  }

  Future<String> getAudioFilePath(String uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/audios/$uniqueFileName.mp3';

    return path;
  }

  deleteAllDownloads() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String audioPath = '${dir.path}/audios';
    String videoPath = '${dir.path}/videos';
    final Directory audioDirectory = Directory(audioPath);
    final Directory videoDirectory = Directory(videoPath);
    if (await audioDirectory.exists())
      audioDirectory.deleteSync(recursive: true);
    if (await videoDirectory.exists())
      videoDirectory.deleteSync(recursive: true);
  }
  // downloading logic is handled by this method

  Future<bool> downloadVideoFile(
      VideoModel video, Function(int, int) downloadingFunc) async {
    final HiveDatabaseService _hiveDatabaseService =
        locator<HiveDatabaseService>();
    try {
      String savePath = await getVideoFilePath(video.id);

      Dio dio = Dio();

      await dio.download(
        video.dataUrl,
        savePath,
        onReceiveProgress: (rcv, total) {
          _downloadingFunc(rcv, total);
          downloadingFunc(rcv, total);
        },
        deleteOnError: true,
      ).then((re) {
        //on download complete
        if (progress == '100') {
          video.dataUrl = savePath;
          video.downloadDate = DateTime.now();
          video.downloaded = true;
          _hiveDatabaseService.downloadVideo(video);
          locator<VideoDownloadViewModel>().getVideos();
          return true;
        }
        return false;
      }).catchError((onError) {
        print("error");
        print(onError);
        return false;
      });
      return false;
    } catch (e) {
      print("error");
      print(e);
      return false;
    }
  }

  Future<bool> downloadAudioFile(
      AudioModel audio, Function(int, int) downloadingFunc) async {
    final HiveDatabaseService _hiveDatabaseService =
        locator<HiveDatabaseService>();
    try {
      String savePath = await getAudioFilePath(audio.id);

      Dio dio = Dio();

      await dio.download(
        audio.dataUrl,
        savePath,
        onReceiveProgress: (rcv, total) {
          _downloadingFunc(rcv, total);
          downloadingFunc(rcv, total);
        },
        deleteOnError: true,
      ).then((re) {
        //on download complete
        if (progress == '100') {
          audio.dataUrl = savePath;
          audio.downloadDate = DateTime.now();
          audio.downloaded = true;
          _hiveDatabaseService.downloadAudio(audio);
          locator<AudioDownloadViewModel>().getAudios();
          return true;
        }
        return false;
      }).catchError((onError) {
        print("error");
        print(onError);
        return false;
      });
      return false;
    } catch (e) {
      print("error");
      print(e);
      return false;
    }
  }

  _downloadingFunc(int rcv, int total) {
    // print(
    //     'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');

    progress = ((rcv / total) * 100).toStringAsFixed(0);

    if (progress == '100') {
      isDownloaded = true;
    } else if (double.parse(progress) < 100) {}
  }
}
