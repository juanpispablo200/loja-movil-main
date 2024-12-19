import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/model/dto/event_fav_detail_dto.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_local_response.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/event_detail_fiav/event_detail_fiav_screen.dart';

class EventFiavCard extends StatelessWidget {
  const EventFiavCard({
    super.key,
    required this.evento,
    required this.local,
  });

  final EventoFAV evento;
  final LocalFav local;

  @override
  Widget build(BuildContext context) {
    DateFormat formatDateOnlyDate = DateFormat('yyyy-MM-dd');
    return Container(
      width: double.infinity,
      height: 160.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        border: Border.all(
          color: kFavSecondary,
          width: 1.0,
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
                  '${kUrlBackEnd}event/FAV/${evento.imagen}',
                  fit: BoxFit.fill,
                  width: 170.0,
                  height: 160.0,
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
                      vertical: 3.0,
                      horizontal: 10.0,
                    ),
                    child: Text(
                      evento.entrada,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
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
                    evento.nombreEvento,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10.0,
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
                          '${formatDateOnlyDate.format(evento.fechaInicio)} al ${formatDateOnlyDate.format(evento.fechaFin)}',
                          style: const TextStyle(
                            color: kBlackColor,
                            fontSize: 12.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
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
                          '${evento.horaInicio.substring(0, 5)} a ${evento.horaFin.substring(0, 5)}',
                          style: const TextStyle(
                            color: kBlackColor,
                            fontSize: 12.0,
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
                                direccion: local.direccion,
                                informacion: local.informacion,
                                duracion: evento.duracion,
                                entrada: evento.entrada,
                                horaFin: evento.horaFin,
                                horaInicio: evento.horaInicio,
                                icono: evento.icono,
                                imagen: evento.imagen,
                                nombreEvento: evento.nombreEvento,
                                ponente: evento.ponente,
                                procedencia: evento.procedencia,
                                tipo: evento.tipo,
                                fechaFin: evento.fechaFin,
                                fechaInicio: evento.fechaInicio);
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
