// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

List<News> newsFromJson(String str) =>
    List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
  final String url;
  final String photo;
  final String title;
  final String modified;

  News({
    required this.url,
    required this.photo,
    required this.title,
    required this.modified,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        url: json["url"],
        photo: json["photo"],
        title: json["title"],
        modified: json["modified"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "photo": photo,
        "title": title,
        "modified": modified,
      };
}
