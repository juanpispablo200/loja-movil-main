import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/model/item.dart';
import 'package:loja_movil/src/domain/model/locality.dart';
import 'package:loja_movil/src/domain/model/parish.dart';
import 'package:loja_movil/src/domain/request/id_request.dart';
import 'package:loja_movil/src/domain/request/common_request.dart';
import 'package:loja_movil/src/domain/request/locality_filter_request.dart';
import 'package:loja_movil/src/domain/response/items_response.dart';
import 'package:loja_movil/src/domain/response/locality_list_response.dart';
import 'package:loja_movil/src/domain/response/route_response.dart';
import 'package:loja_movil/src/domain/usecase/tourism_usecase.dart';
import 'package:loja_movil/src/domain/response/parish_list_response.dart';

class LocalitiesListHomeBLoC extends ChangeNotifier {
  final TourismUseCase useCase;

  LocalitiesListHomeBLoC({required this.useCase});

  // PARISHES
  bool loadingParishes = false;
  List<Parish> parishes = [];

  // LOCALITY CATEGORIES
  bool loadingCategories = false;
  List<Item> categories = [];

  // TOURISM ROUTES
  bool loadingRoutes = false;
  List<FullRoute> routes = [];

  // TOURISM ROUTES
  bool loadingLocalities = false;
  List<Locality> localities = [];

  init() async {}

  Future<void> getLocalitiesByFilter(
      int? parishId, int? categoryId, int? routeId) async {
    LocalityFilterRequest req = LocalityFilterRequest(
        parishId: parishId, categoryId: categoryId, routeId: routeId);

    try {
      loadingLocalities = true;
      notifyListeners();
      LocalityListResponse locRep = await useCase.getLocalitiesByFilter(req);
      localities = locRep.fullLocalities;
      notifyListeners();
    } catch (e) {
      debugPrint('Error obteniendo las localidades: $e');
    } finally {
      loadingLocalities = false;
      notifyListeners();
    }
  }

  clearLocalities() {
    localities = [];
  }

  Future<void> getParishesByCantonCode() async {
    String cantonCode = 'LOJA';

    CommonRequest request = CommonRequest();
    request.id = null;
    request.criteria = cantonCode;

    try {
      loadingParishes = true;
      notifyListeners();
      ParishListResponse parishRep =
          await useCase.getParishesByCantonCode(request);
      parishes = parishRep.parishes;
      notifyListeners();
    } catch (e) {
      debugPrint('Error obteniendo las parroquias: $e');
    } finally {
      loadingParishes = false;
      notifyListeners();
    }
  }

  Future<void> getLocalityCategories() async {
    String catalogCode = 'TIPO_LOCALIDADES';

    CommonRequest request = CommonRequest();
    request.id = null;
    request.criteria = catalogCode;

    try {
      loadingCategories = true;
      notifyListeners();
      ItemsResponse itemRep = await useCase.getItemsByCatalogCode(request);
      categories = itemRep.items;
      notifyListeners();
    } catch (e) {
      debugPrint('Error obteniendo las categorias: $e');
    } finally {
      loadingCategories = false;
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
      notifyListeners();
    } catch (e) {
      debugPrint('Error obteniendo las rutas: $e');
    } finally {
      loadingRoutes = false;
      notifyListeners();
    }
  }
}
