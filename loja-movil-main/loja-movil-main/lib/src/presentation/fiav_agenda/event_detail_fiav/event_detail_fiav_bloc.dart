import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja_movil/src/domain/model/dto/event_fav_detail_dto.dart';

class EventDeatilFiavBLoc extends ChangeNotifier {
  late EventFavDetailDTO evento;

  DateFormat formatDateOnlyDate = DateFormat('yyyy-MM-dd');

  init(EventFavDetailDTO evento) {
    this.evento = evento;
  }
}
