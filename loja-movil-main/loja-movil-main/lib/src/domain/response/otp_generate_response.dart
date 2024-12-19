// To parse this JSON data, do
//
//     final otpGenerateResponse = otpGenerateResponseFromJson(jsonString);

import 'dart:convert';

OtpGenerateResponse otpGenerateResponseFromJson(String str) =>
    OtpGenerateResponse.fromJson(json.decode(str));

String otpGenerateResponseToJson(OtpGenerateResponse data) =>
    json.encode(data.toJson());

class OtpGenerateResponse {
  final int code;
  final String message;
  final bool status;
  final Otp otp;

  OtpGenerateResponse({
    required this.code,
    required this.message,
    required this.status,
    required this.otp,
  });

  OtpGenerateResponse copyWith({
    int? code,
    String? message,
    bool? status,
    Otp? otp,
  }) =>
      OtpGenerateResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        status: status ?? this.status,
        otp: otp ?? this.otp,
      );

  factory OtpGenerateResponse.fromJson(Map<String, dynamic> json) =>
      OtpGenerateResponse(
        code: json["code"],
        message: json["message"],
        status: json["status"],
        otp: Otp.fromJson(json["otp"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "status": status,
        "otp": otp.toJson(),
      };
}

class Otp {
  final int id;
  final int code;
  final String email;
  final DateTime validUntil;
  final bool isValid;

  Otp({
    required this.id,
    required this.code,
    required this.email,
    required this.validUntil,
    required this.isValid,
  });

  Otp copyWith({
    int? id,
    int? code,
    String? email,
    DateTime? validUntil,
    bool? isValid,
  }) =>
      Otp(
        id: id ?? this.id,
        code: code ?? this.code,
        email: email ?? this.email,
        validUntil: validUntil ?? this.validUntil,
        isValid: isValid ?? this.isValid,
      );

  factory Otp.fromJson(Map<String, dynamic> json) => Otp(
        id: json["id"],
        code: json["code"],
        email: json["email"],
        validUntil: DateTime.parse(json["validUntil"]),
        isValid: json["isValid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "email": email,
        "validUntil": validUntil.toIso8601String(),
        "isValid": isValid,
      };
}
