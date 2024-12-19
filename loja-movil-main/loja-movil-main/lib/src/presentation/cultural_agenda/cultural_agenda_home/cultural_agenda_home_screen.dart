import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/presentation/home/home_screen.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/presentation/common/empty_data.widget.dart';
import 'package:loja_movil/src/presentation/common/lugar_card.widget.dart';
import 'package:loja_movil/src/domain/response/lugars_with_events_response.dart';
import 'package:loja_movil/src/domain/usecase/cultural_agenda_home_usecase.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/events/events_screen.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/locals_home/locals_home_screen.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/event_detail/event_detail_screen.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/cultural_agenda_home/cultural_agenda_home_bloc.dart';

class CulturalAgendaHomeScreen extends StatelessWidget {
  const CulturalAgendaHomeScreen._();

  static Widget init(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CulturalAgendaHomeBLoC(
            useCase: CulturalAgendaHomeUseCase(
              apiRepositoryInterface: context.read<ApiRepository>(),
            ),
          )..init(),
          builder: (_, __) => const CulturalAgendaHomeScreen._(),
        ),
      ],
    );
  }

  static const routeName = '/home-agenda';
  static const String name = 'cutural-home-screen';

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CulturalAgendaHomeBLoC>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cultureTitle,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Image.asset(
              'assets/images/escudo.png',
              height: 40,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            context.go(HomeScreen.routeName);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.cultureFiavLocalities,
                        style: const TextStyle(
                          color: kBlackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          context.push(LocalsHomeScreen.routeName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.commonSeeAll,
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: bloc.loading
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 190.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  margin: const EdgeInsets.all(6.0),
                                  child: const Center(
                                    child: SizedBox.shrink(),
                                  ),
                                );
                              },
                            ),
                          )
                        : (bloc.lugars.isNotEmpty)
                            ? ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  LugarDTO lugar = bloc.lugars[index];
                                  return LugarCard(
                                    lugar: lugar,
                                    width: 190,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                                itemCount: bloc.lugars.length,
                              )
                            : EmptyData(
                                title: AppLocalizations.of(context)!
                                    .cultureNoLocalities),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.cultureFiavEvents,
                        style: const TextStyle(
                          color: kBlackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          context.push(EventsScreen.routeName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.commonSeeAll,
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: bloc.loading
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 1,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 15.0,
                              ),
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 1.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const SizedBox(height: 80),
                                );
                              },
                            ),
                          )
                        : (bloc.followingActivities.isNotEmpty)
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 15.0,
                                  mainAxisSpacing: 15.0,
                                ),
                                itemCount: bloc.followingActivities.length,
                                itemBuilder: (context, index) {
                                  Evento act = bloc.followingActivities[index];
                                  return GestureDetector(
                                    onTap: () {
                                      context.push(EventDetailScreen.routeName,
                                          extra: act);
                                    },
                                    child: Material(
                                      elevation: 0.1,
                                      borderRadius: BorderRadius.circular(8.0),
                                      shadowColor: const Color.fromARGB(
                                              255, 215, 215, 215)
                                          .withOpacity(0.2),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 251, 251, 251),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                      255, 186, 186, 186)
                                                  .withOpacity(0.3),
                                              blurRadius: 8.0,
                                              spreadRadius: 2.0,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .vertical(
                                                        top: Radius.circular(8),
                                                      ),
                                                      child: FittedBox(
                                                        fit: BoxFit.fill,
                                                        child: Image.network(
                                                          '${kUrlBackEnd}event/AC/${act.imagen}',
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
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 0, 0, 0),
                                                          width: 1.2,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(5),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 3,
                                                          horizontal: 10,
                                                        ),
                                                        child: Text(
                                                          act.costo == '0'
                                                              ? AppLocalizations
                                                                      .of(context)!
                                                                  .cultureFree
                                                              : '${act.costo}',
                                                          style:
                                                              const TextStyle(
                                                            color: kBlackColor,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 60,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 35,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          toBeginningOfSentenceCase(
                                                            act.fechaInfo!.mes
                                                                .substring(
                                                                    0, 3),
                                                          )!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                kSecondaryColor,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Text(
                                                          act.fechaInfo!
                                                              .diaNumero
                                                              .padLeft(2, '0'),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                    width: 8,
                                                    thickness: 1,
                                                    indent: 3,
                                                    endIndent: 3,
                                                    color: kBlackColor
                                                        .withOpacity(0.4),
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: kBlackColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 8.0,
                                                        ),
                                                        Text(
                                                          act.hora!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 11,
                                                            color:
                                                                kPrimaryColor,
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
                              )
                            : EmptyData(
                                title: AppLocalizations.of(context)!
                                    .cultureNoEvents),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
