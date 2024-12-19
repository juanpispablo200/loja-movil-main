import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/domain/model/dto/event_fav_detail_dto.dart';
import 'package:loja_movil/src/presentation/common/fiav_app_bar.widget.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/event_detail_fiav/event_detail_fiav_bloc.dart';

class EventDetailFiavScreen extends StatelessWidget {
  const EventDetailFiavScreen._();

  static Widget init({
    required BuildContext context,
    required EventFavDetailDTO evento,
  }) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EventDeatilFiavBLoc()..init(evento),
          builder: (_, __) => const EventDetailFiavScreen._(),
        ),
      ],
    );
  }

  static const routeName = '/event-detail-fiav';
  static const String name = 'event-detail-fiav-screen';

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<EventDeatilFiavBLoc>();
    return LoadingView(
        appBar: FiavAppBar(
            title: AppLocalizations.of(context)!.cultureFiavEventDetail),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 200.0,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.5),
                          border: Border.all(
                            color: kFavPrimary,
                            width: 2.0,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.network(
                              '${kUrlBackEnd}event/FAV/${bloc.evento.imagen}',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 200.0,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                              0.5,
                              1.0,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(9.5),
                          border: Border.all(
                            color: kFavPrimary,
                            width: 2.0,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.0,
                        left: 10.0,
                        right: 10.0,
                        child: Text(
                          bloc.evento.nombreEvento,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.5),
                    border: Border.all(
                      color: kFavSecondary,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RichText(
                          text: TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.fiavEventDetailAddress}:  ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Avenir'),
                            children: [
                              TextSpan(
                                  text: bloc.evento.direccion,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Avenir')),
                            ],
                          ),
                        ),
                        Divider(
                          color: kFavPrimary.withOpacity(0.5),
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.fiavEventDetailSpeaker}:  ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Avenir'),
                            children: [
                              TextSpan(
                                  text: bloc.evento.ponente,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Avenir')),
                            ],
                          ),
                        ),
                        Divider(
                          color: kFavPrimary.withOpacity(0.5),
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.fiavEventDetailOrigin}:  ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Avenir'),
                            children: [
                              TextSpan(
                                  text: bloc.evento.procedencia,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Avenir')),
                            ],
                          ),
                        ),
                        Divider(
                          color: kFavPrimary.withOpacity(0.5),
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.fiavEventDetailType}:  ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Avenir'),
                            children: [
                              TextSpan(
                                  text: bloc.evento.tipo,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Avenir')),
                            ],
                          ),
                        ),
                        Divider(
                          color: kFavPrimary.withOpacity(0.5),
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.fiavEventDetailAvailability}:  ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Avenir'),
                            children: [
                              TextSpan(
                                  text: bloc.evento.entrada,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Avenir')),
                            ],
                          ),
                        ),
                        Divider(
                          color: kFavPrimary.withOpacity(0.5),
                        ),
                        bloc.evento.dia != null
                            ? RichText(
                                text: TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.fiavEventDetailDate}:  ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Avenir'),
                                  children: [
                                    TextSpan(
                                        text: bloc.evento.dia,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Avenir')),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                        bloc.evento.dia != null
                            ? Divider(
                                color: kFavPrimary.withOpacity(0.5),
                              )
                            : const SizedBox.shrink(),
                        bloc.evento.fechaInicio != null
                            ? RichText(
                                text: TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.fiavEventDetailStartDate}:  ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Avenir'),
                                  children: [
                                    TextSpan(
                                        text: bloc.formatDateOnlyDate
                                            .format(bloc.evento.fechaInicio!),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Avenir')),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                        bloc.evento.fechaInicio != null
                            ? Divider(
                                color: kFavPrimary.withOpacity(0.5),
                              )
                            : const SizedBox.shrink(),
                        bloc.evento.fechaFin != null
                            ? RichText(
                                text: TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.fiavEventDetailEndDate}:  ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Avenir'),
                                  children: [
                                    TextSpan(
                                        text: bloc.formatDateOnlyDate
                                            .format(bloc.evento.fechaFin!),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Avenir')),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                        bloc.evento.fechaInicio != null
                            ? Divider(
                                color: kFavPrimary.withOpacity(0.5),
                              )
                            : const SizedBox.shrink(),
                        RichText(
                          text: TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.fiavEventDetailStartTime}:  ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Avenir'),
                            children: [
                              TextSpan(
                                  text: bloc.evento.horaInicio.substring(0, 5),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Avenir')),
                            ],
                          ),
                        ),
                        Divider(
                          color: kFavPrimary.withOpacity(0.5),
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.fiavEventDetailEndTime}:  ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Avenir'),
                            children: [
                              TextSpan(
                                  text: bloc.evento.horaFin.substring(0, 5),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Avenir')),
                            ],
                          ),
                        ),
                        Divider(
                          color: kFavPrimary.withOpacity(0.5),
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.fiavEventDetailDuration}:  ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Avenir'),
                            children: [
                              TextSpan(
                                  text: bloc.evento.duracion,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Avenir')),
                            ],
                          ),
                        ),
                        Divider(
                          color: kFavPrimary.withOpacity(0.5),
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.fiavEventDetailInfo}:  ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Avenir'),
                            children: [
                              TextSpan(
                                  text: bloc.evento.informacion,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Avenir')),
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
        ));
  }
}
