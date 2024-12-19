import 'dart:convert';

import 'package:loja_movil/src/domain/model/item.dart';

ItemsResponse itemsResponseFromJson(String str) =>
    ItemsResponse.fromJson(json.decode(str));

String itemsResponseToJson(ItemsResponse data) => json.encode(data.toJson());

class ItemsResponse {
  bool ok;
  String message;
  List<Item> items;

  ItemsResponse({
    required this.ok,
    required this.message,
    required this.items,
  });

  factory ItemsResponse.fromJson(Map<String, dynamic> json) => ItemsResponse(
        ok: json["ok"],
        message: json["message"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
