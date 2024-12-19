// To parse this JSON data, do
//
//     final assignIncidenceResponse = assignIncidenceResponseFromJson(jsonString);

import 'dart:convert';

import 'package:loja_movil/src/domain/response/incidences_response.dart';

UpdateIncidenceResponse updateIncidenceResponseFromJson(String str) =>
    UpdateIncidenceResponse.fromJson(json.decode(str));

String updateIncidenceResponseToJson(UpdateIncidenceResponse data) =>
    json.encode(data.toJson());

class UpdateIncidenceResponse {
  final int code;
  final String message;
  final bool status;
  final Incidence incidence;

  UpdateIncidenceResponse({
    required this.code,
    required this.message,
    required this.status,
    required this.incidence,
  });

  UpdateIncidenceResponse copyWith({
    int? code,
    String? message,
    bool? status,
    Incidence? incidence,
  }) =>
      UpdateIncidenceResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        status: status ?? this.status,
        incidence: incidence ?? this.incidence,
      );

  factory UpdateIncidenceResponse.fromJson(Map<String, dynamic> json) =>
      UpdateIncidenceResponse(
        code: json["code"],
        message: json["message"],
        status: json["status"],
        incidence: Incidence.fromJson(json["incidence"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "status": status,
        "incidence": incidence.toJson(),
      };
}

class UserAssign {
  final int id;
  final String login;

  UserAssign({
    required this.id,
    required this.login,
  });

  UserAssign copyWith({
    int? id,
    String? login,
  }) =>
      UserAssign(
        id: id ?? this.id,
        login: login ?? this.login,
      );

  factory UserAssign.fromJson(Map<String, dynamic> json) => UserAssign(
        id: json["id"],
        login: json["login"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "login": login,
      };
}
