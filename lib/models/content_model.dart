// To parse this JSON data, do
//
//     final contentModel = contentModelFromJson(jsonString);

import 'dart:convert';

import 'package:jals/enums/content_type.dart' as ct;
import 'package:jals/models/article_model.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/services/hive_database_service.dart';
import 'package:jals/utils/locator.dart';

import 'audio_model.dart';

ContentModel contentModelFromJson(String str) =>
    ContentModel().fromJson(json.decode(str));

String contentModelToJson(ContentModel data) => json.encode(data.toJson());

class ContentModel {
  ContentModel({
    this.id,
    this.title,
    this.author,
    this.createdAt,
    this.price,
    this.postType,
    this.dataUrl,
    this.coverImage,
    this.isPurchased,
    this.sermonId,
  });

  String id;
  String title;
  String author;
  DateTime createdAt;
  double price;
  ct.ContentType postType;
  String dataUrl;
  String coverImage;
  String sermonId;
  bool isPurchased;

  fromJson(Map json) {
    return ContentModel(
      id: json["id"],
      title: json["title"],
      author: json["author"],
      createdAt: DateTime.parse(json["created_at"]),
      price: double.parse(json["price"].toString()),
      postType: getContentType(json["post_type"]),
      dataUrl: json["data_url"],
      coverImage: json["cover_image"],
      isPurchased: json["is_purchased"],
      sermonId: json["sermon_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "created_at": createdAt.toIso8601String(),
        "price": price,
        "post_type": getContentTypeString(postType),
        "data_url": dataUrl,
        "cover_image": coverImage,
        "is_purchased": isPurchased,
        "sermon_id": sermonId,
      };

  toArticle() {
    HiveDatabaseService _hiveDatabaseService = locator<HiveDatabaseService>();
    return ArticleModel(
      author: author,
      coverImage: coverImage,
      createdAt: createdAt,
      title: title,
      id: id,
      price: price,
      postType: getContentTypeString(postType),
      isNews: postType == ct.ContentType.News,
      downloaded: _hiveDatabaseService.checkArticleDownloadStatus(id),
      content: _hiveDatabaseService.getSingleDownloadedArticleContent(id),
      isBookmarked: false,
    );
  }

  AudioModel toAudio() {
    // HiveDatabaseService _hiveDatabaseService= locator<HiveDatabaseService>();
    return AudioModel(
      author: author,
      coverImage: coverImage,
      createdAt: createdAt,
      title: title,
      id: id,
      price: price,
      postType: getContentTypeString(postType),
      // downloaded: _hiveDatabaseService.checkArticleDownloadStatus(id),
      dataUrl: dataUrl,
    );
  }

  tovideo() {
    // HiveDatabaseService _hiveDatabaseService= locator<HiveDatabaseService>();
    return VideoModel(
      author: author,
      coverImage: coverImage,
      createdAt: createdAt,
      title: title,
      id: id,
      price: price,
      postType: getContentTypeString(postType),
      // downloaded: _hiveDatabaseService.checkArticleDownloadStatus(id),
      dataUrl: dataUrl,
      isBookmarked: false,
    );
  }

  ct.ContentType getContentType(String postType) {
    switch (postType.toUpperCase()) {
      case "VI":
        return ct.ContentType.Video;
      case "AU":
        return ct.ContentType.Audio;

      case "AR":
        return ct.ContentType.Article;

      case "NE":
        return ct.ContentType.News;
      default:
        return null;
    }
  }

  String getContentTypeString(ct.ContentType contentType) {
    switch (contentType) {
      case ct.ContentType.Video:
        return "VI";
      case ct.ContentType.Audio:
        return "AU";

      case ct.ContentType.Article:
        return "AR";

      case ct.ContentType.News:
        return "NE";
      default:
        return null;
    }
  }
}
