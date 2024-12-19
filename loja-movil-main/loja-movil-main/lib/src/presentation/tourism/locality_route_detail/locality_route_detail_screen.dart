import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loja_movil/src/utils/image_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loja_movil/src/utils/schedule_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/usecase/tourism_usecase.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/presentation/common/empty_data.widget.dart';
import 'package:loja_movil/src/presentation/tourism/widgets/locality_schedule.widget.dart';
import 'package:loja_movil/src/presentation/tourism/shimmer_pages/locality_detail_shimmer_screen.dart';
import 'package:loja_movil/src/presentation/tourism/locality_route_detail/locality_route_detail_bloc.dart';

class LocalityRouteDetailScreen extends HookWidget {
  const LocalityRouteDetailScreen._();

  static Widget init({
    required BuildContext context,
    required int localityId,
  }) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocalityRouteDetailBLoC(
            useCase: TourismUseCase(
              apiRepositoryInterface: context.read<ApiRepository>(),
            ),
          )..init(localityId),
          builder: (_, __) => const LocalityRouteDetailScreen._(),
        ),
      ],
    );
  }

  static const routeName = '/locality-route-detail';
  static const String name = 'locality-route-detail-screen';

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LocalityRouteDetailBLoC>();

    final isExpanded = useState(false);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.tourismLocalityDetail,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset(
                'assets/images/turismo-loja.jpg',
                height: 45,
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: (bloc.loadingLocality)
            ? const LocalityDetailShimmerScreen()
            : (!bloc.loadingLocality && bloc.locality != null)
                ? SafeArea(
                    child: CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Column(
                          children: [
                            Stack(children: [
                              Positioned(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: CarouselSlider.builder(
                                    carouselController:
                                        bloc.buttonCarouselController,
                                    options: CarouselOptions(
                                      enlargeCenterPage: true,
                                      viewportFraction: 1,
                                      height: 230,
                                      onPageChanged: (index, reason) {
                                        bloc.setCurrentPageCarrousel(index);
                                      },
                                    ),
                                    itemCount:
                                        bloc.locality?.imageGallery?.length ??
                                            0,
                                    itemBuilder: (context, index, realIndex) {
                                      final image =
                                          bloc.locality!.imageGallery![index];
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.memory(
                                          getImageData(image.picture),
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 20,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      color:
                                          const Color.fromARGB(255, 48, 48, 48)
                                              .withOpacity(0.3),
                                      child: IconButton(
                                          onPressed: () {
                                            showGalleryImageModal(
                                                context,
                                                bloc
                                                    .locality!
                                                    .imageGallery![bloc
                                                        .currentPageCarrousel]
                                                    .picture);
                                          },
                                          icon: const Icon(
                                            Icons.aspect_ratio_outlined,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 14.0,
                                right: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        color: const Color.fromARGB(
                                                255, 48, 48, 48)
                                            .withOpacity(0.3),
                                        child: bloc
                                                .locality!.schedule!.isNotEmpty
                                            ? isOpenNow(
                                                    bloc.locality!.schedule!)
                                                ? Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .tourismOpenNow,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 0, 255, 8)),
                                                  )
                                                : Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .tourismCloseNow,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 255, 0, 0)),
                                                  )
                                            : Text(
                                                AppLocalizations.of(context)!
                                                    .tourismOpenNow,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 0, 255, 8)),
                                              )),
                                  ),
                                ),
                              )
                            ]),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 3.0),
                              child: Material(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(2.0)),
                                elevation: 0.2,
                                shadowColor:
                                    const Color.fromARGB(146, 223, 223, 223),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2.0)),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 2.0),
                                  height: 50,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: bloc.locality!.imageGallery!
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        return GestureDetector(
                                          onTap: () => bloc
                                              .buttonCarouselController
                                              .animateToPage(entry.key),
                                          child: Container(
                                            width: 60.0,
                                            height: 40.0,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 8.0),
                                            decoration: bloc
                                                        .currentPageCarrousel ==
                                                    entry.key
                                                ? BoxDecoration(
                                                    image: DecorationImage(
                                                      image: MemoryImage(
                                                          getImageData(entry
                                                              .value.picture)),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                    border: Border.all(
                                                      width: 2.0,
                                                      color: kPrimaryColor,
                                                      style: BorderStyle.solid,
                                                    ),
                                                  )
                                                : BoxDecoration(
                                                    image: DecorationImage(
                                                      image: MemoryImage(
                                                          getImageData(entry
                                                              .value.picture)),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                  ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bloc.locality!.name,
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5.0),
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5.0),
                                      Text(
                                        bloc.locality!.description,
                                        maxLines: isExpanded.value ? null : 2,
                                        overflow: isExpanded.value
                                            ? TextOverflow.visible
                                            : TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black54,
                                            wordSpacing: 9.0,
                                            height: 1.7),
                                      ),
                                      const SizedBox(height: 2.0),
                                      GestureDetector(
                                        onTap: () {
                                          isExpanded.value = !isExpanded.value;
                                        },
                                        child: Text(
                                          isExpanded.value
                                              ? AppLocalizations.of(context)!
                                                  .tourismHide
                                              : AppLocalizations.of(context)!
                                                  .tourismSeeMore,
                                          style: const TextStyle(
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                Text(
                                  AppLocalizations.of(context)!.tourismAddress,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  bloc.locality!.address,
                                  style: const TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black54,
                                      wordSpacing: 5.0),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  height: 200.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: FlutterMap(
                                      options: MapOptions(
                                        initialCenter: LatLng(
                                            bloc.locality!.latitude,
                                            bloc.locality!.longitude),
                                        initialZoom: 16.0,
                                        maxZoom: 30.0,
                                        minZoom: 8.0,
                                      ),
                                      children: [
                                       TileLayer(
                                          urlTemplate:
                                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName:
                                              'dev.fleaflet.flutter_map.example',
                                        ),
                                        MarkerLayer(
                                          markers: [
                                            Marker(
                                              width: 120,
                                              height: 120,
                                              point: LatLng(
                                                  bloc.locality!.latitude,
                                                  bloc.locality!.longitude),
                                              child: const Icon(
                                                Icons.fmd_good,
                                                size: 30.0,
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          top: 7,
                                          left: 7,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.my_location_rounded,
                                                  size: 20.0,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(width: 2.0),
                                                Text(
                                                  bloc.locality!.parish!.name,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .tourismOpeningHours,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: bloc.locality!.schedule!.isNotEmpty
                                      ? ScheduleColumnList(
                                          scheduleList:
                                              bloc.locality!.schedule!)
                                      : Text(AppLocalizations.of(context)!
                                          .tourismLocalityStatus),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .tourismAdditionalInformation,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Column(
                                  children: [
                                    if (bloc.locality!.manager != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.person_outline,
                                              size: 18.0,
                                            ),
                                            const SizedBox(
                                              width: 2.0,
                                            ),
                                            Text(
                                              '${AppLocalizations.of(context)!.tourismLocalityManager}:',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(bloc.locality?.manager ?? '')
                                          ],
                                        ),
                                      ),
                                    if (bloc.locality!.email != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.mail_outline,
                                              size: 18.0,
                                            ),
                                            const SizedBox(
                                              width: 2.0,
                                            ),
                                            Text(
                                              '${AppLocalizations.of(context)!.tourismLocalityEmail}:',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(bloc.locality?.email ?? '')
                                          ],
                                        ),
                                      ),
                                    if (bloc.locality!.url != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.link_outlined,
                                              size: 18.0,
                                            ),
                                            const SizedBox(
                                              width: 2.0,
                                            ),
                                            Text(
                                              '${AppLocalizations.of(context)!.tourismLocalityUrl}:',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(bloc.locality?.url ?? '')
                                          ],
                                        ),
                                      ),
                                    if (bloc.locality!.contact != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.phone_outlined,
                                              size: 18.0,
                                            ),
                                            const SizedBox(
                                              width: 2.0,
                                            ),
                                            Text(
                                              '${AppLocalizations.of(context)!.tourismLocalityPhone}:',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(bloc.locality?.contact ?? '')
                                          ],
                                        ),
                                      ),
                                    if (bloc.locality!.capacity != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.reduce_capacity_outlined,
                                              size: 18.0,
                                            ),
                                            const SizedBox(
                                              width: 2.0,
                                            ),
                                            Text(
                                              '${AppLocalizations.of(context)!.tourismLocalityCapacity}:',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                                '${bloc.locality?.capacity ?? ''}')
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            )),
                      ]))
                    ],
                  ))
                : EmptyData(
                    title:
                        AppLocalizations.of(context)!.tourismNoLocalityInfo));
  }
}
