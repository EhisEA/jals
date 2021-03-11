// To parse this JSON data, do
//
//     final VideoModel = VideoModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'content_model.g.dart';

ContentModel videoModelFromJson(String str) =>
    ContentModel.fromJson(json.decode(str));

String videoModelToJson(ContentModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
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
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String author;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  int price;

  @HiveField(5)
  String postType;

  @HiveField(6)
  String dataUrl;

  @HiveField(7)
  String coverImage;

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        createdAt: DateTime.parse(json["created_at"]),
        price: json["price"],
        postType: json["post_type"],
        dataUrl: json["data_url"],
        coverImage: json["cover_image"],
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
      };
}
