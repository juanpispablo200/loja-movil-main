import 'package:flutter/foundation.dart';

class IncidenceRequest {
  final Uint8List photo;
  final String photoContentType;
  final double coordinateX;
  final double coordinateY;
  final DateTime incidenceDate;
  final String email;
  final int validationCode;

  IncidenceRequest({
    required this.photo,
    required this.photoContentType,
    required this.coordinateX,
    required this.coordinateY,
    required this.incidenceDate,
    required this.email,
    required this.validationCode,
  });
}
