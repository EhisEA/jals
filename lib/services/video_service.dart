import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:jals/constants/app_urls.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/utils/locator.dart';

class VideoService extends ChangeNotifier {
  // ====================***Declarations**=============
  final Client _client = new Client();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

// =====================***Functions***==============
  Future<List<VideoModel>> getVideoList() async {
    try {
      Response response = await _client.get(
        "${AppUrl.VideosList}",
        headers: appHttpHeaders(),
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      print(decodedData["data"]);
      if (decodedData["status"] == "successful") {
        print("Success");
        List videos = decodedData["data"];
        return videos.map((e) => VideoModel.fromJson(e)).toList();
      } else {
        // Handle Error
        return [];
      }
    } catch (e) {
      print("The Errror was $e");
      return [];
    }
  }
}
