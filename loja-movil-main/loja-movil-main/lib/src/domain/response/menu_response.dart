// To parse this JSON data, do
//
//     final menuResponse = menuResponseFromJson(jsonString);

import 'dart:convert';

MenuResponse menuResponseFromJson(String str) =>
    MenuResponse.fromJson(json.decode(str));

String menuResponseToJson(MenuResponse data) => json.encode(data.toJson());

class MenuResponse {
  final List<Menu> menu;

  MenuResponse({
    required this.menu,
  });

  factory MenuResponse.fromJson(Map<String, dynamic> json) => MenuResponse(
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
      };
}

class Menu {
  final int id;
  final String titulo;
  final String ruta;
  final String icono;
  final String backgroundColor;
  final int prioridad;

  Menu({
    required this.id,
    required this.titulo,
    required this.ruta,
    required this.icono,
    required this.backgroundColor,
    required this.prioridad,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        titulo: json["titulo"],
        ruta: json["ruta"],
        icono: json["icono"],
        backgroundColor: json["backgroundColor"],
        prioridad: json["prioridad"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "ruta": ruta,
        "icono": icono,
        "backgroundColor": backgroundColor,
        "prioridad": prioridad,
      };
}
