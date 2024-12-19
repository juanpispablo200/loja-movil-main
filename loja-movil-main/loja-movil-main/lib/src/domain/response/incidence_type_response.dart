// To parse this JSON data, do
//
//     final incidenceTypeResponse = incidenceTypeResponseFromJson(jsonString);

import 'dart:convert';

List<IncidenceTypeResponse> incidenceTypesResponseFromJson(String str) =>
    List<IncidenceTypeResponse>.from(
        json.decode(str).map((x) => IncidenceTypeResponse.fromJson(x)));

String incidencesTypesResponseToJson(List<IncidenceTypeResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

IncidenceTypeResponse incidenceTypeResponseFromJson(String str) =>
    IncidenceTypeResponse.fromJson(json.decode(str));

String incidencesTypeResponseToJson(IncidenceTypeResponse data) =>
    json.encode(data.toJson());

class IncidenceTypeResponse {
  bool ok;
  String message;
  List<IncidenceType> types;

  IncidenceTypeResponse({
    required this.ok,
    required this.message,
    required this.types,
  });

  factory IncidenceTypeResponse.fromJson(Map<String, dynamic> json) =>
      IncidenceTypeResponse(
        ok: json["ok"],
        message: json["message"],
        types: List<IncidenceType>.from(json["types"].map((x) => IncidenceType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
      };
}

class IncidenceType {
  int id;
  String name;
  String code;
  String? department;
  String? description;
  bool? showToUser;
  String? icon;
  String? color;
  bool isActive;

  IncidenceType({
    required this.id,
    required this.name,
    required this.code,
    this.department,
    this.description,
    this.showToUser,
    this.icon,
    this.color,
    required this.isActive,
  });

  factory IncidenceType.fromJson(Map<String, dynamic> json) => IncidenceType(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        department: json["department"] ?? "",
        description: json["description"] ?? "",
        showToUser: json["showToUser"] ?? false,
        icon: json["icon"] ?? "",
        color: json["color"] ?? "",
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "department": department,
        "description": description,
        "showToUser": showToUser,
        "icon": icon,
        "color": color,
        "isActive": isActive,
      };
}
