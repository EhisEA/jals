// To parse this JSON data, do
//
//     final contentModel = contentModelFromJson(jsonString);

import 'dart:convert';

StoreModel shopModelfromJson(String str) =>
    StoreModel.fromJson(json.decode(str));

String shopModelToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
  StoreModel({
    this.id,
    this.title,
    this.author,
    this.createdAt,
    this.price,
    this.postType,
    this.isPurchased,
    this.dataUrl,
    this.coverImage,
    this.sermonId,
  });

  String id;
  String title;
  String author;
  DateTime createdAt;
  int price;
  String postType;
  bool isPurchased;
  String dataUrl;
  String coverImage;
  dynamic sermonId;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        createdAt: DateTime.parse(json["created_at"]),
        price: json["price"],
        postType: json["post_type"],
        isPurchased: json["is_purchased"],
        dataUrl: json["data_url"],
        coverImage: json["cover_image"],
        sermonId: json["sermon_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "created_at": createdAt.toIso8601String(),
        "price": price,
        "post_type": postType,
        "is_purchased": isPurchased,
        "data_url": dataUrl,
        "cover_image": coverImage,
        "sermon_id": sermonId,
      };
}
