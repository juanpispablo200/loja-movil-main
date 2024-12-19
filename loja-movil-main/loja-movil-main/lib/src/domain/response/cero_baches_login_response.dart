// To parse this JSON data, do
//
//     final CeroBachesLoginResponse = CeroBachesLoginResponseFromJson(jsonString);

import 'dart:convert';

CeroBachesLoginResponse ceroBachesLoginResponseFromJson(String str) =>
    CeroBachesLoginResponse.fromJson(json.decode(str));

String ceroBachesLoginResponseToJson(CeroBachesLoginResponse data) => json.encode(data.toJson());

class CeroBachesLoginResponse {
  final String idToken;

  CeroBachesLoginResponse({
    required this.idToken,
  });

  CeroBachesLoginResponse copyWith({
    String? idToken,
  }) =>
      CeroBachesLoginResponse(
        idToken: idToken ?? this.idToken,
      );

  factory CeroBachesLoginResponse.fromJson(Map<String, dynamic> json) => CeroBachesLoginResponse(
        idToken: json["id_token"],
      );

  Map<String, dynamic> toJson() => {
        "id_token": idToken,
      };
}
