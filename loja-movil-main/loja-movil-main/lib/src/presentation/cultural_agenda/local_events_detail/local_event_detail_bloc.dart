import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
import 'package:loja_movil/src/domain/usecase/local_event_detail_usecase.dart';

class LocalEventDetailBLoC extends ChangeNotifier {
  final LocalEventDetailUseCase useCase;
  bool loading = false;
  Lugar? lugar;

  List<Evento> eventos = [];

  LocalEventDetailBLoC({
    required this.useCase,
  });

  init(int lugarId) async {
    loading = true;
    notifyListeners();
    lugar = await useCase.getLugarEvents(lugarId);
    eventos = lugar!.eventos!;
    loading = false;
    notifyListeners();
  }
}
