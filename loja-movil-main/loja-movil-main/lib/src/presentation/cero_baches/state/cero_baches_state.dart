import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loja_movil/src/domain/response/status_response.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:loja_movil/src/domain/usecase/alfresco_usecase.dart';
import 'package:loja_movil/src/domain/usecase/cero_baches_usecase.dart';
import 'package:loja_movil/src/domain/response/incidences_response.dart';
import 'package:loja_movil/src/domain/response/department_response.dart';
import 'package:loja_movil/src/domain/response/user_account_response.dart';
import 'package:loja_movil/src/domain/response/new_incidence_response.dart';
import 'package:loja_movil/src/domain/response/incidence_type_response.dart';
import 'package:loja_movil/src/presentation/cero_baches/utils/constants.dart';

class CurrentPosition {
  double? longitude;
  double? latitude;

  CurrentPosition(this.longitude, this.latitude);
}

class CeroBachesStateBLoC extends ChangeNotifier {
  final SessionManager sessionManager = SessionManager();
  final CeroBachesUseCase useCase;
  final AlfrescoUseCase alfrescoUseCase;
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

  final TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;

  // Variables para la creación de incidencia
  NewIncidenceResponse? newIncidenceResponse;
  bool newIncidenceStatus = false;
  bool loadingNewIncidence = false;

  // Variables para la obtención de la posición
  String locationMessage = '';
  double? longitude;
  double? latitude;
  bool loadingPosition = false;

  // Variables para la cuenta de usuario
  UserAccount? userAccount;
  bool loadingAccount = false;

  // Variables para el login
  bool loadingLogin = false;
  bool isAuthenticated = false;

  // Variables para la asignación de incidencia
  bool loadingAssign = false;

  // Variables para la atención de incidencia
  bool loadingAttend = false;

  // Variables para los departamentos
  bool loadingDepartments = false;
  List<DepartmentResponse> allDepartments = [];
  DepartmentResponse? department;

  // Variables para el tipo de incidencia
  bool loadingIncidenceTypes = false;
  List<IncidenceType>? incidenceTypes = [];

  // Variables para el estado de la incidencia
  bool loadingUserStatus = false;
  List<IncidenceStatus> userStatus = [];
  bool loadingStatusByRole = false;
  List<IncidenceStatus> statusByRole = [];

  // Variables para las incidencias
  bool loadingUserIncidences = false;
  List<Incidence> userIncidences = [];
  bool loadingIncidencesByRole = false;
  List<Incidence> incidencesByRole = [];

  CeroBachesStateBLoC({required this.useCase, required this.alfrescoUseCase});

  Future<Uint8List?> getImageData(String imageId) async {
    var imageUrl = await alfrescoUseCase.getAlfrescoImageData(imageId);
    return imageUrl;
  }

  void fetchInit() async {
    try {
      await getUserStatus();
      await getIncidencesToShowUser();
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  void fetchAdminData() async {
    // Obtener los estados de las incidencias
    await getActiveStatusByRole();

    // Cuando se obtenga la respuesta de los estados, llamar a las incidencias
    await getIncidencesByRoleAndStatus();
  }

  void fetchDataUpdateIncidence() async {
    await getAllIncidenceTypes();
  }

  // Método para obtener los estados de los usuarios
  Future<void> getUserStatus() async {
    try {
      loadingUserStatus = true;
      notifyListeners();
      StatusResponse incidenceStatusRep = await useCase.getUserStatus();
      userStatus = incidenceStatusRep.status;
    } catch (e) {
      debugPrint('Error obteniendo los estados de usuarios: $e');
    } finally {
      loadingUserStatus = false;
      notifyListeners();
    }
  }

  // Método para obtener los estados de las incidencias por rol
  Future<void> getActiveStatusByRole() async {
    try {
      loadingStatusByRole = true;
      StatusResponse resp = await useCase.getStatusByRole();
      statusByRole = resp.status;
    } catch (e) {
      debugPrint('Error obteniendo los estados por rol: $e');
    } finally {
      loadingStatusByRole = false;
      notifyListeners();
    }
  }

  // Método para obtener las incidencias para mostrar al usuario
  Future<void> getIncidencesToShowUser() async {
    try {
      loadingUserIncidences = true;
      notifyListeners();
      IncidenceResponse resp = await useCase.getIncidencesToShowUser();
      userIncidences = resp.incidences;
    } catch (e) {
      debugPrint('Error obteniendo las incidencias para el usuario: $e');
    } finally {
      loadingUserIncidences = false;
      notifyListeners();
    }
  }

  // Método para recargar los datos
  Future<void> recargarDatos() async {
    try {
      await getUserStatus();
      await getIncidencesToShowUser();
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  // Método para obtener las incidencias por rol y estado
  Future<void> getIncidencesByRoleAndStatus() async {
    try {
      loadingIncidencesByRole = true;
      notifyListeners();
      List<int> statusId = statusByRole.map((e) => e.id).toList();
      IncidenceResponse resp =
          await useCase.getIncidencesByRoleAndStatus(statusId);
      incidencesByRole = resp.incidences;
    } catch (e) {
      debugPrint('Error obteniendo las incidencias por rol y estado: $e');
    } finally {
      loadingIncidencesByRole = false;
      notifyListeners();
    }
  }

  // Método para determinar la posición actual
  Future<void> determinePosition() async {
    try {
      loadingPosition = true;
      notifyListeners();

      final hasPermission = await handlePermission();
      if (!hasPermission) {
        return;
      }

      Position position = await geolocatorPlatform.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      locationMessage = 'Error determinando la posición: $e';
    } finally {
      loadingPosition = false;
      notifyListeners();
    }
  }

  // Método para manejar los permisos de ubicación
  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationMessage = 'El servicio de ubicación está desactivado';
      notifyListeners();
      return false;
    }

    permission = await geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        locationMessage = 'Permiso de ubicación denegado';
        notifyListeners();
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      locationMessage = 'Permiso de ubicación denegado permanentemente';
      notifyListeners();
      return false;
    }

    return true;
  }

  // Método para crear una nueva incidencia
  Future<bool> createIncidence(Map<String, dynamic> request) async {
    try {
      loadingNewIncidence = true;
      notifyListeners();

      newIncidenceResponse = await useCase.createIncidence(request);
      if (newIncidenceResponse != null) {
        newIncidenceStatus = newIncidenceResponse!.ok;
      }
      return newIncidenceStatus;
    } catch (e) {
      return false;
    } finally {
      loadingNewIncidence = false;
      notifyListeners();
    }
  }

  // Método para obtener la cuenta de usuario
  Future<void> getUserAccount() async {
    try {
      loadingAccount = true;
      notifyListeners();

      String? tokenSession = await sessionManager.get(ceroBachesKey);
      if (tokenSession == null || tokenSession.isEmpty) {
        isAuthenticated = false;
        return;
      }

      UserAccount? resAccount = await useCase.getUserAccount(tokenSession);
      userAccount = resAccount;
      isAuthenticated = resAccount != null;
    } catch (e) {
      debugPrint('Error obteniendo la cuenta de usuario: $e');
      isAuthenticated = false;
    } finally {
      loadingAccount = false;
      notifyListeners();
    }
  }

  // Método para realizar login en Keycloak
  Future<String?> loginKeycloak(String username, String password) async {
    try {
      loadingLogin = true;
      notifyListeners();

      await sessionManager.remove(ceroBachesKey);
      var sessionResult = await useCase.loginKeycloak(username, password);

      if (sessionResult != null) {
        await sessionManager.set(ceroBachesKey, sessionResult.accessToken);
        await getUserAccount();
        return 'Ok';
      }
      return null;
    } catch (e) {
      debugPrint('Error en el login: $e');
      return null;
    } finally {
      loadingLogin = false;
      notifyListeners();
    }
  }

  // Método para obtener todos los tipos de incidencias
  Future<void> getAllIncidenceTypes() async {
    try {
      loadingIncidenceTypes = true;
      IncidenceTypeResponse incidenceTypeRep =
          await useCase.getAllIncidenceTypes();
      incidenceTypes = incidenceTypeRep.types;
    } catch (e) {
      debugPrint('Error obteniendo los tipos de incidencias: $e');
    } finally {
      loadingIncidenceTypes = false;
      notifyListeners();
    }
  }

  // Método para reasignar una incidencia
  Future<bool> reassignIncidence(Map<String, dynamic> request) async {
    try {
      loadingAssign = true;
      notifyListeners();

      var response = await useCase.reassignIncidence(request);
      if (response != null && response.ok) {
        await getIncidencesByRoleAndStatus();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error reasignando la incidencia: $e');
      return false;
    } finally {
      loadingAssign = false;
      notifyListeners();
    }
  }

  // Método para atender una incidencia
  Future<bool> attendIncidence(Map<String, dynamic> request) async {
    try {
      loadingAttend = true;
      notifyListeners();

      var response = await useCase.attendIncidence(request);
      if (response != null && response.ok) {
        await getIncidencesByRoleAndStatus();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error atendiendo la incidencia: $e');
      return false;
    } finally {
      loadingAttend = false;
      notifyListeners();
    }
  }

  // Método para cerrar sesión
  Future<void> logout() async {
    await sessionManager.remove(ceroBachesKey);
    isAuthenticated = false;
    userAccount = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
