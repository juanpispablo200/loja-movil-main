import 'dart:convert';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  int id;
  String? day;
  String? openingTime1;
  String? closingTime1;
  String? openingTime2;
  String? closingTime2;
  bool isActive;
  dynamic locality;

  Schedule({
    required this.id,
    this.day,
    this.openingTime1,
    this.closingTime1,
    this.openingTime2,
    this.closingTime2,
    required this.isActive,
    this.locality,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        day: json["day"],
        openingTime1: json["openingTime1"],
        closingTime1: json["closingTime1"],
        openingTime2: json["openingTime2"],
        closingTime2: json["closingTime2"],
        isActive: json["isActive"],
        locality: json["locality"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "openingTime1": openingTime1,
        "closingTime1": closingTime1,
        "openingTime2": openingTime2,
        "closingTime2": closingTime2,
        "isActive": isActive,
        "locality": locality,
      };
}
