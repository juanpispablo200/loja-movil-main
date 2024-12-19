import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http_parser/http_parser.dart';
import 'package:loja_movil/constants.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/request/common_request.dart';
import 'package:loja_movil/src/domain/request/id_request.dart';
import 'package:loja_movil/src/domain/request/locality_filter_request.dart';
import 'package:loja_movil/src/domain/response/Keycloak_session_response.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
import 'package:loja_movil/src/domain/response/common_response.dart';
import 'package:loja_movil/src/domain/response/incidence_type_response.dart';
import 'package:loja_movil/src/domain/response/carrusel_response.dart';
import 'package:http/http.dart' as http;
import 'package:loja_movil/src/domain/response/events_fav_by_dates_response.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_local_response.dart';
import 'package:loja_movil/src/domain/response/events_response.dart';
import 'package:loja_movil/src/domain/response/following_activities_response.dart';
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
import 'package:loja_movil/src/presentation/cero_baches/utils/constants.dart';
import 'package:path/path.dart';

class ApiRepositoryImpl extends ApiRepository {
  final String _tokenUrl =
      'http://$kKeycloakEndPoint:$kKeycloakPort/realms/$kRealm/protocol/openid-connect/token';

  @override
  Future<CarruselResponse?> getCarrusel() async {
    try {
      var url = Uri.http(kFestivalEndPoint, '/festival_web/api/getPublicidad');

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final carruselResponse = carruselResponseFromJson(response.body);
        return carruselResponse;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<LoginResponse?> login(String username, String password) async {
    try {
      Uri url = Uri.parse(
          'http://$kKeycloakEndPoint:$kKeycloakPort/realms/jhipster/protocol/openid-connect/token');
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
        'cache-control': 'no-cache',
      };

      Map<String, String> data = {
        'client_id': 'loja_movil',
        'username': username,
        'password': password,
        'grant_type': 'password',
      };

      var response = await http.post(url, headers: headers, body: data);

      if (response.statusCode == 200) {
        final loginResponse = loginResponseFromJson(response.body);
        return loginResponse;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<User?> getUser(String token) async {
    try {
      Uri url = Uri.parse(
          'http://$kGatewayEndPoint:$kGatewayPort/services/gateway/api/account');
      Map<String, String> headers = {'Authorization': 'Bearer $token'};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final user = userFromJson(response.body);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<List<Evento>> getFollowingActivities() async {
    try {
      var url =
          Uri.http(kFestivalEndPoint, '/festival_web/api/getFollowingEvents');

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final activitiesResponse =
            followingActivitiesResponseFromJson(response.body);
        return activitiesResponse.result;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<News>> getNews() async {
    try {
      // var url = Uri.http('www.loja.gob.ec', '/api/noticiasjson');
      var url = Uri.https('www.loja.gob.ec', '/api/listnews');

      // http: //festivaloff.loja.gob.ec/api/listahoteles
      // var url = Uri.http('festivaloff.loja.gob.ec', '/api/listahoteles');

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final newsResponse = newsFromJson(response.body);
        return newsResponse;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<LugarDTO>> getLugarsInfo({int? limit}) async {
    try {
      var url =
          Uri.http(kFestivalEndPoint, '/festival_web/api/getLugarsWithEvents');

      // Await the http get response, then decode the json-formatted response.
      var params = {};
      if (limit != null) {
        params = {
          "limit": limit.toString(),
        };
      }
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: params,
      );
      if (response.statusCode == 200) {
        final activitiesResponse =
            lugarsWithEventsResponseFromJson(response.body);
        return activitiesResponse.result;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Lugar?> getLugarEvents(int id) async {
    try {
      var url = Uri.http(
          kFestivalEndPoint, '/festival_web/api/getActivitiesFLByLocalId');

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: {
          "id": id.toString(),
        },
      );
      if (response.statusCode == 200) {
        final lugarResponse =
            activitiesByLocalIdResponseFromJson(response.body);
        return lugarResponse.lugar;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<EventsResponse?> getEvents(dynamic criteria) async {
    try {
      var url = Uri.http(
          kFestivalEndPoint, '/festival_web/api/getActivitiesByCriteria');

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: criteria,
      );
      if (response.statusCode == 200) {
        final lugarResponse = eventsResponseFromJson(response.body);
        return lugarResponse;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Menu>> getMenu() async {
    try {
      var url = Uri.http(kFestivalEndPoint, '/festival_web/api/getMenu');

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final menuResponse = menuResponseFromJson(response.body);
        return menuResponse.menu;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // http://192.168.15.205:8080/services/gateway/api/account
  @override
  Future<List<LocalFav>> getEventsFAVByLocal() async {
    try {
      var url =
          Uri.http(kFestivalEndPoint, '/festival_web/api/getEventsFAVByLocal');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        final eventsFavResponse =
            eventsFavByLocalResponseFromJson(response.body);
        return eventsFavResponse.result;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<EventoFavDTO>> getEventsFAVByDates() async {
    try {
      var url =
          Uri.http(kFestivalEndPoint, '/festival_web/api/getEventsFAVByDates');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        final eventsFavResponse =
            eventsFavByDatesResponseFromJson(response.body);
        return eventsFavResponse.result;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // INCIDENCES ////////////////////////////////////////////////////////////////////////////
  @override
  Future<IncidenceResponse> getIncidencesByRoleAndStatus(
      List<int> incidenceStatus) async {
    try {
      String tokenSession = await SessionManager().get(ceroBachesKey);

      var url = Uri.http('$kCeroBachesEndPoint:$kCeroBachesPort',
          '/api/micro-incidences/get-incidences-by-role-and-status');

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenSession'
        },
        body: jsonEncode({'statusIds': incidenceStatus}),
      );
      if (response.statusCode == 200) {
        var incidences =
            incidenceResponseFromJson(utf8.decode(response.body.codeUnits));
        return incidences;
      } else {
        return IncidenceResponse(
            ok: false, message: 'Error al obtener los datos', incidences: []);
      }
    } catch (e) {
      return IncidenceResponse(
          ok: false, message: e.toString(), incidences: []);
    }
  }

  @override
  Future<IncidenceResponse> getIncidencesToShowUser() async {
    const int maxRetries = 3;
    const Duration timeoutDuration = Duration(seconds: 5);

    try {
      var url = Uri.http('$kCeroBachesEndPoint:$kCeroBachesPort',
          '/api/micro-incidences/get-incidences-to-show-user');

      for (int attempt = 0; attempt < maxRetries; attempt++) {
        try {
          var response = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ).timeout(timeoutDuration);
          if (response.statusCode == 200) {
            var incidences =
                incidenceResponseFromJson(utf8.decode(response.body.codeUnits));
            return incidences;
          } else {
            return IncidenceResponse(
                ok: false,
                message: 'Error al obtener los datos',
                incidences: []);
          }
        } catch (e) {
          debugPrint('Intento $attempt fallido con error: $e');
          if (attempt == maxRetries - 1) {
            return IncidenceResponse(
                ok: false,
                message:
                    'Error al obtener los datos después de varios intentos',
                incidences: []);
          }
        }
      }
    } catch (e) {
      return IncidenceResponse(
          ok: false, message: e.toString(), incidences: []);
    }
    // Fallback if all retries fail
    return IncidenceResponse(
        ok: false,
        message: 'Error inesperado al obtener los datos',
        incidences: []);
  }

  @override
  Future<StatusResponse> getUserStatus() async {
    Map request = {
      'showUser': true
    }; // Mostrar unicamente los estados permitidos a usuarios

    try {
      var url = Uri.http('$kCeroBachesEndPoint:$kCeroBachesPort',
          '/api/micro-incidences/get-active-incidence-status');

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request),
      );

      if (response.statusCode == 200) {
        var types =
            statusResponseFromJson(utf8.decode(response.body.codeUnits));
        return types;
      } else {
        return StatusResponse(
            ok: false, message: 'Error al obtener los datos', status: []);
      }
    } on http.ClientException catch (e) {
      debugPrint('ClientException: ${e.toString()}');
      return StatusResponse(ok: false, message: e.toString(), status: []);
    } on SocketException catch (e) {
      debugPrint('SocketException: ${e.toString()}');
      return StatusResponse(ok: false, message: e.toString(), status: []);
    } catch (e) {
      debugPrint('Exception: ${e.toString()}');
      return StatusResponse(ok: false, message: e.toString(), status: []);
    }
  }

  @override
  Future<StatusResponse> getStatusByRole() async {
    Map request = {'showEmployee': true};

    try {
      String tokenSession = await SessionManager().get(ceroBachesKey);

      var url = Uri.http('$kCeroBachesEndPoint:$kCeroBachesPort',
          '/api/micro-incidences/get-active-incidence-status-by-type-user');

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenSession'
        },
        body: jsonEncode(request),
      );

      if (response.statusCode == 200) {
        var types =
            statusResponseFromJson(utf8.decode(response.body.codeUnits));
        return types;
      } else {
        return StatusResponse(
            ok: false, message: 'Error al obtener los datos', status: []);
      }
    } catch (e) {
      return StatusResponse(ok: false, message: e.toString(), status: []);
    }
  }

  @override
  Future<NewIncidenceResponse?> createIncidence(
      Map<String, dynamic> request) async {
    try {

      // Construcción de la URL
      var url = Uri.http(
        '$kCeroBachesEndPoint:$kCeroBachesPort',
        '/api/micro-incidences/create-incidence',
        {
          'incidenceTypeId': request['incidenceTypeId'].toString(),
          'latitude': request['latitude'].toString(),
          'longitude': request['longitude'].toString(),
          'description': request['description'],

        },
      );

      // Preparación de la solicitud Multipart
      var multipartRequest = http.MultipartRequest('POST', url);

      // Verificar si el archivo fue proporcionado
      if (request['file'] != null && request['file'] is File) {
        File file = request['file'];

        // Verificar si el archivo existe
        if (await file.exists()) {
          multipartRequest.files.add(await http.MultipartFile.fromPath(
            'file',
            file.path,
            contentType: MediaType(
              'image',
              extension(file.path).replaceAll('.', ''),
            ),
          ));
        } else {
          debugPrint("El archivo no existe en la ruta: ${file.path}");
        }
      } else {
        debugPrint("El archivo no se ha proporcionado o es inválido.");
      }

      // Enviar la solicitud
      final response = await multipartRequest.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(responseBody);
        return NewIncidenceResponse.fromJson(jsonResponse);
      } else {
        debugPrint("Error en la respuesta: ${responseBody}");
        return null;
      }
    } catch (e) {
      debugPrint("Error en crear incidencia: $e");
      return null;
    }
  }

  // @override
  // Future<NewIncidenceResponse?> createIncidence(Map request) async {
  //   try {
  //     var url = Uri.http('$kCeroBachesEndPoint:$kCeroBachesPort',
  //         '/api/micro-incidences/create-incidence');

  //     var response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(request),
  //     );
  //     if (response.statusCode == 200) {
  //       final newIncidenceResponse =
  //           newIncidenceResponseFromJson(response.body);
  //       return newIncidenceResponse;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  @override
  Future<IncidenceTypeResponse> getAllIncidenceTypes() async {
    try {
      var url = Uri.http('$kCeroBachesEndPoint:$kCeroBachesPort',
          '/api/micro-incidences/get-all-active-incidence-types');

      var response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        var types =
            incidenceTypeResponseFromJson(utf8.decode(response.body.codeUnits));
        return types;
      } else {
        return IncidenceTypeResponse(
            ok: false, message: 'Error al obtener los datos', types: []);
      }
    } catch (e) {
      return IncidenceTypeResponse(ok: false, message: e.toString(), types: []);
    }
  }

  @override
  Future<CommonResponse?> reassignIncidence(
      Map<String, dynamic> request) async {
    try {
      String tokenSession = await SessionManager().get(ceroBachesKey);

      // Construcción de la URL
      var url = Uri.http(
        '$kCeroBachesEndPoint:$kCeroBachesPort',
        '/api/micro-incidences/reassign-incidence',
        {
          'incidenceTypeId': request['incidenceTypeId'].toString(),
          'incidenceId': request['incidenceId'].toString(),
          'comment': request['comment'],
        },
      );

      // Preparación de la solicitud Multipart
      var multipartRequest = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $tokenSession';

      // Verificar si el archivo fue proporcionado
      if (request['file'] != null && request['file'] is File) {
        File file = request['file'];

        // Verificar si el archivo existe
        if (await file.exists()) {
          multipartRequest.files.add(await http.MultipartFile.fromPath(
            'file',
            file.path,
            contentType: MediaType(
              'image',
              extension(file.path).replaceAll('.', ''),
            ),
          ));
        } else {
          debugPrint("El archivo no existe en la ruta: ${file.path}");
        }
      } else {
        debugPrint("El archivo no se ha proporcionado o es inválido.");
      }

      // Enviar la solicitud
      final response = await multipartRequest.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(responseBody);
        return CommonResponse.fromJson(jsonResponse);
      } else {
        debugPrint("Error en la respuesta: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error en reassignIncidence: $e");
      return null;
    }
  }



  // @override
  // Future<CommonResponse?> reassignIncidence(Map request) async {
  //   try {
  //     String tokenSession = await SessionManager().get(ceroBachesKey);

  //     var url = Uri.http('$kCeroBachesEndPoint:$kCeroBachesPort',
  //         '/api/micro-incidences/reassign-incidence');

  //     var response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $tokenSession'
  //       },
  //       body: jsonEncode(request),
  //     );
  //     if (response.statusCode == 200) {
  //       final incidenceResponse = commonResponseFromJson(response.body);
  //       return incidenceResponse;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }


  @override
  Future<CommonResponse?> attendIncidence(
      Map<String, dynamic> request) async {
    try {
      String tokenSession = await SessionManager().get(ceroBachesKey);

      // Construcción de la URL
      var url = Uri.http(
        '$kCeroBachesEndPoint:$kCeroBachesPort',
        '/api/micro-incidences/attend-incidence',
        {
          'statusId': request['statusId'].toString(),
          'incidenceIds': request['incidenceIds'].toString(),
          'comment': request['comment'],
        },
      );

      // Preparación de la solicitud Multipart
      var multipartRequest = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $tokenSession';

      // Verificar si el archivo fue proporcionado
      if (request['file'] != null && request['file'] is File) {
        File file = request['file'];

        // Verificar si el archivo existe
        if (await file.exists()) {
          multipartRequest.files.add(await http.MultipartFile.fromPath(
            'file',
            file.path,
            contentType: MediaType(
              'image',
              extension(file.path).replaceAll('.', ''),
            ),
          ));
        } else {
          debugPrint("El archivo no existe en la ruta: ${file.path}");
        }
      } else {
        debugPrint("El archivo no se ha proporcionado o es inválido.");
      }

      // Enviar la solicitud
      final response = await multipartRequest.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(responseBody);
        return CommonResponse.fromJson(jsonResponse);
      } else {
        debugPrint("Error en la respuesta: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error en reassignIncidence: $e");
      return null;
    }
  }

  // @override
  // Future<CommonResponse?> attendIncidence(Map request) async {
  //   try {
  //     String tokenSession = await SessionManager().get(ceroBachesKey);
  //     var url = Uri.http('$kCeroBachesEndPoint:$kCeroBachesPort',
  //         '/api/micro-incidences/attend-incidence');

  //     var response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $tokenSession'
  //       },
  //       body: jsonEncode(request),
  //     );

  //     if (response.statusCode == 200) {
  //       final commonResponse = commonResponseFromJson(response.body);
  //       return commonResponse;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // Inicio login keycloak
  @override
  Future<KeyCloackSesion?> loginKeycloak(
      String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_tokenUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'client_id': kClientId,
          'client_secret': kClientSecret,
          'grant_type': 'password',
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final sessionResponse = keyCloackSesionFromJson(response.body);
        return sessionResponse;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  // Fin login keycloak

  @override
  Future<UserAccount?> getUserAccount(String token) async {
    try {
      var url = Uri.http('$kCeroBachesEndPoint:$kGatewayPort', '/api/account');

      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        var account =
            usserAccountFromJson(utf8.decode(response.body.codeUnits));
        return account;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Tourism *********************************************************************

  @override
  Future<ItemsResponse> getItemsByCatalogCode(CommonRequest request) async {
    try {
      var url = Uri.http('$kTourisCultureEndPoint:$kTourisCulturePort',
          '/api/micro-tourismculture/items-by-catalog-code');

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        var items = itemsResponseFromJson(utf8.decode(response.body.codeUnits));
        return items;
      } else {
        return ItemsResponse(
            ok: false, message: 'Error al obtener los datos', items: []);
      }
    } on http.ClientException catch (e) {
      debugPrint('ClientException: ${e.toString()}');
      return ItemsResponse(ok: false, message: e.toString(), items: []);
    } on SocketException catch (e) {
      debugPrint('SocketException: ${e.toString()}');
      return ItemsResponse(ok: false, message: e.toString(), items: []);
    } catch (e) {
      debugPrint('Exception: ${e.toString()}');
      return ItemsResponse(ok: false, message: e.toString(), items: []);
    }
  }

  @override
  Future<RoutesResponse> getRoutesByCategory(IdRequest request) async {
    try {
      var url = Uri.http('$kTourisCultureEndPoint:$kTourisCulturePort',
          '/api/micro-tourismculture/get-all-active-routes-by-category');

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        var routes =
            routesResponseFromJson(utf8.decode(response.body.codeUnits));
        return routes;
      } else {
        return RoutesResponse(
            ok: false, message: 'Error al obtener los datos', fullRoutes: []);
      }
    } on http.ClientException catch (e) {
      debugPrint('ClientException: ${e.toString()}');
      return RoutesResponse(ok: false, message: e.toString(), fullRoutes: []);
    } on SocketException catch (e) {
      debugPrint('SocketException: ${e.toString()}');
      return RoutesResponse(ok: false, message: e.toString(), fullRoutes: []);
    } catch (e) {
      debugPrint('Exception: ${e.toString()}');
      return RoutesResponse(ok: false, message: e.toString(), fullRoutes: []);
    }
  }

  @override
  Future<RouteResponse> getTourismRouteById(IdRequest request) async {
    try {
      var url = Uri.http('$kTourisCultureEndPoint:$kTourisCulturePort',
          '/api/micro-tourismculture/find-tourism-route-by-id');

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        var route = routeResponseFromJson(utf8.decode(response.body.codeUnits));
        return route;
      } else {
        return RouteResponse(
            ok: false,
            message: 'Error al obtener los datos',
            tourismRoute: null);
      }
    } on http.ClientException catch (e) {
      debugPrint('ClientException: ${e.toString()}');
      return RouteResponse(
          ok: false, message: e.toString(), tourismRoute: null);
    } on SocketException catch (e) {
      debugPrint('SocketException: ${e.toString()}');
      return RouteResponse(
          ok: false, message: e.toString(), tourismRoute: null);
    } catch (e) {
      debugPrint('Exception: ${e.toString()}');
      return RouteResponse(
          ok: false, message: e.toString(), tourismRoute: null);
    }
  }

  @override
  Future<LocalityResponse> getLocalityById(IdRequest request) async {
    try {
      var url = Uri.http('$kTourisCultureEndPoint:$kTourisCulturePort',
          '/api/micro-tourismculture/find-locality-by-id');

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        var locality =
            localityResponseFromJson(utf8.decode(response.body.codeUnits));
        return locality;
      } else {
        return LocalityResponse(
            ok: false,
            message: 'Error al obtener los datos',
            fullLocality: null);
      }
    } on http.ClientException catch (e) {
      debugPrint('ClientException: ${e.toString()}');
      return LocalityResponse(
          ok: false, message: e.toString(), fullLocality: null);
    } on SocketException catch (e) {
      debugPrint('SocketException: ${e.toString()}');
      return LocalityResponse(
          ok: false, message: e.toString(), fullLocality: null);
    } catch (e) {
      debugPrint('Exception: ${e.toString()}');
      return LocalityResponse(
          ok: false, message: e.toString(), fullLocality: null);
    }
  }

  @override
  Future<LocalityListResponse> getLocalitiesByFilter(
      LocalityFilterRequest request) async {
    try {
      var url = Uri.http('$kTourisCultureEndPoint:$kTourisCulturePort',
          '/api/micro-tourismculture/get-active-localities-by-filters');

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        var localities =
            localityListResponseFromJson(utf8.decode(response.body.codeUnits));
        return localities;
      } else {
        return LocalityListResponse(
            ok: false,
            message: 'Error al obtener los datos',
            fullLocalities: []);
      }
    } on http.ClientException catch (e) {
      debugPrint('ClientException: ${e.toString()}');
      return LocalityListResponse(
          ok: false, message: e.toString(), fullLocalities: []);
    } on SocketException catch (e) {
      debugPrint('SocketException: ${e.toString()}');
      return LocalityListResponse(
          ok: false, message: e.toString(), fullLocalities: []);
    } catch (e) {
      debugPrint('Exception: ${e.toString()}');
      return LocalityListResponse(
          ok: false, message: e.toString(), fullLocalities: []);
    }
  }

  @override
  Future<ParishListResponse> getParishesByCantonCode(
      CommonRequest request) async {
    try {
      var url = Uri.http('$kTourisCultureEndPoint:$kTourisCulturePort',
          '/api/micro-tourismculture/parish-by-code');

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        var routes =
            parishListResponseFromJson(utf8.decode(response.body.codeUnits));
        return routes;
      } else {
        return ParishListResponse(
            ok: false, message: 'Error al obtener los datos', parishes: []);
      }
    } on http.ClientException catch (e) {
      debugPrint('ClientException: ${e.toString()}');
      return ParishListResponse(ok: false, message: e.toString(), parishes: []);
    } on SocketException catch (e) {
      debugPrint('SocketException: ${e.toString()}');
      return ParishListResponse(ok: false, message: e.toString(), parishes: []);
    } catch (e) {
      debugPrint('Exception: ${e.toString()}');
      return ParishListResponse(ok: false, message: e.toString(), parishes: []);
    }
  }

  // Método para obtener la imagen como Uint8List
  @override
  Future<Uint8List?> getAlfrescoImageData(String fileId) async {
    var url = Uri.http('$kCeroBachesEndPoint:$kCeroBachesPort',
        '/api/micro-incidences/proxy/files/$fileId');
    try {
      String tokenSession = await SessionManager().get(ceroBachesKey);

      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenSession'
        },
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
