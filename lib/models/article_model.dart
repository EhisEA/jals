// To parse this JSON data, do
//
//     final VideoModel = VideoModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'article_model.g.dart';

ArticleModel videoModelFromJson(String str) =>
    ArticleModel.fromJson(json.decode(str));

String videoModelToJson(ArticleModel data) => json.encode(data.toJson());

@HiveType(typeId: 2)
class ArticleModel {
  ArticleModel({
    this.id,
    this.title,
    this.author,
    this.createdAt,
    this.price,
    this.postType,
    this.dataUrl,
    this.coverImage,
    this.isBookmarked,
    this.content,
    this.downloaded,
    this.downloadDate,
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
  bool isBookmarked;

  @HiveField(9)
  String content;

  @HiveField(10)
  bool downloaded;

  @HiveField(11)
  DateTime downloadDate;

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        createdAt: DateTime.parse(json["created_at"]),
        price: json["price"].toDouble(),
        postType: json["post_type"],
        dataUrl: json["data_url"],
        coverImage: json["cover_image"],
        isBookmarked: json["is_bookmarked"],
        content: json["content"],
        downloaded: json["downloaded"] ?? false,
        downloadDate: null,
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
        "is_bookmarked": isBookmarked,
        "content": content,
        "downloaded": downloaded,
        "downloadDate": downloadDate,
      };
}