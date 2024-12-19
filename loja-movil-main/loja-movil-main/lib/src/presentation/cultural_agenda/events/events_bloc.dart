import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:loja_movil/src/domain/usecase/events_usecase.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';

class EventsBLoC extends ChangeNotifier {
  final EventsUseCase useCase;

  int total = 0;
  List<Evento> eventos = [];
  bool loading = false;

  EventsBLoC({
    required this.useCase,
  });

  init() async {
    loading = true;
    notifyListeners();
    var resultAllEvents = await useCase.getEvents({
      'all': 'true',
    });

    if (resultAllEvents != null) {
      total = resultAllEvents.total;
      eventos = resultAllEvents.result;
    }
    loading = false;
    notifyListeners();
  }

  loadEvents(int index, DateTime? selectedDay) async {
    switch (index) {
      case 0:
        {
          loading = true;
          notifyListeners();
          var resultAllEvents = await useCase.getEvents({
            'all': 'true',
          });

          if (resultAllEvents != null) {
            total = resultAllEvents.total;
            eventos = resultAllEvents.result;
          }
          loading = false;
          notifyListeners();
          break;
        }
      case 1:
        {
          loading = true;
          notifyListeners();
          var resultAllEvents = await useCase.getEvents({
            'now': 'true',
          });

          if (resultAllEvents != null) {
            total = resultAllEvents.total;
            eventos = resultAllEvents.result;
          }
          loading = false;
          notifyListeners();
          break;
        }
      case 2:
        {
          loading = true;
          notifyListeners();
          var resultAllEvents = await useCase.getEvents({
            'next': 'true',
          });

          if (resultAllEvents != null) {
            total = resultAllEvents.total;
            eventos = resultAllEvents.result;
          }
          loading = false;
          notifyListeners();
          break;
        }
      case 3:
        {
          loading = true;
          notifyListeners();
          var resultAllEvents = await useCase.getEvents({
            'all': 'true',
          });

          if (resultAllEvents != null) {
            DateTime fechaFiltrar = selectedDay ?? DateTime.now();

            List<Evento> eventosFiltrados =
                resultAllEvents.result.where((evento) {
              return DateFormat('yyyy-MM-dd').format(fechaFiltrar) ==
                      DateFormat('yyyy-MM-dd').format(evento.fechaInicio) ||
                  DateFormat('yyyy-MM-dd').format(fechaFiltrar) ==
                      DateFormat('yyyy-MM-dd').format(evento.fechaFin) ||
                  (fechaFiltrar.isAfter(evento.fechaInicio) &&
                      fechaFiltrar.isBefore(evento.fechaFin));
            }).toList();

            total = eventosFiltrados.length;
            eventos = eventosFiltrados;
          }
          loading = false;
          notifyListeners();
          break;
        }
      default:
    }
  }
}
