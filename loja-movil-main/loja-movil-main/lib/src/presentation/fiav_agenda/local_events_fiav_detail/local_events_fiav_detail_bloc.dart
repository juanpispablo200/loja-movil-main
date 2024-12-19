import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_local_response.dart';

class LocalEventsFiavDetailBloc extends ChangeNotifier {
  late LocalFav local;

  DateFormat formatDateOnlyDate = DateFormat('yyyy-MM-dd');

  init(LocalFav local) {
    this.local = local;
  }
}
