import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
import 'package:loja_movil/src/domain/response/lugars_with_events_response.dart';

class CulturalAgendaHomeUseCase {
  final ApiRepository apiRepositoryInterface;

  CulturalAgendaHomeUseCase({
    required this.apiRepositoryInterface,
  });

  Future<List<LugarDTO>> getLugarsInfo({int? limit}) async {
    return await apiRepositoryInterface.getLugarsInfo(limit: limit);
  }

  Future<List<Evento>> getFollowingActivities() async {
    return await apiRepositoryInterface.getFollowingActivities();
  }
}
