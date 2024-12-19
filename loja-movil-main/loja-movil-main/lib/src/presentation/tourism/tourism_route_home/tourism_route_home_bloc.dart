import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/request/id_request.dart';
import 'package:loja_movil/src/domain/response/route_response.dart';
import 'package:loja_movil/src/domain/usecase/tourism_usecase.dart';

class TourismRouteHomeBLoC extends ChangeNotifier {
  final TourismUseCase useCase;

  TourismRouteHomeBLoC({required this.useCase});

  // TOURISM ROUTE
  bool loadingRoute = false;
  FullRoute? route;

  init(int routeId) async {
    await getRouteById(routeId);
  }

  Future<void> getRouteById(int routeId) async {
    IdRequest request = IdRequest();
    request.id = routeId;

    try {
      loadingRoute = true;
      notifyListeners();
      RouteResponse routeRep = await useCase.getTourismRouteById(request);
      route = routeRep.tourismRoute;
    } catch (e) {
      debugPrint('Error obteniendo la ruta: $e');
    } finally {
      loadingRoute = false;
      notifyListeners();
    }
  }
}
