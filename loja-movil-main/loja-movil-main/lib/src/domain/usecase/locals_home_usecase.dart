import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/response/lugars_with_events_response.dart';

class LocalsHomeUseCase {
  final ApiRepository apiRepositoryInterface;

  LocalsHomeUseCase({
    required this.apiRepositoryInterface,
  });

  Future<List<LugarDTO>> getLugarsInfo({int? limit}) async {
    return await apiRepositoryInterface.getLugarsInfo(limit: limit);
  }
}
