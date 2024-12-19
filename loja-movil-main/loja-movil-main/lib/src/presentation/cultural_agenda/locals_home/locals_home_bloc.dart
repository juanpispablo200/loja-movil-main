import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/response/lugars_with_events_response.dart';
import 'package:loja_movil/src/domain/usecase/locals_home_usecase.dart';

class LocalsHomeBLoC extends ChangeNotifier {
  final LocalsHomeUseCase useCase;

  List<LugarDTO> lugars = [];

  List<LugarDTO> lugarFiltered = [];

  String _criteria = '';

  LocalsHomeBLoC({
    required this.useCase,
  });

  init() async {
    try {
      lugars = await useCase.getLugarsInfo();
      lugarFiltered = [...lugars];
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void setCriteria(String value) {
    _criteria = value;

    filterSearchResults(_criteria);
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      lugarFiltered = [...lugars];
    } else {
      lugarFiltered = lugars
          .where(
              (item) => item.nombre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
