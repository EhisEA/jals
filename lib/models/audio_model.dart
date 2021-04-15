// To parse this JSON data, do
//
//     final VideoModel = VideoModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:jals/models/content_model.dart';
// part 'article_model.g.dart';

AudioModel videoModelFromJson(String str) =>
    AudioModel.fromJson(json.decode(str));

String videoModelToJson(AudioModel data) => json.encode(data.toJson());

@HiveType(typeId: 2)
class AudioModel {
  AudioModel({
    this.id,
    this.title,
    this.author,
    this.createdAt,
    this.price,
    this.postType,
    this.dataUrl,
    this.coverImage,
    this.downloaded,
    this.downloadDate,
    this.isBookmarked,
    this.isPurchased,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String author;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  double price;

  @HiveField(5)
  String postType;

  @HiveField(6)
  String dataUrl;

  @HiveField(7)
  String coverImage;

  @HiveField(8)
  bool downloaded;

  @HiveField(9)
  DateTime downloadDate;

  @HiveField(10)
  bool isBookmarked;

  @HiveField(11)
  bool isPurchased;

  factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        createdAt: DateTime.parse(json["created_at"]),
        price: json["price"].toDouble(),
        postType: json["post_type"],
        dataUrl: json["data_url"],
        coverImage: json["cover_image"],
        downloaded: json["downloaded"] ?? false,
        downloadDate: null,
        isBookmarked: json["is_bookmarked"],
        isPurchased: json["is_purchased"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "created_at": createdAt.toIso8601String(),
        "price": price,
        "post_type": postType,
        "data_url": dataUrl,
        "cover_image": coverImage,
        "downloaded": downloaded,
        "downloadDate": downloadDate,
        "is_purchased": isPurchased,
        "is_bookmarked": isBookmarked,
      };

  toContent() {
    // HiveDatabaseService _hiveDatabaseService= locator<HiveDatabaseService>();
    return ContentModel(
      author: author,
      coverImage: coverImage,
      createdAt: createdAt,
      title: title,
      id: id,
      price: price,
      postType: ContentModel().getContentType(postType),
      isPurchased: isPurchased,
      // downloaded: _hiveDatabaseService.checkArticleDownloadStatus(id),
      dataUrl: dataUrl,
    );
  }
}
