import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/presentation/common/fiav_app_bar.widget.dart';
import 'package:loja_movil/src/presentation/common/event_fiav_card.widget.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_local_response.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/local_events_fiav_detail/local_events_fiav_detail_bloc.dart';

class LocalEventsFiavDetailScreen extends StatelessWidget {
  const LocalEventsFiavDetailScreen._();

  static Widget init({
    required BuildContext context,
    required LocalFav local,
  }) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocalEventsFiavDetailBloc()..init(local),
          builder: (_, __) => const LocalEventsFiavDetailScreen._(),
        ),
      ],
    );
  }

  static const routeName = '/local-events-fiav-detail';
  static const String name = 'local-events-fiav-detail-screen';

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LocalEventsFiavDetailBloc>();
    return LoadingView(
      appBar:
          FiavAppBar(title: AppLocalizations.of(context)!.cultureFiavLocality),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
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
                      borderRadius: BorderRadius.circular(8.0),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                          '${kUrlBackEnd}event/lugares/${bloc.local.ubicacion}',
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
                          0.3,
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
                    left: 20.0,
                    bottom: 45.0,
                    right: 5.0,
                    child: Text(
                      bloc.local.nombre,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15.0,
                    left: 20.0,
                    right: 5.0,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 7.0,
                        ),
                        Expanded(
                          child: Text(
                            bloc.local.direccion,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.search,
                  color: kFavSecondary,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  AppLocalizations.of(context)!.cultureFiavAvailableEvents,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: bloc.local.eventos.length,
                itemBuilder: (context, index) {
                  EventoFAV evento = bloc.local.eventos[index];
                  return EventFiavCard(
                    evento: evento,
                    local: bloc.local,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
