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
  Future<List<VideoModel>> getVideoList() async {
    try {
      Response response = await _client.get(
        "${AppUrl.VideosList}",
        headers: httpHeaders(),
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      print(decodedData);
      if (decodedData["status"] == "successful") {
        List videos = decodedData["data"]["results"];
        return videos.map((e) => VideoModel.fromJson(e)).toList();
      } else {
        // Handle Error
        print("Error");
        return [];
      }
    } catch (e) {
      print("The Errror was $e");
      return [];
    }
  }

  Future<List<VideoModel>> getBookmarkedVideoList() async {
    try {
      Response response = await _client.get(
        "${AppUrl.BookmarkedVideos}",
        headers: httpHeaders(),
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      if (decodedData["status"] == "successful") {
        print("Success");
        List videos = decodedData["data"]["results"];
        return videos.map((e) => VideoModel.fromJson(e)).toList();
      } else {
        print("Error");
        // Handle Error
        return [];
      }
    } catch (e) {
      print("The Errror was $e");
      return [];
    }
  }

  Future<ApiResponse> addToBookmarks({@required String uid}) async {
    try {
      print("Loading;");
      Response response = await _client.get(
        "${AppUrl.addToBoomarks(uid: uid)}",
        headers: httpHeaders(),
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
        headers: httpHeaders(),
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
