// To parse this JSON data, do
//
//     final VideoModel = VideoModelFromJson(jsonString);

import 'dart:convert';

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
    // ignore: non_constant_identifier_names
    this.is_bookmarked = false,
  });

  int id;
  String title;
  String author;
  DateTime createdAt;
  int price;
  String postType;
  String dataUrl;
  String coverImage;
  // ignore: non_constant_identifier_names
  bool is_bookmarked;
  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        createdAt: DateTime.parse(json["created_at"]),
        price: json["price"],
        postType: json["post_type"],
        dataUrl: json["data_url"],
        coverImage: json["cover_image"],
        is_bookmarked: json["is_bookmarked"],
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
        "is_bookmarked": false,
      };
}
