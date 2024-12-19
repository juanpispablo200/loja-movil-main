import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loja_movil/src/utils/image_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/usecase/tourism_usecase.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/presentation/common/empty_data.widget.dart';
import 'package:loja_movil/src/presentation/common/locality_card.widget.dart';
import 'package:loja_movil/src/presentation/tourism/route_map/route_map_screen.dart';
import 'package:loja_movil/src/presentation/tourism/shimmer_pages/tourist_route_shimmer_screen.dart';
import 'package:loja_movil/src/presentation/tourism/tourism_route_home/tourism_route_home_bloc.dart';
import 'package:loja_movil/src/presentation/tourism/locality_route_detail/locality_route_detail_screen.dart';

class TourismRouteHomeScreen extends HookWidget {
  const TourismRouteHomeScreen._();

  static Widget init({
    required BuildContext context,
    required int routeId,
  }) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TourismRouteHomeBLoC(
            useCase: TourismUseCase(
              apiRepositoryInterface: context.read<ApiRepository>(),
            ),
          )..init(routeId),
          builder: (_, __) => const TourismRouteHomeScreen._(),
        ),
      ],
    );
  }

  static const routeName = '/home-tourism-route';
  static const String name = 'tourism-route-home-screen';

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<TourismRouteHomeBLoC>();

    const collapsedBarHeight = 60.0;
    const expandedBarHeight = 250.0;

    final isExpanded = useState(false);
    final scrollController = useScrollController();
    final isCollapsed = useState(false);
    final didAddFeedback = useState(false);
    final canExpand = useState(false);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        isCollapsed.value = scrollController.hasClients &&
            scrollController.offset > (expandedBarHeight - collapsedBarHeight);
        if (isCollapsed.value && !didAddFeedback.value) {
          HapticFeedback.mediumImpact();
          didAddFeedback.value = true;
        } else if (!isCollapsed.value) {
          didAddFeedback.value = false;
        }
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: (bloc.loadingRoute)
              ? const TouristRouteShimmerScreen()
              : (!bloc.loadingRoute && bloc.route != null)
                  ? SafeArea(
                      top: false,
                      bottom: true,
                      child: Stack(
                        children: [
                          CustomScrollView(
                            controller: scrollController,
                            slivers: <Widget>[
                              SliverAppBar(
                                expandedHeight: expandedBarHeight,
                                collapsedHeight: collapsedBarHeight,
                                centerTitle: false,
                                pinned: true,
                                title: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: isCollapsed.value ? 1 : 0,
                                  child: SizedBox(
                                    child: Text(bloc.route!.name,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                                elevation: 0,
                                backgroundColor: Colors.white,
                                actions: [
                                  !isCollapsed.value
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 10, sigmaY: 10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  context.push(
                                                      RouteMapScreen.routeName,
                                                      extra: bloc.route);
                                                },
                                                child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15.0,
                                                        vertical: 8.0),
                                                    color: const Color.fromARGB(
                                                            255, 48, 48, 48)
                                                        .withOpacity(0.3),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.map_outlined,
                                                          color: Colors.white,
                                                        ),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .tourismViewOnMap,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0),
                                          child: SizedBox(
                                            height: 45.0,
                                            child: Image.asset(
                                              'assets/images/turismo-loja.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                ],
                                leading: !isCollapsed.value
                                    ? Container(
                                        margin: const EdgeInsets.all(6.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10, sigmaY: 10),
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              color: const Color.fromARGB(
                                                      255, 87, 87, 87)
                                                  .withOpacity(0.3),
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.arrow_back_ios_new,
                                                  size: 20.0,
                                                ),
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : IconButton(
                                        icon: const Icon(
                                          Icons.arrow_back_ios_new,
                                          size: 25.0,
                                          color: Colors.black,
                                        ),
                                        onPressed: () => context.pop(),
                                      ),
                                flexibleSpace: FlexibleSpaceBar(
                                  background: Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      if (bloc.route != null)
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: MemoryImage(getImageData(
                                                    bloc.route!.imageGallery[0]
                                                        .picture)),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                              )),
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0,
                                              left: 40.0,
                                              right: 40.0),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 10, sigmaY: 10),
                                                child: Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  color: const Color.fromARGB(
                                                          255, 87, 87, 87)
                                                      .withOpacity(0.1),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        bloc.route!.name,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 4.0),
                                                      if (bloc.route!
                                                              .estimatedTravelTime !=
                                                          null)
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .tourismEstimatedTravelTime(bloc
                                                                  .route!
                                                                  .estimatedTravelTime!),
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.white70,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildListDelegate(
                                  <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .tourismRouteDescription,
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black87),
                                          ),
                                          const SizedBox(height: 5.0),
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              const textStyle = TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black54,
                                                wordSpacing: 9.0,
                                                height: 1.7,
                                              );

                                              final textSpan = TextSpan(
                                                text: bloc.route!.description,
                                                style: textStyle,
                                              );

                                              final textPainter = TextPainter(
                                                text: textSpan,
                                                maxLines: 2,
                                                textDirection:
                                                    TextDirection.ltr,
                                              );

                                              textPainter.layout(
                                                maxWidth: constraints.maxWidth,
                                              );

                                              // Verifica si el texto tiene más de dos líneas
                                              // Usamos WidgetsBinding para actualizar el estado después de la construcción
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                if (canExpand.value !=
                                                    textPainter
                                                        .didExceedMaxLines) {
                                                  canExpand.value = textPainter
                                                      .didExceedMaxLines;
                                                }
                                              });

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    bloc.route!.description,
                                                    maxLines: isExpanded.value
                                                        ? null
                                                        : 2,
                                                    overflow: isExpanded.value
                                                        ? TextOverflow.visible
                                                        : TextOverflow.ellipsis,
                                                    style: textStyle,
                                                  ),
                                                  const SizedBox(height: 2.0),
                                                  if (canExpand.value)
                                                    GestureDetector(
                                                      onTap: () {
                                                        isExpanded.value =
                                                            !isExpanded.value;
                                                      },
                                                      child: Text(
                                                        isExpanded.value
                                                            ? AppLocalizations
                                                                    .of(
                                                                        context)!
                                                                .tourismHide
                                                            : AppLocalizations
                                                                    .of(context)!
                                                                .tourismSeeMore,
                                                        style: const TextStyle(
                                                            color:
                                                                kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (bloc.route!.routePoints!.isNotEmpty)
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .tourismLocalities,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15),
                                      child: LocalityCard(
                                          image: bloc.route!.routePoints![index]
                                              .imageGallery![0].picture,
                                          title: bloc
                                              .route!.routePoints![index].name,
                                          direction: bloc.route!
                                              .routePoints![index].address,
                                          action: () => context.push(
                                              '${LocalityRouteDetailScreen.routeName}/${bloc.route!.routePoints![index].id.toString()}')),
                                    );
                                  },
                                  childCount: bloc.route!.routePoints!.length,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : EmptyData(
                      title:
                          AppLocalizations.of(context)!.tourismNoLocalityInfo)),
    );
  }
}
