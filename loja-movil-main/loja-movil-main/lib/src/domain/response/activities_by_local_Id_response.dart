// To parse this JSON data, do
//
//     final activitiesByLocalIdResponse = activitiesByLocalIdResponseFromJson(jsonString);

import 'dart:convert';

ActivitiesByLocalIdResponse activitiesByLocalIdResponseFromJson(String str) =>
    ActivitiesByLocalIdResponse.fromJson(json.decode(str));

String activitiesByLocalIdResponseToJson(ActivitiesByLocalIdResponse data) =>
    json.encode(data.toJson());

class ActivitiesByLocalIdResponse {
  final Lugar? lugar;

  ActivitiesByLocalIdResponse({
    this.lugar,
  });

  factory ActivitiesByLocalIdResponse.fromJson(Map<String, dynamic> json) =>
      ActivitiesByLocalIdResponse(
        lugar: json["lugar"] == null ? null : Lugar.fromJson(json["lugar"]),
      );

  Map<String, dynamic> toJson() => {
        "lugar": lugar?.toJson(),
      };
}

class Lugar {
  final String nombre;
  final String? direccion;
  final String? latitude;
  final String? longitude;
  final String? ubicacion;
  final List<Evento>? eventos;

  Lugar({
    required this.nombre,
    this.direccion,
    this.latitude,
    this.longitude,
    this.ubicacion,
    this.eventos,
  });

  factory Lugar.fromJson(Map<String, dynamic> json) => Lugar(
        nombre: json["nombre"],
        direccion: json["direccion"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        ubicacion: json["ubicacion"],
        eventos: json["eventos"] == null
            ? []
            : List<Evento>.from(
                json["eventos"]!.map((x) => Evento.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "direccion": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "ubicacion": ubicacion,
        "eventos": eventos == null
            ? []
            : List<dynamic>.from(eventos!.map((x) => x.toJson())),
      };
}

class Evento {
  final String nombreEvento;
  final String? organizador;
  final String? costo;
  final String? icon;
  final String? imagen;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final int? aforo;
  final String? coorganizador;
  final String? hora;
  final FechaDTO inicio;
  final FechaDTO fin;
  final FechaDTO? fechaInfo;
  final String direccion;
  final String tipo;
  final String? lugar;

  Evento({
    required this.nombreEvento,
    this.organizador,
    this.costo,
    this.icon,
    this.imagen,
    required this.fechaInicio,
    required this.fechaFin,
    this.aforo,
    this.coorganizador,
    this.hora,
    required this.inicio,
    required this.fin,
    required this.direccion,
    required this.tipo,
    this.fechaInfo,
    this.lugar,
  });

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      nombreEvento: json["nombre_evento"],
      organizador: json["organizador"],
      costo: json["costo"],
      icon: json["icon"],
      imagen: json["imagen"],
      fechaInicio: DateTime.parse(json["fecha_inicio"]),
      fechaFin: DateTime.parse(json["fecha_fin"]),
      aforo: json["aforo"],
      coorganizador: json["coorganizador"],
      hora: json["hora"],
      inicio: FechaDTO.fromJson(json["inicio"]),
      fin: FechaDTO.fromJson(json["fin"]),
      direccion: json["direccion"],
      tipo: json["tipo"],
      lugar: json['lugar'],
      fechaInfo: json["fechaInfo"] == null
          ? null
          : FechaDTO.fromJson(json["fechaInfo"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "nombre_evento": nombreEvento,
        "organizador": organizador,
        "costo": costo,
        "icon": icon,
        "imagen": imagen,
        "fecha_inicio":
            "${fechaInicio.year.toString().padLeft(4, '0')}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')}",
        "fecha_fin":
            "${fechaFin.year.toString().padLeft(4, '0')}-${fechaFin.month.toString().padLeft(2, '0')}-${fechaFin.day.toString().padLeft(2, '0')}",
        "aforo": aforo,
        "coorganizador": coorganizador,
        "hora": hora,
        "inicio": inicio.toJson(),
        "fin": fin.toJson(),
        "direccion": direccion,
        "tipo": tipo,
        "lugar": lugar,
        "fechaInfo": fechaInfo?.toJson(),
      };
}

class FechaDTO {
  final String dia;
  final String mesAnio;
  final String mes;
  final String anio;
  final String diaNumero;
  final String diaMes;

  FechaDTO({
    required this.dia,
    required this.mesAnio,
    required this.mes,
    required this.anio,
    required this.diaNumero,
    required this.diaMes,
  });

  factory FechaDTO.fromJson(Map<String, dynamic> json) => FechaDTO(
        dia: json["dia"],
        mesAnio: json["mesAnio"],
        mes: json["mes"],
        anio: json["anio"],
        diaNumero: json["diaNumero"],
        diaMes: json["diaMes"],
      );

  Map<String, dynamic> toJson() => {
        "dia": dia,
        "mesAnio": mesAnio,
        "mes": mes,
        "anio": anio,
        "diaNumero": diaNumero,
        "diaMes": diaMes,
      };
}
