// To parse this JSON data, do
//
//     final usserAccount = usserAccountFromJson(jsonString);

import 'dart:convert';

UserAccount usserAccountFromJson(String str) =>
    UserAccount.fromJson(json.decode(str));

String usserAccountToJson(UserAccount data) => json.encode(data.toJson());

class UserAccount {
  String id;
  String login;
  String firstName;
  String lastName;
  String email;
  dynamic imageUrl;
  bool activated;
  String langKey;
  dynamic createdBy;
  DateTime createdDate;
  dynamic lastModifiedBy;
  DateTime lastModifiedDate;
  List<String> authorities;
  List<AccountMenu> menu;
  List<String> urlsPermitidas;

  UserAccount({
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
    required this.menu,
    required this.urlsPermitidas,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
        id: json["id"],
        login: json["login"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        imageUrl: json["imageUrl"],
        activated: json["activated"],
        langKey: json["langKey"],
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
        authorities: List<String>.from(json["authorities"].map((x) => x)),
        menu: List<AccountMenu>.from(json["menu"].map((x) => AccountMenu.fromJson(x))),
        urlsPermitidas: List<String>.from(json["urlsPermitidas"].map((x) => x)),
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
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
        "urlsPermitidas": List<dynamic>.from(urlsPermitidas.map((x) => x)),
      };
}

class AccountMenu {
  String nombre;
  String? icono;
  String url;
  bool visible;
  List<AccountMenu> hijos;

  AccountMenu({
    required this.nombre,
    required this.icono,
    required this.url,
    required this.visible,
    required this.hijos,
  });

  factory AccountMenu.fromJson(Map<String, dynamic> json) => AccountMenu(
        nombre: json["nombre"],
        icono: json["icono"],
        url: json["url"],
        visible: json["visible"],
        hijos: List<AccountMenu>.from(json["hijos"].map((x) => AccountMenu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "icono": icono,
        "url": url,
        "visible": visible,
        "hijos": List<dynamic>.from(hijos.map((x) => x.toJson())),
      };
}
