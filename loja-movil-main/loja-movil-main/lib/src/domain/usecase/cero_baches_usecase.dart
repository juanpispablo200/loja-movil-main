import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/response/Keycloak_session_response.dart';
import 'package:loja_movil/src/domain/response/common_response.dart';
import 'package:loja_movil/src/domain/response/incidence_type_response.dart';
import 'package:loja_movil/src/domain/response/incidences_response.dart';
import 'package:loja_movil/src/domain/response/status_response.dart';
import 'package:loja_movil/src/domain/response/new_incidence_response.dart';
import 'package:loja_movil/src/domain/response/user_account_response.dart';

class CeroBachesUseCase {
  final ApiRepository apiRepositoryInterface;

  CeroBachesUseCase({
    required this.apiRepositoryInterface,
  });

  Future<IncidenceResponse> getIncidencesToShowUser() async {
    return await apiRepositoryInterface.getIncidencesToShowUser();
  }

  Future<IncidenceResponse> getIncidencesByRoleAndStatus(List<int> incidenceStatus) async {
    return await apiRepositoryInterface.getIncidencesByRoleAndStatus(incidenceStatus);
  }

  Future<StatusResponse> getUserStatus() async {
    return await apiRepositoryInterface.getUserStatus();
  }

  Future<StatusResponse> getStatusByRole() async {
    return await apiRepositoryInterface.getStatusByRole();
  }

  Future<NewIncidenceResponse?> createIncidence(
      Map<String, dynamic> request) async {
    return await apiRepositoryInterface.createIncidence(request);
  }

  Future<IncidenceTypeResponse> getAllIncidenceTypes() async {
    return await apiRepositoryInterface.getAllIncidenceTypes();
  }

  Future<CommonResponse?> reassignIncidence(Map<String, dynamic> request) async {
    return await apiRepositoryInterface.reassignIncidence(request);
  }

  Future<CommonResponse?> attendIncidence(Map<String, dynamic> request) async {
    return await apiRepositoryInterface.attendIncidence(request);
  }

  Future<KeyCloackSesion?> loginKeycloak(String username, String password) async {
    return await apiRepositoryInterface.loginKeycloak(username, password);
  }

   Future<UserAccount?> getUserAccount(String token) async {
    return await apiRepositoryInterface.getUserAccount(token);
  }
}
