import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja_movil/src/domain/model/dto/event_fav_aux_dto.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_dates_response.dart';
import 'package:loja_movil/src/domain/usecase/fiav_events_list_usecase.dart';

class EventsFiavListBLoC extends ChangeNotifier {
  final FiavEventsListUsecase useCase;

  bool loading = false;

  List<EventoFavDTO> events = [];
  List<EventFavAuxDTO> originalEvents = [];
  List<EventFavAuxDTO> eventsAux = [];

  EventsFiavListBLoC({required this.useCase});

  init() async {
    try {
      loading = true;
      notifyListeners();

      events = await useCase.getEventsFAVByDates();

      for (var dates in events) {
        for (var event in dates.eventos) {
          EventFavAuxDTO ev = EventFavAuxDTO(
            dia: dates.dia,
            ma: dates.ma,
            di: dates.di,
            nu: dates.nu,
            lugar: event.lugar,
            direccion: event.direccion,
            latitude: event.latitude,
            longitude: event.longitude,
            nombreEvento: event.nombreEvento,
            horaInicio: event.horaInicio,
            horaFin: event.horaFin,
            ponente: event.ponente,
            procedencia: event.procedencia,
            tipo: event.tipo,
            icono: event.icono,
            imagen: event.imagen,
            entrada: event.entrada,
            duracion: event.duracion,
          );
          originalEvents = [...originalEvents, ev];
          eventsAux = [...eventsAux, ev];
        }
      }

      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
    }
  }

  getEventsByDate(DateTime date) {
    List<EventFavAuxDTO> newEvents = [];

    for (var element in originalEvents) {
      DateTime eventDate = DateFormat('dd MMMM, yyyy', 'es')
          .parse('${element.nu} ${element.ma}');
      if (DateTime(eventDate.year, eventDate.month, eventDate.day) ==
          DateTime(date.year, date.month, date.day)) {
        newEvents.add(element);
      }
      eventsAux = newEvents;
    }
    eventsAux = newEvents;
    notifyListeners();
  }

  getAllEvents() {
    eventsAux = originalEvents;
    notifyListeners();
  }
}
