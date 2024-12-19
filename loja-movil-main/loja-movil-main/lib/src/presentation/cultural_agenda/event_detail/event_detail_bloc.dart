import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
import 'package:loja_movil/src/domain/usecase/event_detail_usecase.dart';

class EventDetailBLoC extends ChangeNotifier {
  final EventDetailUseCase useCase;

  late Evento evento;

  EventDetailBLoC({
    required this.useCase,
  });

  init(Evento evento) async {
    this.evento = evento;
  }
}
