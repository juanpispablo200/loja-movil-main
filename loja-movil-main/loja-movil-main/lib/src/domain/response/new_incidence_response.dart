// To parse this JSON data, do
//
//     final newIncidenceResponse = newIncidenceResponseFromJson(jsonString);

import 'dart:convert';

NewIncidenceResponse newIncidenceResponseFromJson(String str) =>
    NewIncidenceResponse.fromJson(json.decode(str));

String newIncidenceResponseToJson(NewIncidenceResponse data) =>
    json.encode(data.toJson());

class NewIncidenceResponse {
  bool ok;
  String message;
  dynamic id;
  String code;

  NewIncidenceResponse({
    required this.ok,
    required this.message,
    required this.id,
    required this.code,
  });

  factory NewIncidenceResponse.fromJson(Map<String, dynamic> json) =>
      NewIncidenceResponse(
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
