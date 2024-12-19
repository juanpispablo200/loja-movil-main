// To parse this JSON data, do
//
//     final eventsFavByLocalResponse = eventsFavByLocalResponseFromJson(jsonString);

import 'dart:convert';

EventsFavByLocalResponse eventsFavByLocalResponseFromJson(String str) =>
    EventsFavByLocalResponse.fromJson(json.decode(str));

String eventsFavByLocalResponseToJson(EventsFavByLocalResponse data) =>
    json.encode(data.toJson());

class EventsFavByLocalResponse {
  final List<LocalFav> result;

  EventsFavByLocalResponse({
    required this.result,
  });

  factory EventsFavByLocalResponse.fromJson(Map<String, dynamic> json) =>
      EventsFavByLocalResponse(
        result: List<LocalFav>.from(
            json["result"].map((x) => LocalFav.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class LocalFav {
  final String nombre;
  final String direccion;
  final String latitude;
  final String longitude;
  final String ubicacion;
  final String informacion;
  final List<EventoFAV> eventos;

  LocalFav({
    required this.nombre,
    required this.direccion,
    required this.latitude,
    required this.longitude,
    required this.ubicacion,
    required this.informacion,
    required this.eventos,
  });

  factory LocalFav.fromJson(Map<String, dynamic> json) => LocalFav(
        nombre: json["nombre"],
        direccion: json["direccion"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        ubicacion: json["ubicacion"],
        informacion: json["informacion"],
        eventos: List<EventoFAV>.from(
            json["eventos"].map((x) => EventoFAV.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "direccion": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "ubicacion": ubicacion,
        "informacion": informacion,
        "eventos": List<dynamic>.from(eventos.map((x) => x.toJson())),
      };
}

class EventoFAV {
  final String nombreEvento;
  final String horaInicio;
  final String horaFin;
  final String ponente;
  final String procedencia;
  final String tipo;
  final String icono;
  final String imagen;
  final String entrada;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String duracion;

  EventoFAV({
    required this.nombreEvento,
    required this.horaInicio,
    required this.horaFin,
    required this.ponente,
    required this.procedencia,
    required this.tipo,
    required this.icono,
    required this.imagen,
    required this.entrada,
    required this.fechaInicio,
    required this.fechaFin,
    required this.duracion,
  });

  factory EventoFAV.fromJson(Map<String, dynamic> json) => EventoFAV(
        nombreEvento: json["nombre_evento"],
        horaInicio: json["hora_inicio"],
        horaFin: json["hora_fin"],
        ponente: json["ponente"],
        procedencia: json["procedencia"],
        tipo: json["tipo"],
        icono: json["icono"],
        imagen: json["imagen"],
        entrada: json["entrada"],
        fechaInicio: DateTime.parse(json["fecha_inicio"]),
        fechaFin: DateTime.parse(json["fecha_fin"]),
        duracion: json["duracion"],
      );

  Map<String, dynamic> toJson() => {
        "nombre_evento": nombreEvento,
        "hora_inicio": horaInicio,
        "hora_fin": horaFin,
        "ponente": ponente,
        "procedencia": procedencia,
        "tipo": tipo,
        "icono": icono,
        "imagen": imagen,
        "entrada": entrada,
        "fecha_inicio":
            "${fechaInicio.year.toString().padLeft(4, '0')}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')}",
        "fecha_fin":
            "${fechaFin.year.toString().padLeft(4, '0')}-${fechaFin.month.toString().padLeft(2, '0')}-${fechaFin.day.toString().padLeft(2, '0')}",
        "duracion": duracion,
      };
}
