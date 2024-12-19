// To parse this JSON data, do
//
//     final keyCloackSesion = keyCloackSesionFromJson(jsonString);

import 'dart:convert';

KeyCloackSesion keyCloackSesionFromJson(String str) =>
    KeyCloackSesion.fromJson(json.decode(str));

String keyCloackSesionToJson(KeyCloackSesion data) =>
    json.encode(data.toJson());

class KeyCloackSesion {
  String accessToken;
  int expiresIn;
  int refreshExpiresIn;
  String refreshToken;
  String tokenType;
  int notBeforePolicy;
  String sessionState;
  String scope;

  KeyCloackSesion({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshExpiresIn,
    required this.refreshToken,
    required this.tokenType,
    required this.notBeforePolicy,
    required this.sessionState,
    required this.scope,
  });

  factory KeyCloackSesion.fromJson(Map<String, dynamic> json) =>
      KeyCloackSesion(
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        refreshExpiresIn: json["refresh_expires_in"],
        refreshToken: json["refresh_token"],
        tokenType: json["token_type"],
        notBeforePolicy: json["not-before-policy"],
        sessionState: json["session_state"],
        scope: json["scope"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "expires_in": expiresIn,
        "refresh_expires_in": refreshExpiresIn,
        "refresh_token": refreshToken,
        "token_type": tokenType,
        "not-before-policy": notBeforePolicy,
        "session_state": sessionState,
        "scope": scope,
      };
}
