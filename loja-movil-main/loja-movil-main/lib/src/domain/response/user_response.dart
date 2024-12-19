// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String id;
  final String login;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? imageUrl;
  final bool activated;
  final String? langKey;
  final String? createdBy;
  final DateTime createdDate;
  final String? lastModifiedBy;
  final DateTime lastModifiedDate;
  final List<String> authorities;

  User({
    required this.id,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
    required this.activated,
    required this.langKey,
    required this.createdBy,
    required this.createdDate,
    required this.lastModifiedBy,
    required this.lastModifiedDate,
    required this.authorities,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        login: json["login"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        imageUrl: json["imageUrl"] ?? "",
        activated: json["activated"],
        langKey: json["langKey"],
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
        authorities: List<String>.from(json["authorities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "login": login,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "imageUrl": imageUrl,
        "activated": activated,
        "langKey": langKey,
        "createdBy": createdBy,
        "createdDate": createdDate.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate.toIso8601String(),
        "authorities": List<dynamic>.from(authorities.map((x) => x)),
      };
}
