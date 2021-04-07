import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jals/constants/app_urls.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/utils/network_utils.dart';

class AudioService {
  final NetworkConfig _networkConfig = NetworkConfig();
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

  Future<bool> createPlaylist(String playlistName) async {
    try {
      String url = AppUrl.Playlist;
      print(url);
      http.Response response = await http.post(
        url,
        headers: appHttpHeaders(),
        body: {
          "title":playlistName
        }
      );
      var result = json.decode(response.body);
      print(result);
     
      return _networkConfig.isResponseSuccessBool(response: result);
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return false;
    }
  }


  Future<bool>  deletePlaylist(String playlistId) async {
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

  Future<bool> removeArticleFromBookmark(String id) async {
    try {
      String url = AppUrl.ArticleList + id + "/remove_from_bookmarks/";
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

  Future<bool> addArticleToBookmark(String id) async {
    try {
      String url = AppUrl.ArticleList + id + "/add_to_bookmarks/";
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

  Future<List<ArticleModel>> getNews() async {
    try {
      List<ArticleModel> news;
      String url = AppUrl.NewsList;
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);
      news = result["data"]["results"]
          .map<ArticleModel>((element) => ArticleModel.fromJson(element))
          .toList();
      print(news.length);
      return news;
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return null;
    }
  }
}
