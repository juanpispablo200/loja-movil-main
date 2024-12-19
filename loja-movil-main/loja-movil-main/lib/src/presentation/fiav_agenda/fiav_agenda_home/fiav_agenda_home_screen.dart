import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/presentation/home/home_screen.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/model/dto/event_fav_detail_dto.dart';
import 'package:loja_movil/src/presentation/common/empty_data.widget.dart';
import 'package:loja_movil/src/domain/usecase/fiav_agenda_home_usecase.dart';
import 'package:loja_movil/src/presentation/common/local_fav_card.widget.dart';
import 'package:loja_movil/src/presentation/common/festival_counter.widget.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_local_response.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/fiav_agenda_home/fiav_agenda_home_bloc.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/locals_fiav_home/locals_fiav_home_screen.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/events_fiav_list/events_fiav_list_screen.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/event_detail_fiav/event_detail_fiav_screen.dart';

class FiavAgendaHomeScreen extends StatelessWidget {
  const FiavAgendaHomeScreen._();

  static Widget init(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FiavAgendaHomeBLoC(
              useCase: FiavAgendaHomeUseCase(
            apiRepositoryInterface: context.read<ApiRepository>(),
          ))
            ..init(),
          builder: (_, __) => const FiavAgendaHomeScreen._(),
        ),
      ],
    );
  }

  static const routeName = '/home-fiav';
  static const String name = 'home-fiav-screen';

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<FiavAgendaHomeBLoC>();

    var currentDate = DateTime.now();
    var difference = fechaObjetivo.difference(currentDate);
    var days = difference.inDays;

    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 180.0,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(children: [
                  Image.asset(
                    'assets/images/banner_fiav_2024.png',
                    fit: BoxFit.cover,
                    height: 170.0,
                    width: MediaQuery.of(context).size.width,
                  ),
                  PreferredSize(
                    preferredSize: const Size.fromHeight(4.0),
                    child: Container(
                      color: kFavPrimary,
                      height: 4.0,
                    ),
                  ),
                ]),
              ),
              Positioned(
                top: 45.0,
                left: 20.0,
                child: Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: kFavPrimary,
                        shape: CircleBorder(),
                      ),
                      child: SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: Center(
                          child: IconButton.filledTonal(
                            padding: const EdgeInsets.only(right: 3.0),
                            iconSize: 18.0,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(kFavPrimary),
                            ),
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                            onPressed: () => context.go(HomeScreen.routeName),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SafeArea(
            bottom: true,
            top: false,
            child: bloc.loading
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.green,
                            child: Center(
                              child: Text(
                                'Item $index',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : (days > 0 && bloc.eventsAux.isEmpty)
                    ? Center(
                        child: FestivalCounter(days: days),
                      )
                    : CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                SizedBox(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.45,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .cultureFiavLocalities,
                                              style: const TextStyle(
                                                color: kFavPrimary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: const TextStyle(
                                                    fontSize: 20.0),
                                              ),
                                              onPressed: () {
                                                context.push(
                                                    LocalsFiavHomeScreen
                                                        .routeName);
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .commonSeeAll,
                                                style: const TextStyle(
                                                  color: kFavPrimary,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: (bloc.locals.isNotEmpty)
                                              ? ListView.separated(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    LocalFav local =
                                                        bloc.locals[index];
                                                    return LocalFavCard(
                                                      local: local,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.45,
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const SizedBox(
                                                      width: 10.0,
                                                    );
                                                  },
                                                  itemCount: bloc.locals.length,
                                                )
                                              : EmptyData(
                                                  title: AppLocalizations.of(
                                                          context)!
                                                      .cultureNoLocalities),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .cultureFiavEvents,
                                        style: const TextStyle(
                                          color: kFavPrimary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle:
                                              const TextStyle(fontSize: 20.0),
                                        ),
                                        onPressed: () {
                                          context.push(
                                              EventsFiavListScreen.routeName);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .commonSeeAll,
                                          style: const TextStyle(
                                            color: kFavPrimary,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          bloc.eventsAux.isNotEmpty
                              ? SliverPadding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  sliver: SliverGrid(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.0,
                                      crossAxisSpacing: 15.0,
                                      mainAxisSpacing: 15.0,
                                    ),
                                    delegate: SliverChildListDelegate(
                                      bloc.eventsAux.map(
                                        (act) {
                                          return GestureDetector(
                                            onTap: () {
                                              EventFavDetailDTO ev =
                                                  EventFavDetailDTO(
                                                direccion: act.direccion,
                                                duracion: act.duracion,
                                                entrada: act.entrada,
                                                horaFin: act.horaFin,
                                                horaInicio: act.horaInicio,
                                                icono: act.icono,
                                                imagen: act.imagen,
                                                nombreEvento: act.nombreEvento,
                                                ponente: act.ponente,
                                                procedencia: act.procedencia,
                                                tipo: act.tipo,
                                                dia: act.dia,
                                              );
                                              context.push(
                                                  EventDetailFiavScreen
                                                      .routeName,
                                                  extra: ev);
                                            },
                                            child: Material(
                                              elevation: 2.0,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Stack(
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        8.0),
                                                              ),
                                                              child: FittedBox(
                                                                fit:
                                                                    BoxFit.fill,
                                                                child: Image
                                                                    .network(
                                                                  '${kUrlBackEnd}event/FAV/${act.imagen}',
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            left: 8.0,
                                                            top: 8.0,
                                                            child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color:
                                                                    kFavSecondary,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  vertical: 3.0,
                                                                  horizontal:
                                                                      10.0,
                                                                ),
                                                                child: Text(
                                                                  act.entrada,
                                                                  style:
                                                                      const TextStyle(
                                                                    color:
                                                                        kFavPrimary,
                                                                    fontSize:
                                                                        10.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 60.0,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 35.0,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  act.ma
                                                                      .substring(
                                                                          0, 3)
                                                                      .toUpperCase(),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    color:
                                                                        kFavPrimary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                Text(
                                                                  act.nu
                                                                      .padLeft(
                                                                          2,
                                                                          '0'),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    color:
                                                                        kFavSecondary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          VerticalDivider(
                                                            width: 8.0,
                                                            thickness: 1.0,
                                                            indent: 3.0,
                                                            endIndent: 3.0,
                                                            color: kBlackColor
                                                                .withOpacity(
                                                                    0.4),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .stretch,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  act.nombreEvento,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    color:
                                                                        kBlackColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  act.lugar,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    color:
                                                                        kBlackColor,
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Text(
                                                                  act.horaInicio,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    color:
                                                                        kFavPrimary,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                )
                              : SliverList(
                                  delegate: SliverChildListDelegate([
                                  EmptyData(
                                      title: AppLocalizations.of(context)!
                                          .cultureNoEvents),
                                ])),
                          SliverList(
                              delegate: SliverChildListDelegate([
                            const SizedBox(
                              height: 20.0,
                            )
                          ]))
                        ],
                      ),
          ),
        )
      ],
    ));
  }
}
