import 'dart:convert';
import 'package:loja_movil/src/domain/model/item.dart';
import 'package:loja_movil/src/domain/model/parish.dart';
import 'package:loja_movil/src/domain/model/schedule.dart';
import 'package:loja_movil/src/domain/model/image_element.dart';

Locality localityFromJson(String str) => Locality.fromJson(json.decode(str));

String localityToJson(Locality data) => json.encode(data.toJson());

class Locality {
  int id;
  String code;
  String name;
  double latitude;
  double longitude;
  String address;
  String description;
  int? capacity;
  String? url;
  String? manager;
  String? contact;
  String? email;
  Item? category;
  Parish? parish;
  List<ImageElement>? imageGallery;
  List<Schedule>? schedule;
  DateTime? creationTime;
  DateTime? modificationTime;
  DateTime? eliminationTime;
  bool isActive;
  List<dynamic>? touristRoutes;

  Locality({
    required this.id,
    required this.code,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.description,
    this.capacity,
    this.url,
    this.manager,
    this.contact,
    this.email,
    this.category,
    this.parish,
    this.imageGallery,
    this.schedule,
    this.creationTime,
    this.modificationTime,
    this.eliminationTime,
    required this.isActive,
    this.touristRoutes,
  });

  factory Locality.fromJson(Map<String, dynamic> json) => Locality(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        description: json["description"],
        capacity: json["capacity"]?.toInt(),
        url: json["url"],
        manager: json["manager"],
        contact: json["contact"],
        email: json["email"],
        category:
            json["category"] != null ? Item.fromJson(json["category"]) : null,
        parish: json["parish"] != null ? Parish.fromJson(json["parish"]) : null,
        imageGallery: json["imageGallery"] != null
            ? List<ImageElement>.from(
                json["imageGallery"].map((x) => ImageElement.fromJson(x)))
            : null,
        schedule: json["schedule"] != null
            ? List<Schedule>.from(
                json["schedule"].map((x) => Schedule.fromJson(x)))
            : null,
        creationTime: json["creationTime"] != null
            ? DateTime.parse(json["creationTime"])
            : null,
        modificationTime: json["modificationTime"] != null
            ? DateTime.parse(json["modificationTime"])
            : null,
        eliminationTime: json["eliminationTime"] != null
            ? DateTime.parse(json["eliminationTime"])
            : null,
        isActive: json["isActive"],
        touristRoutes: json["touristRoutes"] != null
            ? List<dynamic>.from(json["touristRoutes"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "description": description,
        "capacity": capacity,
        "url": url,
        "manager": manager,
        "contact": contact,
        "email": email,
        "category": category?.toJson(),
        "parish": parish?.toJson(),
        "imageGallery": imageGallery != null
            ? List<dynamic>.from(imageGallery!.map((x) => x.toJson()))
            : null,
        "schedule": schedule != null
            ? List<dynamic>.from(schedule!.map((x) => x.toJson()))
            : null,
        "creationTime": creationTime?.toIso8601String(),
        "modificationTime": modificationTime?.toIso8601String(),
        "eliminationTime": eliminationTime?.toIso8601String(),
        "isActive": isActive,
        "touristRoutes": touristRoutes != null
            ? List<dynamic>.from(touristRoutes!.map((x) => x))
            : null,
      };
}
