import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';

class LocalEventDetailUseCase {
  final ApiRepository apiRepositoryInterface;

  LocalEventDetailUseCase({
    required this.apiRepositoryInterface,
  });

  Future<Lugar?> getLugarEvents(int id) async {
    return await apiRepositoryInterface.getLugarEvents(id);
  }
}
