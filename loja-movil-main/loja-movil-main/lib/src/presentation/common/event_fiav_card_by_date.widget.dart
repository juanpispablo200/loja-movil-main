import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/model/dto/event_fav_aux_dto.dart';
import 'package:loja_movil/src/domain/model/dto/event_fav_detail_dto.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/event_detail_fiav/event_detail_fiav_screen.dart';

class EventFiavCardByDate extends StatelessWidget {
  const EventFiavCardByDate({
    super.key,
    required this.event,
  });

  final EventFavAuxDTO event;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 165.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        border: Border.all(
          color: kFavSecondary,
          width: 2.0,
        ),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                child: Image.network(
                  '${kUrlBackEnd}event/FAV/${event.imagen}',
                  fit: BoxFit.fill,
                  width: 160.0,
                  height: 165.0,
                ),
              ),
              Positioned(
                left: 8.0,
                top: 8.0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: kFavSecondary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 10,
                    ),
                    child: Text(
                      event.entrada,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    event.nombreEvento,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 20.0,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          event.dia,
                          style: const TextStyle(
                            color: kBlackColor,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_outlined,
                        size: 20.0,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          '${event.horaInicio.substring(0, 5)} a ${event.horaFin.substring(0, 5)}',
                          style: const TextStyle(
                            color: kBlackColor,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 25.0,
                        width: 50.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            backgroundColor: kFavPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                            ),
                          ),
                          onPressed: () {
                            EventFavDetailDTO ev = EventFavDetailDTO(
                              direccion: event.direccion,
                              duracion: event.duracion,
                              entrada: event.entrada,
                              horaFin: event.horaFin,
                              horaInicio: event.horaInicio,
                              icono: event.icono,
                              imagen: event.imagen,
                              nombreEvento: event.nombreEvento,
                              ponente: event.ponente,
                              procedencia: event.procedencia,
                              tipo: event.tipo,
                              dia: event.dia,
                            );
                            context.push(EventDetailFiavScreen.routeName,
                                extra: ev);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.commonSeeDetail,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
