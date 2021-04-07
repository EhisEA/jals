// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'comment_author.dart';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
    CommentModel({
        @required this.post,
        @required this.date,
        @required this.comment,
        @required this.commentAuthor,
    });

    String post;
    DateTime date;
    String comment;
    CommentAuthor commentAuthor;

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        post: json["post"],
        date: DateTime.parse(json["date"]),
        comment: json["comment"],
        commentAuthor: CommentAuthor.fromJson(json["comment_author"]),
    );

    Map<String, dynamic> toJson() => {
        "post": post,
        "date": date.toIso8601String(),
        "comment": comment,
        "comment_author": commentAuthor.toJson(),
    };
}

