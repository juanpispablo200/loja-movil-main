// To parse this JSON data, do
//
//     final otpValidateResponse = otpValidateResponseFromJson(jsonString);

import 'dart:convert';

OtpValidateResponse otpValidateResponseFromJson(String str) =>
    OtpValidateResponse.fromJson(json.decode(str));

String otpValidateResponseToJson(OtpValidateResponse data) =>
    json.encode(data.toJson());

class OtpValidateResponse {
  final int code;
  final String message;
  final bool status;

  OtpValidateResponse({
    required this.code,
    required this.message,
    required this.status,
  });

  OtpValidateResponse copyWith({
    int? code,
    String? message,
    bool? status,
  }) =>
      OtpValidateResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        status: status ?? this.status,
      );

  factory OtpValidateResponse.fromJson(Map<String, dynamic> json) =>
      OtpValidateResponse(
        code: json["code"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "status": status,
      };
}
