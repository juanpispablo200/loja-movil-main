// To parse this JSON data, do
//
//     final departmentResponse = departmentResponseFromJson(jsonString);

import 'dart:convert';

List<DepartmentResponse> departmentsResponseFromJson(String str) =>
    List<DepartmentResponse>.from(
        json.decode(str).map((x) => DepartmentResponse.fromJson(x)));

String departmentsResponseToJson(List<DepartmentResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

DepartmentResponse departmentResponseFromJson(String str) =>
    DepartmentResponse.fromJson(json.decode(str));

String departmentResponseToJson(DepartmentResponse data) =>
    json.encode(data.toJson());

class DepartmentResponse {
  final int id;
  final String name;
  final String code;
  final String description;
  final List<DepartmentUser> users;

  DepartmentResponse({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.users,
  });

  DepartmentResponse copyWith({
    int? id,
    String? name,
    String? code,
    String? description,
    List<DepartmentUser>? users,
  }) =>
      DepartmentResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        description: description ?? this.description,
        users: users ?? this.users,
      );

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) =>
      DepartmentResponse(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        description: json["description"],
        users: List<DepartmentUser>.from(json["users"].map((x) => DepartmentUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "description": description,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class DepartmentUser {
  final int id;
  final String login;

  DepartmentUser({
    required this.id,
    required this.login,
  });

  DepartmentUser copyWith({
    int? id,
    String? login,
  }) =>
      DepartmentUser(
        id: id ?? this.id,
        login: login ?? this.login,
      );

  factory DepartmentUser.fromJson(Map<String, dynamic> json) => DepartmentUser(
        id: json["id"],
        login: json["login"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "login": login,
      };
}
