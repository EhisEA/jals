
import 'package:flutter/material.dart';

class CommentAuthor {
    CommentAuthor({
        @required this.fullName,
        @required this.avatarThumbnail,
    });

    String fullName;
    String avatarThumbnail;

    factory CommentAuthor.fromJson(Map<String, dynamic> json) => CommentAuthor(
        fullName: json["full_name"],
        avatarThumbnail: json["avatar_thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "avatar_thumbnail": avatarThumbnail,
    };
}