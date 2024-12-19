import 'dart:typed_data';
import 'package:loja_movil/src/domain/request/common_request.dart';
import 'package:loja_movil/src/domain/request/id_request.dart';
import 'package:loja_movil/src/domain/request/locality_filter_request.dart';
import 'package:loja_movil/src/domain/response/Keycloak_session_response.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
import 'package:loja_movil/src/domain/response/common_response.dart';
import 'package:loja_movil/src/domain/response/incidence_type_response.dart';
import 'package:loja_movil/src/domain/response/carrusel_response.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_dates_response.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_local_response.dart';
import 'package:loja_movil/src/domain/response/events_response.dart';
import 'package:loja_movil/src/domain/response/incidences_response.dart';
import 'package:loja_movil/src/domain/response/items_response.dart';
import 'package:loja_movil/src/domain/response/locality_list_response.dart';
import 'package:loja_movil/src/domain/response/locality_response.dart';
import 'package:loja_movil/src/domain/response/parish_list_response.dart';
import 'package:loja_movil/src/domain/response/route_response.dart';
import 'package:loja_movil/src/domain/response/status_response.dart';
import 'package:loja_movil/src/domain/response/login_response.dart';
import 'package:loja_movil/src/domain/response/lugars_with_events_response.dart';
import 'package:loja_movil/src/domain/response/menu_response.dart';
import 'package:loja_movil/src/domain/response/new_incidence_response.dart';
import 'package:loja_movil/src/domain/response/news_response.dart';
import 'package:loja_movil/src/domain/response/user_account_response.dart';
import 'package:loja_movil/src/domain/response/user_response.dart';

abstract class ApiRepository {
  Future<CarruselResponse?> getCarrusel();
  Future<LoginResponse?> login(String username, String password);
  Future<User?> getUser(String token);
  Future<List<Evento>> getFollowingActivities();
  Future<List<News>> getNews();
  Future<List<LugarDTO>> getLugarsInfo({int? limit});
  Future<Lugar?> getLugarEvents(int id);
  Future<EventsResponse?> getEvents(dynamic criteria);
  Future<List<Menu>> getMenu();
  Future<List<LocalFav>> getEventsFAVByLocal();
  Future<List<EventoFavDTO>> getEventsFAVByDates();
  Future<IncidenceResponse> getIncidencesByRoleAndStatus(
      List<int> incidenceStatus);
  Future<IncidenceResponse> getIncidencesToShowUser();
  Future<StatusResponse> getUserStatus();
  Future<StatusResponse> getStatusByRole();
  Future<NewIncidenceResponse?> createIncidence(Map<String, dynamic> request);
  Future<IncidenceTypeResponse> getAllIncidenceTypes();
  Future<CommonResponse?> reassignIncidence(Map<String, dynamic> request);
  Future<CommonResponse?> attendIncidence(Map<String, dynamic> request);
  Future<KeyCloackSesion?> loginKeycloak(String username, String password);
  Future<UserAccount?> getUserAccount(String token);

  // Tourism
  Future<ItemsResponse> getItemsByCatalogCode(CommonRequest request);
  Future<RoutesResponse> getRoutesByCategory(IdRequest request);
  Future<RouteResponse> getTourismRouteById(IdRequest request);
  Future<LocalityResponse> getLocalityById(IdRequest request);
  Future<ParishListResponse> getParishesByCantonCode(CommonRequest request);
  Future<LocalityListResponse> getLocalitiesByFilter(
      LocalityFilterRequest request);

  Future<Uint8List?> getAlfrescoImageData(String fileId);
}
