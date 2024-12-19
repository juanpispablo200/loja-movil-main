// To parse this JSON data, do
//
//     final accountResponse = accountResponseFromJson(jsonString);

import 'dart:convert';

AccountResponse accountResponseFromJson(String str) =>
    AccountResponse.fromJson(json.decode(str));

String accountResponseToJson(AccountResponse data) =>
    json.encode(data.toJson());

class AccountResponse {
  final int id;
  final String login;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  final bool activated;
  final String langKey;
  final String createdBy;
  final dynamic createdDate;
  final String lastModifiedBy;
  final dynamic lastModifiedDate;
  final List<String> authorities;

  AccountResponse({
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

  AccountResponse copyWith({
    int? id,
    String? login,
    String? firstName,
    String? lastName,
    String? email,
    String? imageUrl,
    bool? activated,
    String? langKey,
    String? createdBy,
    dynamic createdDate,
    String? lastModifiedBy,
    dynamic lastModifiedDate,
    List<String>? authorities,
  }) =>
      AccountResponse(
        id: id ?? this.id,
        login: login ?? this.login,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        imageUrl: imageUrl ?? this.imageUrl,
        activated: activated ?? this.activated,
        langKey: langKey ?? this.langKey,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        authorities: authorities ?? this.authorities,
      );

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      AccountResponse(
        id: json["id"],
        login: json["login"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        imageUrl: json["imageUrl"] ?? "",
        activated: json["activated"],
        langKey: json["langKey"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"],
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"],
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
        "createdDate": createdDate,
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate,
        "authorities": List<dynamic>.from(authorities.map((x) => x)),
      };
}
