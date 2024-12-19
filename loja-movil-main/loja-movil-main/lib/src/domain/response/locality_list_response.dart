import 'dart:convert';
import 'package:loja_movil/src/domain/model/locality.dart';

LocalityListResponse localityListResponseFromJson(String str) =>
    LocalityListResponse.fromJson(json.decode(str));

String localityListResponseToJson(LocalityListResponse data) =>
    json.encode(data.toJson());

class LocalityListResponse {
  bool ok;
  String message;
  List<Locality> fullLocalities;

  LocalityListResponse({
    required this.ok,
    required this.message,
    required this.fullLocalities,
  });

  factory LocalityListResponse.fromJson(Map<String, dynamic> json) =>
      LocalityListResponse(
        ok: json["ok"],
        message: json["message"],
        fullLocalities: List<Locality>.from(
            json["fullLocalities"].map((x) => Locality.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "fullLocalities":
            List<dynamic>.from(fullLocalities.map((x) => x.toJson())),
      };
}