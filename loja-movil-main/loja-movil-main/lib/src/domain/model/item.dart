import 'dart:convert';

import 'package:loja_movil/src/domain/model/catalog.dart';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  int? id;
  String name;
  String code;
  String? description;
  String catalogCode;
  bool active;
  Catalog? catalog;

  Item({
    this.id,
    required this.name,
    required this.code,
    this.description,
    required this.catalogCode,
    required this.active,
    this.catalog,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        description: json["description"],
        catalogCode: json["catalogCode"],
        active: json["active"],
        catalog:
            json["catalog"] != null ? Catalog.fromJson(json["catalog"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "description": description,
        "catalogCode": catalogCode,
        "active": active,
        "catalog": catalog?.toJson(),
      };
}
