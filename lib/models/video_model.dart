// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

import 'content_model.dart';

part 'video_model.g.dart';

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

@HiveType(typeId: 3)
class VideoModel {
  VideoModel({
    this.id,
    this.title,
    this.author,
    this.createdAt,
    this.price,
    this.postType,
    this.dataUrl,
    this.coverImage,
    this.isBookmarked,
    this.isPurchased,
    this.downloadDate,
    this.downloaded,
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
  DateTime downloadDate;

  @HiveField(5)
  double price;

  @HiveField(6)
  String postType;

  @HiveField(7)
  String dataUrl;

  @HiveField(8)
  String coverImage;

  @HiveField(9)
  bool downloaded;

  @HiveField(10)
  bool isBookmarked;

  @HiveField(11)
  bool isPurchased;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        createdAt: DateTime.parse(json["created_at"]),
        price: double.parse(json["price"].toString()),
        postType: json["post_type"],
        dataUrl: json["data_url"],
        coverImage: json["cover_image"],
        isBookmarked: json["is_bookmarked"],
        isPurchased: json["is_purchased"],
        downloaded: json["downloaded"],
        downloadDate: json["downloadDate"],
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
        "is_purchased": isPurchased,
        "downloadDate": downloadDate,
        "downloaded": downloaded,
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
