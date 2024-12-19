import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/response/lugars_with_events_response.dart';
import 'package:loja_movil/src/domain/usecase/cultural_agenda_home_usecase.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
class CulturalAgendaHomeBLoC extends ChangeNotifier {
  final CulturalAgendaHomeUseCase useCase;

  List<LugarDTO> lugars = [];
  List<Evento> followingActivities = [];
  bool loading = false;

  CulturalAgendaHomeBLoC({
    required this.useCase,
  });

  init() async {
    try {
      loading = true;
      notifyListeners();
      lugars = await useCase.getLugarsInfo(limit: 5);
      followingActivities = await useCase.getFollowingActivities();
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
    }
  }
}
