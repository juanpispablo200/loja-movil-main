import 'package:loja_movil/src/domain/request/common_request.dart';
import 'package:loja_movil/src/domain/request/id_request.dart';
import 'package:loja_movil/src/domain/request/locality_filter_request.dart';
import 'package:loja_movil/src/domain/response/items_response.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/response/locality_list_response.dart';
import 'package:loja_movil/src/domain/response/locality_response.dart';
import 'package:loja_movil/src/domain/response/parish_list_response.dart';
import 'package:loja_movil/src/domain/response/route_response.dart';

class TourismUseCase {
  final ApiRepository apiRepositoryInterface;

  TourismUseCase({
    required this.apiRepositoryInterface,
  });

  Future<ItemsResponse> getItemsByCatalogCode(CommonRequest request) async {
    return await apiRepositoryInterface.getItemsByCatalogCode(request);
  }

  Future<RoutesResponse> getRoutesByCategory(IdRequest request) async {
    return await apiRepositoryInterface.getRoutesByCategory(request);
  }

  Future<RouteResponse> getTourismRouteById(IdRequest request) async {
    return await apiRepositoryInterface.getTourismRouteById(request);
  }

  Future<LocalityResponse> getLocalityById(IdRequest request) async {
    return await apiRepositoryInterface.getLocalityById(request);
  }

  Future<ParishListResponse> getParishesByCantonCode(
      CommonRequest request) async {
    return await apiRepositoryInterface.getParishesByCantonCode(request);
  }

  Future<LocalityListResponse> getLocalitiesByFilter(
      LocalityFilterRequest request) async {
    return await apiRepositoryInterface.getLocalitiesByFilter(request);
  }
}
