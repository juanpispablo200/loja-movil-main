import 'dart:convert';

Canton cantonFromJson(String str) => Canton.fromJson(json.decode(str));

String cantonToJson(Canton data) => json.encode(data.toJson());

class Canton {
  int id;
  String code;
  String name;
  String? information;
  double latitude;
  double longitude;

  Canton({
    required this.id,
    required this.code,
    required this.name,
    this.information,
    required this.latitude,
    required this.longitude,
  });

  factory Canton.fromJson(Map<String, dynamic> json) => Canton(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        information: json["information"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "information": information,
        "latitude": latitude,
        "longitude": longitude,
      };
}
