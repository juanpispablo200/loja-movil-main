// To parse this JSON data, do
//
//     final commonResponse = commonResponseFromJson(jsonString);

import 'dart:convert';

CommonResponse commonResponseFromJson(String str) =>
    CommonResponse.fromJson(json.decode(str));

String commonResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  bool ok;
  String message;
  dynamic id;
  String code;

  CommonResponse({
    required this.ok,
    required this.message,
    required this.id,
    required this.code,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        ok: json["ok"],
        message: json["message"],
        id: json["id"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "id": id,
        "code": code,
      };
}
