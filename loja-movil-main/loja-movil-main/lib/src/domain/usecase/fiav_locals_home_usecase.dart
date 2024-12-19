import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_dates_response.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_local_response.dart';

class FiavLocalsHomeUseCase {
  final ApiRepository apiRepositoryInterface;

  FiavLocalsHomeUseCase({required this.apiRepositoryInterface});

  Future<List<LocalFav>> getEventsFAVByLocal() {
    return apiRepositoryInterface.getEventsFAVByLocal();
  }

  Future<List<EventoFavDTO>> getEventsFAVByDates() {
    return apiRepositoryInterface.getEventsFAVByDates();
  }
}
