import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/event_detail/event_detail_screen.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.evento,
    this.showAddress = true,
  });

  final Evento evento;
  final bool showAddress;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.1,
      borderRadius: BorderRadius.circular(10.0),
      shadowColor: const Color.fromARGB(255, 215, 215, 215).withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 251, 251, 251),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 186, 186, 186).withOpacity(0.3),
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        height: 150.0,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.network(
                        '${kUrlBackEnd}event/AC/${evento.imagen}',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 10,
                      ),
                      child: Text(
                        evento.costo == '0' ? AppLocalizations.of(context)!
                                .cultureFree : '${evento.costo}',
                        style: const TextStyle(
                          color: kBlackColor,
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
                      evento.nombreEvento,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                size: 18.0,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  '${evento.inicio.diaMes} - ${evento.fin.diaMes}',
                                  style: const TextStyle(
                                      color: kBlackColor,
                                      fontWeight: FontWeight.w300),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          showAddress
                              ? Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 18.0,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        evento.lugar ?? '',
                                        style: const TextStyle(
                                            color: kBlackColor,
                                            fontWeight: FontWeight.w300),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          Row(
                            children: [
                              const Icon(
                                Icons.schedule_outlined,
                                size: 18.0,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                evento.hora!,
                                style: const TextStyle(
                                    color: kBlackColor,
                                    fontWeight: FontWeight.w300),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 25,
                                width: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                    backgroundColor: kPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        8,
                                      ), // <-- Radius
                                    ),
                                  ),
                                  onPressed: () {
                                    context.push(EventDetailScreen.routeName,
                                        extra: evento);
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
