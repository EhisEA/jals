import 'package:jals/models/audio_model.dart';

class PlayListModel {
  final String title;
  int count;
  final String id;
  final DateTime dateUpdated;
  final List<AudioModel> tracks;

  PlayListModel({
    this.title,
    this.count,
    this.id,
    this.dateUpdated,
    this.tracks,
  });

  factory PlayListModel.fromJson(Map<String, dynamic> json) {
    return PlayListModel(
        title: json["title"],
        count: json["count"],
        id: json["id"],
        dateUpdated: DateTime.parse(json["date_updated"]),
        tracks: List<AudioModel>.from(
            json["tracks"].map((audio) => AudioModel.fromJson(audio))));
  }
}
