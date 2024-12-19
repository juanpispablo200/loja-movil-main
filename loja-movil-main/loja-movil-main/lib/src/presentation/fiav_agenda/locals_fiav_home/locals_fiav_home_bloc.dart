import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/model/dto/event_fav_aux_dto.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_dates_response.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_local_response.dart';
import 'package:loja_movil/src/domain/usecase/fiav_locals_home_usecase.dart';

class LocalsFiavHomeBLoC extends ChangeNotifier {
  final FiavLocalsHomeUseCase useCase;

  bool loading = false;

  List<LocalFav> locals = [];

  List<LocalFav> localsFiltered = [];

  List<EventoFavDTO> events = [];

  List<EventFavAuxDTO> eventsAux = [];

  String _criteria = '';

  LocalsFiavHomeBLoC({required this.useCase});

  init() async {
    try {
      loading = true;
      notifyListeners();

      locals = await useCase.getEventsFAVByLocal();
      localsFiltered = [...locals];

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

  void setCriteria(String value) {
    _criteria = value;

    filterSearchResults(_criteria);
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      localsFiltered = [...locals];
    } else {
      localsFiltered = locals
          .where(
              (item) => item.nombre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
