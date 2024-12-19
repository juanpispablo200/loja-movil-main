import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/usecase/event_detail_usecase.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/event_detail/event_detail_bloc.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  static Widget init({
    required BuildContext context,
    required Evento evento,
  }) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EventDetailBLoC(
            useCase: EventDetailUseCase(
              apiRepositoryInterface: context.read<ApiRepository>(),
            ),
          )..init(evento),
          builder: (_, __) => const EventDetailScreen(),
        ),
      ],
    );
  }

  static const routeName = '/event-detail';
  static const String name = 'events-detail-screen';

  showMapModal(
    BuildContext context,
    String image,
  ) {
    showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        content: Builder(
          builder: (context) {
            return SizedBox(child: Image.network(image));
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.close,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 40,
              ))
        ],
        actionsPadding: const EdgeInsets.all(0),
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<EventDetailBLoC>();
    return LoadingView(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cultureFiavEventDetail,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Image.asset(
              'assets/images/escudo.png',
              height: 40.0,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Image.network(
                      '${kUrlBackEnd}event/AC/${bloc.evento.imagen}',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showMapModal(context,
                                      '${kUrlBackEnd}event/AC/${bloc.evento.imagen}');
                                },
                                icon: const Icon(
                                  Icons.fit_screen_outlined,
                                  color: Colors.white,
                                  size: 50,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              bloc.evento.nombreEvento,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 1,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InfoEventPairValue(
                            label: AppLocalizations.of(context)!.cultureEventDetailStartDate,
                            value: DateFormat("d 'de 'MMMM 'de' y", 'ES_EC')
                                .format(bloc.evento.fechaInicio),
                            icon: const Icon(
                              Icons.event_available_outlined,
                              size: 20,
                              color: kPrimaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          InfoEventPairValue(
                            label: AppLocalizations.of(context)!
                                .cultureEventDetailEndDate,
                            value: DateFormat("d 'de 'MMMM 'de' y", 'ES_EC')
                                .format(bloc.evento.fechaFin),
                            icon: const Icon(
                              Icons.event_busy_outlined,
                              size: 20,
                              color: kPrimaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          InfoEventPairValue(
                            label: AppLocalizations.of(context)!
                                .cultureEventDetailPlace,
                            value: bloc.evento.lugar == null
                                ? ''
                                : bloc.evento.lugar!,
                            icon: const Icon(
                              Icons.place_outlined,
                              size: 20,
                              color: kPrimaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          InfoEventPairValue(
                            label: AppLocalizations.of(context)!
                                .cultureEventDetailHour,
                            value: bloc.evento.hora!,
                            icon: const Icon(
                              Icons.watch_later_outlined,
                              size: 20.0,
                              color: kPrimaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          InfoEventPairValue(
                            label: AppLocalizations.of(context)!
                                .cultureEventDetailCost,
                            value: bloc.evento.costo == '0'
                                ? AppLocalizations.of(context)!
                                    .cultureFree
                                : bloc.evento.costo!,
                            icon: const Icon(
                              Icons.monetization_on_outlined,
                              size: 20,
                              color: kPrimaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          InfoEventPairValue(
                            label: AppLocalizations.of(context)!
                                .cultureEventDetailAddress,
                            value: bloc.evento.direccion,
                            icon: const Icon(
                              Icons.directions_outlined,
                              size: 20,
                              color: kPrimaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          InfoEventPairValue(
                            label: AppLocalizations.of(context)!
                                .cultureEventDetailOrganizer,
                            value: bloc.evento.organizador!,
                            icon: const Icon(
                              Icons.inventory_outlined,
                              size: 20,
                              color: kPrimaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InfoEventPairValue(
                            label: AppLocalizations.of(context)!
                                .cultureEventDetailType,
                            value: bloc.evento.tipo,
                            icon: const Icon(
                              Icons.type_specimen_outlined,
                              size: 20,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class InfoEventPairValue extends StatelessWidget {
  final String label;
  final String value;
  final Widget icon;

  const InfoEventPairValue({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(
            8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 0,
              child: icon,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Expanded(
              flex: 1,
              child: Text(
                '$label:',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ));
  }
}
