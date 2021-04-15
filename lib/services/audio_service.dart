import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jals/constants/app_urls.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/utils/network_utils.dart';

class AudioService {
  final NetworkConfig _networkConfig = NetworkConfig();
  Future<AudioModel> getAudio(String audioId) async {
    try {
      String url = AppUrl.AudioList + audioId;
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);

      return AudioModel.fromJson(result["data"]);
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return null;
    }
  }

  Future<List<AudioModel>> getAudioList() async {
    try {
      List<AudioModel> audios;
      String url = AppUrl.AudioList;
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);
      audios = result["data"]["results"]
          .map<AudioModel>((element) => AudioModel.fromJson(element))
          .toList();
      return audios;
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return null;
    }
  }

  Future<bool> addAudioToBookmark(String id) async {
    try {
      String url = AppUrl.ArticleList + id + "/add_to_bookmarks/";
      url = AppUrl.addTo(AppUrl.AudioList, [id, "/add_to_bookmarks/"]);
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);
      return _networkConfig.isResponseSuccess(
        response: result,
        errorTitle: "Error",
      );
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return false;
    }
  }

  Future<bool> createPlaylist(String playlistName) async {
    try {
      String url = AppUrl.Playlist;
      print(url);
      http.Response response = await http
          .post(url, headers: appHttpHeaders(), body: {"title": playlistName});
      var result = json.decode(response.body);
      print(result);

      return _networkConfig.isResponseSuccessBool(response: result);
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return false;
    }
  }

  Future<bool> deletePlaylist(String playlistId) async {
    try {
      String url = AppUrl.playlistWithId(playlistId);

      print("=====1");
      http.Response response = await http.delete(
        url,
        headers: appHttpHeaders(),
      );
      print("=====1");
      var result = json.decode(response.body);
      print(result);

      return _networkConfig.isResponseSuccessBool(response: result);
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return false;
    }
  }

  Future<List<PlayListModel>> getPlaylist() async {
    try {
      List<PlayListModel> playlists;
      String url = AppUrl.Playlist;
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);
      playlists = result["data"]["results"]
          .map<PlayListModel>((element) => PlayListModel.fromJson(element))
          .toList();
      return playlists;
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return null;
    }
  }

  Future<ApiResponse> addAudioToPlaylist(
      String playlistId, String audioId) async {
    try {
      var body = {
        "tracks": [
          audioId,
        ]
      };
      String url = AppUrl.Playlist + playlistId + "/add_tracks/";
      http.Response response = await http.post(
        url,
        headers: appJsonHttpHeaders(),
        body: json.encode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      print(e);
      print("error");
      return ApiResponse.Error;
    }
  }

  Future<ApiResponse> removeAudioFromPlaylist(
      String playlistId, String audioId) async {
    try {
      var body = {
        "tracks": [
          audioId,
        ]
      };
      String url = AppUrl.Playlist + playlistId + "/remove_tracks/";
      http.Response response = await http.post(
        url,
        headers: appJsonHttpHeaders(),
        body: json.encode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      print(e);
      print("error");
      return ApiResponse.Error;
    }
  }

  Future<bool> removeAudioFromBookmark(String id) async {
    try {
      String url = AppUrl.AudioList + id + "/remove_from_bookmarks/";
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);
      return _networkConfig.isResponseSuccess(
        response: result,
        errorTitle: "Error",
      );
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return false;
    }
  }
}
