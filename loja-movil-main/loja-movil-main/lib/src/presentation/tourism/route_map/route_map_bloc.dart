import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/response/route_response.dart';
import 'package:loja_movil/src/domain/usecase/tourism_usecase.dart';

class RouteMapBLoC extends ChangeNotifier {
  final TourismUseCase useCase;

  late FullRoute route;

  RouteMapBLoC({
    required this.useCase,
  });

  init(FullRoute route) async {
    this.route = route;
  }
}
