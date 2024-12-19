import 'dart:convert';
import 'package:loja_movil/src/domain/model/parish.dart';

ParishListResponse parishListResponseFromJson(String str) =>
    ParishListResponse.fromJson(json.decode(str));

String parishListResponseToJson(ParishListResponse data) =>
    json.encode(data.toJson());

class ParishListResponse {
  bool ok;
  String message;
  List<Parish> parishes;

  ParishListResponse({
    required this.ok,
    required this.message,
    required this.parishes,
  });

  factory ParishListResponse.fromJson(Map<String, dynamic> json) =>
      ParishListResponse(
        ok: json["ok"],
        message: json["message"],
        parishes:
            List<Parish>.from(json["parishes"].map((x) => Parish.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "parishes": List<dynamic>.from(parishes.map((x) => x.toJson())),
      };
}