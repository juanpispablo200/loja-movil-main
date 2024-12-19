// To parse this JSON data, do
//
//     final localityResponse = localityResponseFromJson(jsonString);

import 'dart:convert';

import 'package:loja_movil/src/domain/model/locality.dart';

LocalityResponse localityResponseFromJson(String str) =>
    LocalityResponse.fromJson(json.decode(str));

String localityResponseToJson(LocalityResponse data) =>
    json.encode(data.toJson());

class LocalityResponse {
  bool ok;
  String message;
  Locality? fullLocality;

  LocalityResponse({
    required this.ok,
    required this.message,
    this.fullLocality,
  });

  factory LocalityResponse.fromJson(Map<String, dynamic> json) =>
      LocalityResponse(
        ok: json["ok"],
        message: json["message"],
        fullLocality: json["fullLocality"] != null
            ? Locality.fromJson(json["fullLocality"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "fullLocality": fullLocality?.toJson(),
      };
}

