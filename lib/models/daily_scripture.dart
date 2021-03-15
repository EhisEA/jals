// To parse this JSON data, do
//
//     final dailyScriptureModel = dailyScriptureModelFromJson(jsonString);

import 'dart:convert';

DailyScriptureModel dailyScriptureModelFromJson(String str) =>
    DailyScriptureModel.fromJson(json.decode(str));

String dailyScriptureModelToJson(DailyScriptureModel data) =>
    json.encode(data.toJson());

class DailyScriptureModel {
  DailyScriptureModel({
    this.location,
    this.content,
    this.scriptureDate,
  });

  String location;
  String content;
  DateTime scriptureDate;

  factory DailyScriptureModel.fromJson(Map<String, dynamic> json) =>
      DailyScriptureModel(
        location: json["location"],
        content: json["content"],
        scriptureDate: DateTime.parse(json["scripture_date"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "content": content,
        "scripture_date":
            "${scriptureDate.year.toString().padLeft(4, '0')}-${scriptureDate.month.toString().padLeft(2, '0')}-${scriptureDate.day.toString().padLeft(2, '0')}",
      };
}
