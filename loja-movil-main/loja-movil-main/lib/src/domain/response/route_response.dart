import 'dart:convert';

import 'package:loja_movil/src/domain/model/image_element.dart';
import 'package:loja_movil/src/domain/model/locality.dart';

// Parse JSON to RoutesResponse object
RoutesResponse routesResponseFromJson(String str) =>
    RoutesResponse.fromJson(json.decode(str));

// Convert RoutesResponse object to JSON string
String routesResponseToJson(RoutesResponse data) => json.encode(data.toJson());

class RoutesResponse {
  bool ok;
  String message;
  List<FullRoute> fullRoutes;

  RoutesResponse({
    required this.ok,
    required this.message,
    required this.fullRoutes,
  });

  factory RoutesResponse.fromJson(Map<String, dynamic> json) => RoutesResponse(
        ok: json["ok"],
        message: json["message"],
        fullRoutes: List<FullRoute>.from(
            json["fullRoutes"]?.map((x) => FullRoute.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "fullRoutes": fullRoutes.map((x) => x.toJson()).toList(),
      };
}

// Parse JSON to RouteResponse object
RouteResponse routeResponseFromJson(String str) =>
    RouteResponse.fromJson(json.decode(str));

// Convert RouteResponse object to JSON string
String routeResponseToJson(RouteResponse data) => json.encode(data.toJson());

class RouteResponse {
  bool ok;
  String message;
  FullRoute? tourismRoute;

  RouteResponse({
    required this.ok,
    required this.message,
    this.tourismRoute,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) => RouteResponse(
        ok: json["ok"],
        message: json["message"],
        tourismRoute: json["tourismRoute"] != null
            ? FullRoute.fromJson(json["tourismRoute"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "tourismRoute": tourismRoute?.toJson(),
      };
}

class FullRoute {
  int id;
  String code;
  String name;
  String? estimatedTravelTime;
  String description;
  DateTime creationTime;
  DateTime? modificationTime;
  DateTime? eliminationTime;
  bool isActive;
  int categoryRouteId;
  List<ImageElement> imageGallery;
  List<Locality>? routePoints;

  FullRoute({
    required this.id,
    required this.code,
    required this.name,
    this.estimatedTravelTime,
    required this.description,
    required this.creationTime,
    this.modificationTime,
    this.eliminationTime,
    required this.isActive,
    required this.categoryRouteId,
    required this.imageGallery,
    this.routePoints,
  });

  factory FullRoute.fromJson(Map<String, dynamic> json) => FullRoute(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        estimatedTravelTime: json["estimatedTravelTime"],
        description: json["description"],
        creationTime: DateTime.parse(json["creationTime"]),
        modificationTime: json["modificationTime"] != null
            ? DateTime.parse(json["modificationTime"])
            : null,
        eliminationTime: json["eliminationTime"] != null
            ? DateTime.parse(json["eliminationTime"])
            : null,
        isActive: json["isActive"],
        categoryRouteId: json["categoryRouteId"],
        imageGallery: List<ImageElement>.from(
            json["imageGallery"]?.map((x) => ImageElement.fromJson(x)) ?? []),
        routePoints: json["routePoints"] != null
            ? List<Locality>.from(
                json["routePoints"].map((x) => Locality.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "estimatedTravelTime": estimatedTravelTime,
        "description": description,
        "creationTime": creationTime.toIso8601String(),
        "modificationTime": modificationTime?.toIso8601String(),
        "eliminationTime": eliminationTime?.toIso8601String(),
        "isActive": isActive,
        "categoryRouteId": categoryRouteId,
        "imageGallery": imageGallery.map((x) => x.toJson()).toList(),
        "routePoints": routePoints?.map((x) => x.toJson()).toList(),
      };
}
