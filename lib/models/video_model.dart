// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

import 'content_model.dart';

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

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
  });

  String id;
  String title;
  String author;
  DateTime createdAt;
  double price;
  String postType;
  String dataUrl;
  String coverImage;
  bool isBookmarked;
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
