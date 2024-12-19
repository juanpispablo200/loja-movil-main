import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/model/dto/event_fav_aux_dto.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_dates_response.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_local_response.dart';
import 'package:loja_movil/src/domain/usecase/fiav_agenda_home_usecase.dart';

class FiavAgendaHomeBLoC extends ChangeNotifier {
  final FiavAgendaHomeUseCase useCase;

  bool loading = false;

  List<LocalFav> locals = [];

  List<EventoFavDTO> events = [];

  List<EventFavAuxDTO> eventsAux = [];

  FiavAgendaHomeBLoC({required this.useCase});

  init() async {
    try {
      loading = true;
      notifyListeners();

      locals = await useCase.getEventsFAVByLocal();
      if (locals.length >= 5) {
        locals = [...locals.sublist(0, 4)];
      }
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
          if (eventsAux.length <= 5) {
            eventsAux = [...eventsAux, ev];
          } else {
            break;
          }
        }
      }

      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
    }
  }
}
