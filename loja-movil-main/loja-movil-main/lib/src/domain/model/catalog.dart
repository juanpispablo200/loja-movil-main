import 'dart:convert';

Catalog catalogFromJson(String str) => Catalog.fromJson(json.decode(str));

String catalogToJson(Catalog data) => json.encode(data.toJson());

class Catalog {
  int id;
  String name;
  String code;
  String description;

  Catalog({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
  });

  factory Catalog.fromJson(Map<String, dynamic> json) => Catalog(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "description": description,
      };
}
