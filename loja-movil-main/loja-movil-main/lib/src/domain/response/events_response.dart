// To parse this JSON data, do
//
//     final eventsResponse = eventsResponseFromJson(jsonString);

import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
import 'dart:convert';

EventsResponse eventsResponseFromJson(String str) =>
    EventsResponse.fromJson(json.decode(str));

String eventsResponseToJson(EventsResponse data) => json.encode(data.toJson());

class EventsResponse {
  final int total;
  final List<Evento> result;

  EventsResponse({
    required this.total,
    required this.result,
  });

  factory EventsResponse.fromJson(Map<String, dynamic> json) => EventsResponse(
        total: json["total"],
        result:
            List<Evento>.from(json["result"].map((x) => Evento.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "result": List<Evento>.from(result.map((x) => x.toJson())),
      };
}
