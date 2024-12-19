// To parse this JSON data, do
//
//     final incidenceResponse = incidenceResponseFromJson(jsonString);

import 'dart:convert';

import 'package:loja_movil/src/domain/response/incidence_type_response.dart';

IncidenceResponse incidenceResponseFromJson(String str) =>
    IncidenceResponse.fromJson(json.decode(str));

String incidenceResponseToJson(IncidenceResponse data) =>
    json.encode(data.toJson());

class IncidenceResponse {
  bool ok;
  String message;
  List<Incidence> incidences;

  IncidenceResponse({
    required this.ok,
    required this.message,
    required this.incidences,
  });

  factory IncidenceResponse.fromJson(Map<String, dynamic> json) =>
      IncidenceResponse(
        ok: json["ok"],
        message: json["message"],
        incidences: List<Incidence>.from(
            json["incidences"].map((x) => Incidence.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "incidences": List<dynamic>.from(incidences.map((x) => x.toJson())),
      };
}

class Incidence {
  int id;
  DateTime? reportedDate;
  String? photo;
  String? photoContentType;
  double longitude;
  double latitude;
  String description;
  String urlImage;
  DateTime? attentionDate;
  IIncidenceStatus status;
  IncidenceType incidenceType;
  IncidenceUser user;

  Incidence({
    required this.id,
    required this.reportedDate,
    this.photo,
    this.photoContentType,
    required this.longitude,
    required this.latitude,
    required this.description,
    required this.urlImage,
    this.attentionDate,
    required this.status,
    required this.incidenceType,
    required this.user,
  });

  factory Incidence.fromJson(Map<String, dynamic> json) => Incidence(
        id: json["id"],
        reportedDate: json["reportedDate"] == null
            ? null
            : DateTime.parse(json["reportedDate"]),
        photo: json["photo"],
        photoContentType: json["photoContentType"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        description: json["description"],
        urlImage: json["urlImage"],
        attentionDate: json["attentionDate"] == null
            ? null
            : DateTime.parse(json["attentionDate"]),
        status: IIncidenceStatus.fromJson(json["status"]),
        incidenceType: IncidenceType.fromJson(json["incidenceType"]),
        user: IncidenceUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reportedDate": reportedDate?.toIso8601String(),
        "photo": photo,
        "photoContentType": photoContentType,
        "longitude": longitude,
        "latitude": latitude,
        "description": description,
        "urlImage": urlImage,
        "attentionDate": attentionDate?.toIso8601String(),
        "status": status.toJson(),
        "incidenceType": incidenceType.toJson(),
        "user": user.toJson(),
      };
}

class IIncidenceStatus {
  int id;
  String name;
  String code;
  String description;
  bool? showToUser;
  bool? showToEmployee;
  String? icon;
  String? color;
  bool isActive;

  IIncidenceStatus({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    this.showToUser,
    this.showToEmployee,
    this.icon,
    this.color,
    required this.isActive,
  });

  factory IIncidenceStatus.fromJson(Map<String, dynamic> json) =>
      IIncidenceStatus(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        description: json["description"],
        showToUser: json["showToUser"],
        showToEmployee: json["showToEmployee"] ?? false,
        icon: json["icon"] ?? '',
        color: json["color"] ?? '',
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "description": description,
        "showToUser": showToUser,
        "showToEmployee": showToEmployee,
        "icon": icon,
        "color": color,
        "isActive": isActive,
      };
}

class IncidenceUser {
  dynamic id;
  dynamic login;

  IncidenceUser({
    this.id,
    this.login,
  });

  factory IncidenceUser.fromJson(Map<String, dynamic> json) => IncidenceUser(
        id: json["id"],
        login: json["login"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "login": login,
      };
}
