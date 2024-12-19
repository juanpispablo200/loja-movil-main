import 'dart:convert';

ImageElement imageElementFromJson(String str) =>
    ImageElement.fromJson(json.decode(str));

String imageElementToJson(ImageElement data) => json.encode(data.toJson());

class ImageElement {
  int id;
  String picture;
  String pictureContentType;
  int destination;
  String targetTypeCode;
  bool isActive;

  ImageElement({
    required this.id,
    required this.picture,
    required this.pictureContentType,
    required this.destination,
    required this.targetTypeCode,
    required this.isActive,
  });

  factory ImageElement.fromJson(Map<String, dynamic> json) => ImageElement(
        id: json["id"],
        picture: json["picture"],
        pictureContentType: json["pictureContentType"],
        destination: json["destination"],
        targetTypeCode: json["targetTypeCode"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "picture": picture,
        "pictureContentType": pictureContentType,
        "destination": destination,
        "targetTypeCode": targetTypeCode,
        "isActive": isActive,
      };
}
