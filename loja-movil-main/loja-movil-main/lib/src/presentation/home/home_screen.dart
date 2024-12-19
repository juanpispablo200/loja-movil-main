import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dynamic_fa_icons/dynamic_fa_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/usecase/home_usecase.dart';
import 'package:loja_movil/src/presentation/home/home_bloc.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/presentation/common/menu_left.widget.dart';
import 'package:loja_movil/src/domain/repository/local_storage_repository.dart';
import 'package:loja_movil/src/domain/repository/database_local_repository.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/event_detail/event_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen._();

  static Widget init(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeBLoC(
            useCase: HomeUseCase(
              localRepositoryInterface:
                  context.read<LocalRepositoryInterface>(),
              apiRepositoryInterface: context.read<ApiRepository>(),
              databaseLocalRepository: context.read<DatabaseLocalRepository>(),
            ),
          )..init(),
          builder: (_, __) => const HomeScreen._(),
        ),
      ],
    );
  }

  static const routeName = '/home';
  static const String name = 'home-page';

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBLoC>();
    Color lightenColor(String hexColor, [double amount = 0.3]) {
      String colorString = hexColor.replaceAll('#', '0xff');
      Color color = Color(int.parse(colorString));
      int r = color.red + ((255 - color.red) * amount).toInt();
      int g = color.green + ((255 - color.green) * amount).toInt();
      int b = color.blue + ((255 - color.blue) * amount).toInt();

      return Color.fromARGB(color.alpha, r, g, b);
    }

    return LoadingView(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.institutionName,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: kBlackColor,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Image.asset(
                'assets/images/escudo.png',
                height: 40.0,
              ),
            ),
          ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.notes_outlined),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          )),
      drawer: const SafeArea(bottom: false, top: false, child: MenuLeft()),
      child: RefreshIndicator(
          onRefresh: () async {
            await bloc.getInitData();
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Text(
                        AppLocalizations.of(context)!.homeTitleDescription,
                        style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.6),
                            fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                    ]),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10.0),
                            Text(
                              AppLocalizations.of(context)!.homeUpcomingEvents,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 85.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: bloc.followingActivities.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      context.push(EventDetailScreen.routeName,
                                          extra:
                                              bloc.followingActivities[index]);
                                    },
                                    child: Container(
                                      width: 180.0,
                                      margin:
                                          const EdgeInsets.only(right: 16.0),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 245, 245, 245),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 120.0,
                                            height: double.infinity,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(10.0),
                                                topLeft: Radius.circular(10.0),
                                              ),
                                              child: Image.network(
                                                '${kUrlBackEnd}event/AC/${bloc.followingActivities[index].imagen}',
                                                fit: BoxFit.fill,
                                                width: double.infinity,
                                                height: double.infinity,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  );
                                                },
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Center(
                                                    child: Icon(Icons.error),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 60.0,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10.0),
                                                bottomRight:
                                                    Radius.circular(10.0),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  toBeginningOfSentenceCase(
                                                    bloc
                                                        .followingActivities[
                                                            index]
                                                        .fechaInfo!
                                                        .mes
                                                        .substring(0, 3),
                                                  )!,
                                                  style: const TextStyle(
                                                    color: kSecondaryColor,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                                Text(
                                                  bloc
                                                      .followingActivities[
                                                          index]
                                                      .fechaInfo!
                                                      .diaNumero
                                                      .padLeft(2, '0'),
                                                  style: const TextStyle(
                                                    color: kPrimaryColor,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 25.0),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(
                          height: 270.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.homeNews,
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Expanded(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      bottom: 30.0,
                                      left: 0,
                                      right: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: CarouselSlider(
                                          carouselController:
                                              bloc.buttonCarouselController,
                                          options: CarouselOptions(
                                            autoPlay: true,
                                            enlargeCenterPage: true,
                                            viewportFraction: 1,
                                            height: 210.0,
                                            onPageChanged: (index, reason) {
                                              bloc.setCurrentPageCarrousel(
                                                  index);
                                            },
                                          ),
                                          items: bloc.news.map(
                                            (news) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  return news.photo.isEmpty
                                                      ? Image.asset(
                                                          'assets/images/slider.png',
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            bloc.openNews(
                                                                news.url);
                                                          },
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10.0),
                                                              ),
                                                              child: news.photo
                                                                      .contains(
                                                                          "assets/images/banner/")
                                                                  ? Image.asset(
                                                                      news.photo,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    )
                                                                  : Image
                                                                      .network(
                                                                      news.photo,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    )),
                                                        );
                                                },
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 10.0, sigmaY: 10.0),
                                              child: Container(
                                                width: double.infinity,
                                                height: 66.0,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 10),
                                                color: const Color.fromARGB(
                                                        255, 234, 234, 234)
                                                    .withOpacity(0.8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 200.0,
                                                      child: Text(
                                                        bloc.news.isEmpty
                                                            ? ''
                                                            : bloc
                                                                .news[bloc
                                                                    .currentPageCarrousel]
                                                                .title,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: const TextStyle(
                                                            fontSize: 13.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black87,
                                                            wordSpacing: 2.0,
                                                            height: 1.8),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        bloc.openNews(bloc
                                                            .news[bloc
                                                                .currentPageCarrousel]
                                                            .url);
                                                      },
                                                      icon: const Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 18.0,
                                                        color: kPrimaryColor,
                                                      ),
                                                    ),
                                                  ],
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
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.homeServicesTitle,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                    ),
                    delegate: SliverChildListDelegate(
                      bloc.menu.map((menu) {
                        String color =
                            menu.backgroundColor.replaceAll('#', '0xff');

                        Color originalColor =
                            Color(int.parse(color.replaceAll('#', '0xff')));
                        Color lighterColor = lightenColor(color);
                        return GestureDetector(
                          onTap: () {
                            context.push(menu.ruta);
                          },
                          child: Material(
                            elevation: 0.1,
                            borderRadius: BorderRadius.circular(15.0),
                            shadowColor:
                                const Color.fromARGB(255, 215, 215, 215)
                                    .withOpacity(0.2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 251, 251, 251),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 186, 186, 186)
                                            .withOpacity(0.3),
                                    blurRadius: 20.0,
                                    spreadRadius: 2.0,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.all(0.0),
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              originalColor,
                                              lighterColor,
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  lighterColor.withOpacity(0.3),
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          DynamicFaIcons.getIconFromName(
                                            menu.icono,
                                          ),
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    menu.titulo,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(
                        height: 25.0,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
