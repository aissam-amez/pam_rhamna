// To parse this JSON data, do
//
//     final content = contentFromJson(jsonString);

import 'dart:convert';
import 'package:rhamna_pam/apis/routes.dart';

List<Content> contentFromJson(String str) =>
    List<Content>.from(json.decode(str).map((x) => Content.fromJson(x)));

String contentToJson(List<Content> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Content {
  Content({
    required this.name,
    required this.id,
    required this.profileId,
    required this.title,
    required this.content,
    required this.file,
    required this.type,
    required this.dateCreated,
  });

  String name;
  int id;
  int profileId;
  String title;
  String content;
  String file;
  String type;
  DateTime dateCreated;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        name: json["name"],
        id: json["id"],
        profileId: json["profile_id"],
        title: json["title"],
        content: json["content"],
        file: BASE + '/' + json["file"],
        type: json["type"],
        dateCreated: DateTime.parse(json["date_created"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "profile_id": profileId,
        "title": title,
        "content": content,
        "file": file,
        "type": type,
        "date_created": dateCreated.toIso8601String(),
      };
}
