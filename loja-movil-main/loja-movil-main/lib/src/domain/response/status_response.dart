// To parse this JSON data, do
//
//     final statusResponse = statusResponseFromJson(jsonString);

import 'dart:convert';

StatusResponse statusResponseFromJson(String str) =>
    StatusResponse.fromJson(json.decode(str));

String statusResponseToJson(StatusResponse data) => json.encode(data.toJson());

class StatusResponse {
  bool ok;
  String message;
  List<IncidenceStatus> status;

  StatusResponse({
    required this.ok,
    required this.message,
    required this.status,
  });

  factory StatusResponse.fromJson(Map<String, dynamic> json) => StatusResponse(
        ok: json["ok"],
        message: json["message"],
        status:
            List<IncidenceStatus>.from(json["status"].map((x) => IncidenceStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "status": List<dynamic>.from(status.map((x) => x.toJson())),
      };
}

class IncidenceStatus {
  int id;
  String name;
  String color;
  int total;

  IncidenceStatus({
    required this.id,
    required this.name,
    required this.color,
    required this.total,
  });

  factory IncidenceStatus.fromJson(Map<String, dynamic> json) => IncidenceStatus(
        id: json["id"],
        name: json["name"],
        color: json["color"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
        "total": total,
      };
}
