import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:loja_movil/src/utils/image_util.dart';
import 'package:loja_movil/src/utils/schedule_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/model/localities_filter.dart';
import 'package:loja_movil/src/domain/usecase/tourism_usecase.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/presentation/common/empty_data.widget.dart';
import 'package:loja_movil/src/presentation/tourism/localities_list/localities_list_bloc.dart';
import 'package:loja_movil/src/presentation/tourism/locality_route_detail/locality_route_detail_screen.dart';

class LocalitiesListHomeScreen extends StatefulWidget {
  const LocalitiesListHomeScreen._();

  static Widget init(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocalitiesListHomeBLoC(
              useCase: TourismUseCase(
            apiRepositoryInterface: context.read<ApiRepository>(),
          ))
            ..init(),
          builder: (_, __) => const LocalitiesListHomeScreen._(),
        ),
      ],
    );
  }

  static const routeName = '/localities-list-route';
  static const String name = 'localities-list-home-screen';

  @override
  State<LocalitiesListHomeScreen> createState() => _RouteMapScreen();
}

class _RouteMapScreen extends State<LocalitiesListHomeScreen> {
  int selectedIndex = -1;
  int selectedOption = 1;
  String selectedFilter = '';

  int? selectedParishId;
  int? selectedCategoryId;
  int? selectedRouteId;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LocalitiesListHomeBLoC>();

    List<LocaltiesFilter> filters = [
      LocaltiesFilter(id: 0, name: '', code: 'FIL_ALL', icon: 'tune'),
      LocaltiesFilter(
          id: 1,
          name: AppLocalizations.of(context)!.tourismParish,
          code: 'FIL_PARISH'),
      LocaltiesFilter(
          id: 2,
          name: AppLocalizations.of(context)!.tourismCategory,
          code: 'FIL_CATEGORY'),
      LocaltiesFilter(
          id: 3,
          name: AppLocalizations.of(context)!.tourismRoutes,
          code: 'FIL_ROUTES'),
    ];

    return LoadingView(
        isLoading: bloc.loadingLocalities ||
            bloc.loadingCategories ||
            bloc.loadingParishes ||
            bloc.loadingRoutes,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.tourismPlacesOfLoja,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.asset(
                'assets/images/turismo-loja.jpg',
                height: 45.0,
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        child: Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 37.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: filters.length,
                            itemBuilder: (context, index) {
                              bool isSelected = selectedIndex == index;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: isSelected
                                        ? kPrimaryColor
                                        : const Color.fromARGB(
                                            255, 246, 246, 246),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      selectedFilter = filters[index].code;
                                    });

                                    if (bloc.parishes.isEmpty) {
                                      await bloc.getParishesByCantonCode();
                                    }

                                    if (bloc.categories.isEmpty) {
                                      await bloc.getLocalityCategories();
                                    }

                                    if (bloc.routes.isEmpty) {
                                      await bloc.getRoutesByCatalog(null);
                                    }

                                    showModalBottomSheet<void>(
                                      // ignore: use_build_context_synchronously
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0)),
                                      ),
                                      builder: (context) {
                                        return StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter myState) {
                                          return DraggableScrollableSheet(
                                              expand: false,
                                              initialChildSize: 0.5,
                                              minChildSize: 0.3,
                                              maxChildSize: 0.8,
                                              builder:
                                                  (context, scrollController) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      // Título estático
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .tourismSearchFilters,
                                                          style: const TextStyle(
                                                              fontSize: 17.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      const Divider(),
                                                      Expanded(
                                                          child: ListView(
                                                        controller:
                                                            scrollController,
                                                        children: [
                                                          // Listado de parroquias para filtro ********************************************
                                                          if (selectedFilter ==
                                                                  'FIL_PARISH' ||
                                                              selectedFilter ==
                                                                  'FIL_ALL')
                                                            Column(
                                                              children: [
                                                                Align(
                                                                    alignment:
                                                                        AlignmentDirectional
                                                                            .centerStart,
                                                                    child: Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .tourismParish,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight:
                                                                              FontWeight.w800),
                                                                    )),
                                                                Column(
                                                                  children: bloc
                                                                      .parishes
                                                                      .map(
                                                                          (parish) {
                                                                    return RadioListTile<
                                                                        int>(
                                                                      title:
                                                                          Text(
                                                                        parish
                                                                            .name,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14.0),
                                                                      ),
                                                                      value:
                                                                          parish
                                                                              .id,
                                                                      groupValue:
                                                                          selectedParishId,
                                                                      onChanged:
                                                                          (value) {
                                                                        myState(
                                                                            () {
                                                                          selectedParishId =
                                                                              value;
                                                                        });
                                                                      },
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                                const SizedBox(
                                                                  height: 14.0,
                                                                ),
                                                              ],
                                                            ),

                                                          // Listado de categorias de localidad para filtro *************************************
                                                          if (selectedFilter ==
                                                                  'FIL_CATEGORY' ||
                                                              selectedFilter ==
                                                                  'FIL_ALL')
                                                            Column(children: [
                                                              Align(
                                                                  alignment:
                                                                      AlignmentDirectional
                                                                          .centerStart,
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .tourismCategory,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.w800),
                                                                  )),
                                                              Column(
                                                                children: bloc
                                                                    .categories
                                                                    .map(
                                                                        (category) {
                                                                  return RadioListTile<
                                                                      int>(
                                                                    title: Text(
                                                                      category
                                                                          .name,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14.0),
                                                                    ),
                                                                    value:
                                                                        category
                                                                            .id!,
                                                                    groupValue:
                                                                        selectedCategoryId,
                                                                    onChanged:
                                                                        (value) {
                                                                      myState(
                                                                          () {
                                                                        selectedCategoryId =
                                                                            value;
                                                                      });
                                                                    },
                                                                  );
                                                                }).toList(),
                                                              ),
                                                              const SizedBox(
                                                                height: 14.0,
                                                              ),
                                                            ]),

                                                          // Listado de rutas de localidad para filtro ****************************************
                                                          if (selectedFilter ==
                                                                  'FIL_ROUTES' ||
                                                              selectedFilter ==
                                                                  'FIL_ALL')
                                                            Column(children: [
                                                              Align(
                                                                  alignment:
                                                                      AlignmentDirectional
                                                                          .centerStart,
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .tourismRoutes,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.w800),
                                                                  )),
                                                              Column(
                                                                children: bloc
                                                                    .routes
                                                                    .map(
                                                                        (route) {
                                                                  return RadioListTile<
                                                                      int>(
                                                                    title: Text(
                                                                      route
                                                                          .name,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14.0),
                                                                    ),
                                                                    value: route
                                                                        .id,
                                                                    groupValue:
                                                                        selectedRouteId,
                                                                    onChanged:
                                                                        (value) {
                                                                      myState(
                                                                          () {
                                                                        selectedRouteId =
                                                                            value;
                                                                      });
                                                                    },
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ]),
                                                        ],
                                                      )),
                                                      const Divider(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width: 150.0,
                                                              child:
                                                                  ElevatedButton(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  fixedSize: Size(
                                                                      MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          1,
                                                                      45),
                                                                  backgroundColor:
                                                                      kSecondaryColor,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  myState(() {
                                                                    selectedParishId =
                                                                        null;
                                                                    selectedCategoryId =
                                                                        null;
                                                                    selectedRouteId =
                                                                        null;
                                                                  });
                                                                },
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .tourismClear,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 20.0,
                                                            ),
                                                            SizedBox(
                                                              width: 150.0,
                                                              child:
                                                                  ElevatedButton(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  fixedSize: Size(
                                                                      MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          1,
                                                                      45),
                                                                  backgroundColor:
                                                                      kPrimaryColor,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  if (selectedParishId != null ||
                                                                      selectedCategoryId !=
                                                                          null ||
                                                                      selectedRouteId !=
                                                                          null) {
                                                                    await bloc.getLocalitiesByFilter(
                                                                        selectedParishId,
                                                                        selectedCategoryId,
                                                                        selectedRouteId);

                                                                    setState(
                                                                        () {
                                                                      selectedIndex =
                                                                          index;
                                                                    });
                                                                  }

                                                                  Navigator.of(
                                                                      // ignore: use_build_context_synchronously
                                                                      context).pop();
                                                                },
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .tourismFilter,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        });
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      if (filters[index].icon != null)
                                        Icon(
                                          Icons.tune,
                                          size: 20.0,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      Text(
                                        filters[index].name,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 20.0,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ])),

///////////////////////////

                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Column(
                            children: bloc.parishes
                                .map((parish) {
                                  if (selectedParishId != parish.id) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return InputChip(
                                      label: Text(
                                        parish.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      backgroundColor: kSecondaryColor,
                                      deleteIcon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                      onDeleted: () async {
                                        setState(() {
                                          selectedParishId = null;
                                        });
                                        if (selectedParishId != null ||
                                            selectedCategoryId != null ||
                                            selectedRouteId != null) {
                                          await bloc.getLocalitiesByFilter(
                                              selectedParishId,
                                              selectedCategoryId,
                                              selectedRouteId);
                                        } else {
                                          bloc.clearLocalities();
                                        }
                                      },
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 0.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: const BorderSide(
                                          color: Colors.white,
                                          width: 1.0,
                                        ),
                                      ),
                                    );
                                  }
                                })
                                .toList()
                                .whereType<Widget>()
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: bloc.categories
                                .map((category) {
                                  if (selectedCategoryId != category.id) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return InputChip(
                                      label: Text(
                                        category.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      backgroundColor: kSecondaryColor,
                                      deleteIcon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                      onDeleted: () async {
                                        setState(() {
                                          selectedCategoryId = null;
                                        });

                                        if (selectedParishId != null ||
                                            selectedCategoryId != null ||
                                            selectedRouteId != null) {
                                          await bloc.getLocalitiesByFilter(
                                              selectedParishId,
                                              selectedCategoryId,
                                              selectedRouteId);
                                        } else {
                                          bloc.clearLocalities();
                                        }
                                      },
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 0.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: const BorderSide(
                                          color: Colors.white,
                                          width: 1.0,
                                        ),
                                      ),
                                    );
                                  }
                                })
                                .toList()
                                .whereType<Widget>()
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: bloc.routes
                                .map((route) {
                                  if (selectedRouteId != route.id) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return InputChip(
                                      label: Text(
                                        route.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      backgroundColor: kSecondaryColor,
                                      deleteIcon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                      onDeleted: () async {
                                        setState(() {
                                          selectedRouteId = null;
                                        });
                                        if (selectedParishId != null ||
                                            selectedCategoryId != null ||
                                            selectedRouteId != null) {
                                          await bloc.getLocalitiesByFilter(
                                              selectedParishId,
                                              selectedCategoryId,
                                              selectedRouteId);
                                        } else {
                                          bloc.clearLocalities();
                                        }
                                      },
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 0.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: const BorderSide(
                                          color: Colors.white,
                                          width: 1.0,
                                        ),
                                      ),
                                    );
                                  }
                                })
                                .toList()
                                .whereType<Widget>()
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ])),

////////////////

                bloc.localities.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: GestureDetector(
                                onTap: () {
                                  context.push(
                                      '${LocalityRouteDetailScreen.routeName}/${bloc.localities[index].id.toString()}');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.memory(
                                          getImageData(bloc.localities[index]
                                              .imageGallery![0].picture),
                                          width: 150,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              bloc.localities[index].name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              bloc.localities[index].address,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            const SizedBox(height: 10.0),
                                            bloc.localities[index].schedule!
                                                    .isNotEmpty
                                                ? isOpenNow(bloc
                                                        .localities[index]
                                                        .schedule!)
                                                    ? Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .tourismOpenNow,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.green),
                                                      )
                                                    : Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .tourismCloseNow,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.red),
                                                      )
                                                : Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .tourismOpenNow,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.green),
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
                          childCount: bloc.localities.length,
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EmptyData(
                                  title: AppLocalizations.of(context)!
                                      .tourismEmptyLocalities),
                            ],
                          ),
                        ),
                      ),

                const SliverToBoxAdapter(
                    child: SizedBox(
                  height: 30.0,
                )),
              ],
            ),
          ],
        ));
  }
}
