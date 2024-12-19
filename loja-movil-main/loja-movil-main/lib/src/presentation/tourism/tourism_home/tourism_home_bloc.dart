import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/model/item.dart';
import 'package:loja_movil/src/domain/request/common_request.dart';
import 'package:loja_movil/src/domain/request/id_request.dart';
import 'package:loja_movil/src/domain/response/items_response.dart';
import 'package:loja_movil/src/domain/response/route_response.dart';
import 'package:loja_movil/src/domain/usecase/tourism_usecase.dart';

class TourismHomeBLoC extends ChangeNotifier {
  final TourismUseCase useCase;

  TourismHomeBLoC({required this.useCase});

  // ITEMS
  bool loadingItems = false;
  List<Item> items = [];

  // TOURISM ROUTES
  bool loadingRoutes = false;
  List<FullRoute> routes = [];

  init() async {
    await getItemsByCatalogCode();
    await getRoutesByCatalog(null);
  }

  Future<void> getItemsByCatalogCode() async {
    String catalogCode = 'TIPO_RUTA_TURISTICA';

    CommonRequest request = CommonRequest();
    request.id = null;
    request.criteria = catalogCode;

    Item firstIt = Item(
        id: null,
        name: 'Todos',
        catalogCode: catalogCode,
        active: true,
        code: '');

    try {
      loadingItems = true;
      notifyListeners();
      ItemsResponse itemsRep = await useCase.getItemsByCatalogCode(request);
      items = itemsRep.items;
      items.insert(0, firstIt);
    } catch (e) {
      debugPrint('Error obteniendo los items: $e');
    } finally {
      loadingItems = false;
      notifyListeners();
    }
  }

  Future<void> getRoutesByCatalog(int? categoryId) async {
    IdRequest request = IdRequest();
    request.id = categoryId;

    try {
      loadingRoutes = true;
      notifyListeners();
      RoutesResponse routesRep = await useCase.getRoutesByCategory(request);
      routes = routesRep.fullRoutes;
    } catch (e) {
      debugPrint('Error obteniendo las rutas: $e');
    } finally {
      loadingRoutes = false;
      notifyListeners();
    }
  }
}
