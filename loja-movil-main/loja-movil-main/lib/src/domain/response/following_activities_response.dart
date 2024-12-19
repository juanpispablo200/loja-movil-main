// To parse this JSON data, do
//
//     final followingActivitiesResponse = followingActivitiesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';

FollowingActivitiesResponse followingActivitiesResponseFromJson(String str) =>
    FollowingActivitiesResponse.fromJson(json.decode(str));

String followingActivitiesResponseToJson(FollowingActivitiesResponse data) =>
    json.encode(data.toJson());

class FollowingActivitiesResponse {
  final List<Evento> result;

  FollowingActivitiesResponse({
    required this.result,
  });

  factory FollowingActivitiesResponse.fromJson(Map<String, dynamic> json) =>
      FollowingActivitiesResponse(
        result:
            List<Evento>.from(json["result"].map((x) => Evento.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}
