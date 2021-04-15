import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:jals/constants/app_urls.dart';
import 'package:jals/models/video_model.dart';

import '../enums/api_response.dart';

class VideoService extends ChangeNotifier {
  // ====================***Declarations**=============
  final Client _client = new Client();

// =====================***Functions***==============
  Future<VideoModel> getVideo(String videoId) async {
    try {
      String url = AppUrl.VideosList + videoId;
      Response response = await get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);

      return VideoModel.fromJson(result["data"]);
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return null;
    }
  }

  Future<List<VideoModel>> getVideoList() async {
    try {
      Response response = await _client.get(
        "${AppUrl.VideosList}",
        headers: appHttpHeaders(),
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      print(decodedData);
      if (decodedData["status"] == "successful") {
        List videos = decodedData["data"]["results"];
        return videos.map((e) => VideoModel.fromJson(e)).toList();
      } else {
        // Handle Error
        print("Error Occured");
        return null;
      }
    } catch (e) {
      print("The Errror was $e");
      return null;
    }
  }

  Future<List<VideoModel>> getBookmarkedVideoList() async {
    try {
      Response response = await _client.get(
        "${AppUrl.BookmarkedVideos}",
        headers: appHttpHeaders(),
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      if (decodedData["status"] == "successful") {
        print("Success");
        List videos = decodedData["data"]["results"];
        return videos.map((e) => VideoModel.fromJson(e)).toList();
      } else {
        print("Error");
        // Handle Error
        return null;
      }
    } catch (e) {
      print("The Errror was $e");
      return null;
    }
  }

  Future<ApiResponse> addToBookmarks({@required String uid}) async {
    try {
      print("Loading;");
      Response response = await _client.get(
        "${AppUrl.addToBoomarks(uid: uid)}",
        headers: appHttpHeaders(),
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      if (decodedData["status"] == "successful") {
        return ApiResponse.Success;
      } else {
        print("An error occured");
        return ApiResponse.Error;
      }
    } catch (e) {
      print(" The error was ==$e");
      return ApiResponse.Error;
    }
  }

  Future<ApiResponse> removeFromBookmarks({@required String uid}) async {
    try {
      print("Loading;");
      Response response = await _client.get(
        "${AppUrl.removeFromBookmarks(uid: uid)}",
        headers: appHttpHeaders(),
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      print(decodedData);
      if (decodedData["status"] == "successful") {
        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      print(" The error was ==$e");
      return ApiResponse.Error;
    }
  }
}
