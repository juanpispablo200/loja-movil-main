import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/response/events_response.dart';

class EventsUseCase {
  final ApiRepository apiRepositoryInterface;
  EventsUseCase({
    required this.apiRepositoryInterface,
  });

  Future<EventsResponse?> getEvents(dynamic criteria) {
    return apiRepositoryInterface.getEvents(criteria);
  }
}
