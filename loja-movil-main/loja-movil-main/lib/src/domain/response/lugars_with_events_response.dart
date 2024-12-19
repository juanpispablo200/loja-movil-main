// To parse this JSON data, do
//
//     final lugarsWithEventsResponse = lugarsWithEventsResponseFromJson(jsonString);

import 'dart:convert';

LugarsWithEventsResponse lugarsWithEventsResponseFromJson(String str) =>
    LugarsWithEventsResponse.fromJson(json.decode(str));

String lugarsWithEventsResponseToJson(LugarsWithEventsResponse data) =>
    json.encode(data.toJson());

class LugarsWithEventsResponse {
  final List<LugarDTO> result;

  LugarsWithEventsResponse({
    required this.result,
  });

  factory LugarsWithEventsResponse.fromJson(Map<String, dynamic> json) =>
      LugarsWithEventsResponse(
        result: List<LugarDTO>.from(
            json["result"]!.map((x) => LugarDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class LugarDTO {
  final int id;
  final String nombre;
  final String? direccion;
  final String? latitude;
  final String? longitude;
  final String? ubicacion;
  final String? informacion;
  final int? total;

  LugarDTO({
    required this.id,
    required this.nombre,
    this.direccion,
    this.latitude,
    this.longitude,
    this.ubicacion,
    this.informacion,
    this.total,
  });

  factory LugarDTO.fromJson(Map<String, dynamic> json) => LugarDTO(
        id: json["id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        ubicacion: json["ubicacion"],
        informacion: json["informacion"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "ubicacion": ubicacion,
        "informacion": informacion,
        "total": total,
      };
}
