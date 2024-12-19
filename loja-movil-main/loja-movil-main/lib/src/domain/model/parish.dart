import 'dart:convert';
import 'package:loja_movil/src/domain/model/canton.dart';
import 'package:loja_movil/src/domain/model/item.dart';

Parish parishFromJson(String str) => Parish.fromJson(json.decode(str));

String parishToJson(Parish data) => json.encode(data.toJson());

class Parish {
  int id;
  String code;
  String name;
  Item? parishType;
  Canton? canton;

  Parish({
    required this.id,
    required this.code,
    required this.name,
    this.parishType,
    this.canton,
  });

  factory Parish.fromJson(Map<String, dynamic> json) => Parish(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        parishType: json["parishType"] != null
            ? Item.fromJson(json["parishType"])
            : null,
        canton: json["canton"] != null ? Canton.fromJson(json["canton"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "parishType": parishType?.toJson(),
        "canton": canton?.toJson(),
      };
}
