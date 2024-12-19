// To parse this JSON data, do
//
//     final carruselResponse = carruselResponseFromJson(jsonString);

import 'dart:convert';

CarruselResponse carruselResponseFromJson(String str) =>
    CarruselResponse.fromJson(json.decode(str));

String carruselResponseToJson(CarruselResponse data) =>
    json.encode(data.toJson());

class CarruselResponse {
  final List<Result> result;

  CarruselResponse({
    required this.result,
  });

  factory CarruselResponse.fromJson(Map<String, dynamic> json) =>
      CarruselResponse(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  final List<ActividadesCarrusel> actividadesCarrusel;

  Result({
    required this.actividadesCarrusel,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        actividadesCarrusel: List<ActividadesCarrusel>.from(
            json["actividades_carrusel"]
                .map((x) => ActividadesCarrusel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "actividades_carrusel":
            List<dynamic>.from(actividadesCarrusel.map((x) => x.toJson())),
      };
}

class ActividadesCarrusel {
  final String ubicacion;

  ActividadesCarrusel({
    required this.ubicacion,
  });

  factory ActividadesCarrusel.fromJson(Map<String, dynamic> json) =>
      ActividadesCarrusel(
        ubicacion: json["ubicacion"],
      );

  Map<String, dynamic> toJson() => {
        "ubicacion": ubicacion,
      };
}
