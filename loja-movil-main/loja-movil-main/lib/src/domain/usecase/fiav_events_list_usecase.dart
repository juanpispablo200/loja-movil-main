import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_dates_response.dart';

class FiavEventsListUsecase {
  final ApiRepository apiRepositoryInterface;

  FiavEventsListUsecase({required this.apiRepositoryInterface});

  Future<List<EventoFavDTO>> getEventsFAVByDates() {
    return apiRepositoryInterface.getEventsFAVByDates();
  }
}
