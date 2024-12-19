// To parse this JSON data, do
//
//     final eventsFavByDatesResponse = eventsFavByDatesResponseFromJson(jsonString);

import 'dart:convert';

EventsFavByDatesResponse eventsFavByDatesResponseFromJson(String str) =>
    EventsFavByDatesResponse.fromJson(json.decode(str));

String eventsFavByDatesResponseToJson(EventsFavByDatesResponse data) =>
    json.encode(data.toJson());

class EventsFavByDatesResponse {
  final List<EventoFavDTO> result;

  EventsFavByDatesResponse({
    required this.result,
  });

  factory EventsFavByDatesResponse.fromJson(Map<String, dynamic> json) =>
      EventsFavByDatesResponse(
        result: List<EventoFavDTO>.from(
            json["result"].map((x) => EventoFavDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class EventoFavDTO {
  final String dia;
  final String ma;
  final String di;
  final String nu;
  final List<EventoFavDetail> eventos;

  EventoFavDTO({
    required this.dia,
    required this.ma,
    required this.di,
    required this.nu,
    required this.eventos,
  });

  factory EventoFavDTO.fromJson(Map<String, dynamic> json) => EventoFavDTO(
        dia: json["dia"],
        ma: json["ma"],
        di: json["di"],
        nu: json["nu"],
        eventos: List<EventoFavDetail>.from(
            json["eventos"].map((x) => EventoFavDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dia": dia,
        "ma": ma,
        "di": di,
        "nu": nu,
        "eventos": List<dynamic>.from(eventos.map((x) => x.toJson())),
      };
}

class EventoFavDetail {
  final String lugar;
  final String direccion;
  final String latitude;
  final String longitude;
  final String nombreEvento;
  final String horaInicio;
  final String horaFin;
  final String ponente;
  final String procedencia;
  final String tipo;
  final String icono;
  final String imagen;
  final String entrada;
  final String duracion;

  EventoFavDetail({
    required this.lugar,
    required this.direccion,
    required this.latitude,
    required this.longitude,
    required this.nombreEvento,
    required this.horaInicio,
    required this.horaFin,
    required this.ponente,
    required this.procedencia,
    required this.tipo,
    required this.icono,
    required this.imagen,
    required this.entrada,
    required this.duracion,
  });

  factory EventoFavDetail.fromJson(Map<String, dynamic> json) =>
      EventoFavDetail(
        lugar: json["lugar"],
        direccion: json["direccion"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        nombreEvento: json["nombre_evento"],
        horaInicio: json["hora_inicio"],
        horaFin: json["hora_fin"],
        ponente: json["ponente"],
        procedencia: json["procedencia"],
        tipo: json["tipo"],
        icono: json["icono"],
        imagen: json["imagen"],
        entrada: json["entrada"],
        duracion: json["duracion"],
      );

  Map<String, dynamic> toJson() => {
        "lugar": lugar,
        "direccion": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "nombre_evento": nombreEvento,
        "hora_inicio": horaInicio,
        "hora_fin": horaFin,
        "ponente": ponente,
        "procedencia": procedencia,
        "tipo": tipo,
        "icono": icono,
        "imagen": imagen,
        "entrada": entrada,
        "duracion": duracion,
      };
}
