import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jals/constants/app_urls.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/utils/network_utils.dart';

class ArticleService {
  final NetworkConfig _networkConfig = NetworkConfig();
  Future<ArticleModel> getArticle(String id) async {
    try {
      String url = AppUrl.ArticleList + id;
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      return ArticleModel.fromJson(result["data"]);
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return null;
    }
  }

  Future<List<ArticleModel>> getArticles() async {
    try {
      List<ArticleModel> articles;
      String url = AppUrl.ArticleListRandom;
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);
      articles = result["data"]
          .map<ArticleModel>((element) => ArticleModel.fromJson(element))
          .toList();
      return articles;
    } catch (e) {
      debugPrint("====error=====222");
      print(e);
      return null;
    }
  }

  Future<List<ArticleModel>> getArticlesList() async {
    try {
      List<ArticleModel> articles;
      String url = AppUrl.ArticleList;
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);
      articles = result["data"]
          .map<ArticleModel>((element) => ArticleModel.fromJson(element))
          .toList();
      return articles;
    } catch (e) {
      debugPrint("====error=====222");
      print(e);
      return null;
    }
  }

  Future<List<ArticleModel>> getTrendingArticles() async {
    try {
      List<ArticleModel> articles;
      String url = AppUrl.TrendingList;
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);
      articles = result["data"]["results"]
          .map<ArticleModel>((element) => ArticleModel.fromJson(element))
          .toList();
      return articles;
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return null;
    }
  }

  Future<List<ArticleModel>> searchArticles(String query) async {
    try {
      List<ArticleModel> articles;
      String url = AppUrl.searchArticles(query);
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);
      articles = result["data"]["results"]
          .map<ArticleModel>((element) => ArticleModel.fromJson(element))
          .toList();
      return articles;
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return null;
    }
  }

  Future<List<ArticleModel>> getBookmakedArticles() async {
    try {
      List<ArticleModel> articles;
      String url = AppUrl.ArticleList + "get_bookmarks";
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);
      articles = result["data"]["results"]
          .map<ArticleModel>((element) => ArticleModel.fromJson(element))
          .toList();
      print(articles.length);
      return articles;
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return null;
    }
  }

  Future<ArticleModel> getNewsDetails(String id) async {
    try {
      ArticleModel article;
      String url = AppUrl.NewsList + id;
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);
      article = ArticleModel.fromJson(result["data"]);
      print(article.isBookmarked);
      return article;
    } catch (e) {
      debugPrint("====error=====");
      print(e);
      return null;
    }
  }

  Future<ArticleModel> getArticleDetails(String id) async {
    try {
      ArticleModel article;
      String url = AppUrl.ArticleList + id;
      http.Response response = await http.get(
        url,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);
      article = ArticleModel.fromJson(result["data"]);
      print(article.isBookmarked);
      return article;
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
      url = AppUrl.addTo(AppUrl.ArticleList, [id, "/add_to_bookmarks/"]);
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
