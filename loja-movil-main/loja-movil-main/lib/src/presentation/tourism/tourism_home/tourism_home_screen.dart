import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/usecase/tourism_usecase.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/presentation/tourism/tourism_home/tourism_home_bloc.dart';
import 'package:loja_movil/src/presentation/tourism/widgets/tourism_route_element.widget.dart';
import 'package:loja_movil/src/presentation/tourism/localities_list/localities_list_screen.dart';
import 'package:loja_movil/src/presentation/tourism/tourism_route_home/tourism_route_home_screen.dart';

class TourismHomeScreen extends HookWidget {
  const TourismHomeScreen._();

  static Widget init(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TourismHomeBLoC(
              useCase: TourismUseCase(
            apiRepositoryInterface: context.read<ApiRepository>(),
          ))
            ..init(),
          builder: (_, __) => const TourismHomeScreen._(),
        ),
      ],
    );
  }

  static const routeName = '/home-tourism';
  static const String name = 'tourism-home-screen';

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<TourismHomeBLoC>();

    final selectedIndex = useState(0);
    const collapsedBarHeight = 60.0;
    const expandedBarHeight = 125.0;

    final scrollController = useScrollController();
    final isCollapsed = useState(false);
    final didAddFeedback = useState(false);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        bool collapsed = scrollController.hasClients &&
            scrollController.offset > (expandedBarHeight - collapsedBarHeight);

        if (collapsed != isCollapsed.value) {
          isCollapsed.value = collapsed;
          if (collapsed && !didAddFeedback.value) {
            HapticFeedback.mediumImpact();
            didAddFeedback.value = true;
          } else if (!collapsed) {
            didAddFeedback.value = false;
          }
        }
        return false;
      },
      child: LoadingView(
        backgroundColor: Colors.white,
        isLoading: bloc.loadingItems || bloc.loadingRoutes,
        child: SafeArea(
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
                        child: Row(
                          children: [
                            SizedBox(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Loja,',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .tourismTagline,
                                    style: const TextStyle(
                                      color: Color.fromARGB(179, 59, 59, 59),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 45,
                              child: Image.asset(
                                'assets/images/turismo-loja.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        )),
                    elevation: 0,
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 25.0,
                        color: Colors.black,
                      ),
                      onPressed: () => context.pop(),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        padding: const EdgeInsets.only(
                            bottom: 5.0, left: 20.0, right: 20.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Loja,',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .tourismTagline,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(179, 59, 59, 59),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/turismo-loja.jpg',
                                  height: 75.0,
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 250, 250, 250),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(height: 4),
                                        SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .tourismLocalityCardDescription,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[800],
                                              ),
                                            )),
                                        ElevatedButton(
                                          onPressed: () {
                                            context.push(
                                                LocalitiesListHomeScreen
                                                    .routeName);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: kSecondaryColor,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            minimumSize: const Size(20, 20),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            elevation: 1,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .tourismExplore,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  child: Stack(
                                    children: [
                                      ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return const LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Colors.black
                                            ],
                                            stops: [0, 1.0],
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                          ).createShader(bounds);
                                        },
                                        blendMode: BlendMode.xor,
                                        child: Image.asset(
                                          'assets/images/villonaco.png',
                                          height: double.infinity,
                                          width: 200,
                                          fit: BoxFit.cover,
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
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.toutismRoutesTitle,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 33.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: bloc.items.length,
                              itemBuilder: (context, index) {
                                bool isSelected = selectedIndex.value == index;
                                return GestureDetector(
                                  onTap: () {
                                    selectedIndex.value = index;
                                    bloc.getRoutesByCatalog(
                                        bloc.items[index].id);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? kPrimaryColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 0,
                                          blurRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          bloc.items[index].name,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
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
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final realIndex =
                            index ~/ 2 * 3 + (index % 2 == 1 ? 2 : 0);
                        if (realIndex < bloc.routes.length) {
                          if (index % 2 == 0 &&
                              realIndex + 1 < bloc.routes.length) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: TourismRouteElement(
                                      image: bloc.routes[realIndex]
                                          .imageGallery[0].picture,
                                      size: 165.0,
                                      name: bloc.routes[realIndex].name,
                                      action: () => context.push(
                                          '${TourismRouteHomeScreen.routeName}/${bloc.routes[realIndex].id.toString()}')),
                                ),
                                Expanded(
                                  child: TourismRouteElement(
                                    image: bloc.routes[realIndex + 1]
                                        .imageGallery[0].picture,
                                    size: 150.0,
                                    name: bloc.routes[realIndex + 1].name,
                                    action: () => context.push(
                                        '${TourismRouteHomeScreen.routeName}/${bloc.routes[realIndex + 1].id.toString()}'),
                                  ),
                                ),
                              ],
                            );
                          } else if (index % 2 == 1) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              alignment: Alignment.center,
                              child: TourismRouteElement(
                                image: bloc
                                    .routes[realIndex].imageGallery[0].picture,
                                size: 150.0,
                                name: bloc.routes[realIndex].name,
                                action: () => context.push(
                                    '${TourismRouteHomeScreen.routeName}/${bloc.routes[realIndex].id.toString()}'),
                              ),
                            );
                          } else {
                            return TourismRouteElement(
                              image: bloc
                                  .routes[realIndex].imageGallery[0].picture,
                              size: 150.0,
                              name: bloc.routes[realIndex].name,
                              action: () => context.push(
                                  '${TourismRouteHomeScreen.routeName}/${bloc.routes[realIndex].id.toString()}'),
                            );
                          }
                        }
                        return null;
                      },
                      childCount: (bloc.routes.length),
                    ),
                  ),
                   const SliverToBoxAdapter(
                      child: SizedBox(
                    height: 20.0,
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
