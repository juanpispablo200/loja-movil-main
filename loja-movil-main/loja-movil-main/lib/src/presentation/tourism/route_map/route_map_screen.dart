import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:loja_movil/src/utils/image_util.dart';
import 'package:loja_movil/src/domain/response/route_response.dart';
import 'package:loja_movil/src/domain/usecase/tourism_usecase.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/presentation/tourism/route_map/route_map_bloc.dart';
import 'package:loja_movil/src/presentation/tourism/widgets/custom_marker.widget.dart';
import 'package:loja_movil/src/presentation/cero_baches/utils/get_current_location.dart';

class RouteMapScreen extends StatefulWidget {
  const RouteMapScreen({super.key});

  static Widget init({
    required BuildContext context,
    required FullRoute route,
  }) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RouteMapBLoC(
            useCase: TourismUseCase(
              apiRepositoryInterface: context.read<ApiRepository>(),
            ),
          )..init(route),
          builder: (_, __) => const RouteMapScreen(),
        ),
      ],
    );
  }

  static const routeName = '/route-map';
  static const String name = 'route-map-screen';

  @override
  State<RouteMapScreen> createState() => _RouteMapScreen();
}

class _RouteMapScreen extends State<RouteMapScreen>
    with SingleTickerProviderStateMixin {
  final MapController _mapController = MapController();
  late AnimationController _animationController;
  late Animation<double> _latTween;
  late Animation<double> _lngTween;
  late Animation<double> _zoomTween;

  LatLng _currentCenter = const LatLng(-4.002010, -79.207084);
  double _currentZoom = 13.5;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _animationController.addListener(() {
      _mapController.move(
        LatLng(
          _latTween.value,
          _lngTween.value,
        ),
        _zoomTween.value,
      );
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animatedMove(LatLng destLocation, double destZoom) {
    _latTween = Tween<double>(
      begin: _currentCenter.latitude,
      end: destLocation.latitude,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));
    _lngTween = Tween<double>(
      begin: _currentCenter.longitude,
      end: destLocation.longitude,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));
    _zoomTween = Tween<double>(
      begin: _currentZoom,
      end: destZoom,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));

    _animationController.forward(from: 0);

    _currentCenter = destLocation;
    _currentZoom = destZoom;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<RouteMapBLoC>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: LoadingView(
        backgroundColor: const Color(0XFFF4F6F9),
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _currentCenter,
            initialZoom: _currentZoom,
            maxZoom: 18.0,
            minZoom: 8.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayer(
              markers: [
                for (var i = 0; i < bloc.route.routePoints!.length; i++)
                  Marker(
                    width: 120,
                    height: 120,
                    point: LatLng(
                      bloc.route.routePoints![i].latitude,
                      bloc.route.routePoints![i].longitude,
                    ),
                    child: CustomMarker(
                      image: bloc.route.routePoints![i].imageGallery![0].picture,
                    ),
                  ),
              ],
            ),
            getCurrentLocation(),
            Positioned(
              top: 65.0,
              left: 14.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(1.0),
                    color:
                        const Color.fromARGB(255, 87, 87, 87).withOpacity(0.3),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20.0,
                      ),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: bloc.route.routePoints!.map((entry) {
                      return GestureDetector(
                        onTap: () {
                          _animatedMove(
                            LatLng(entry.latitude, entry.longitude),
                            17.0,
                          );
                        },
                        child: Container(
                          width: 300,
                          height: 160,
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: MemoryImage(getImageData(
                                            entry.imageGallery![0].picture)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 190,
                                        child: Text(
                                          entry.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryColor
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 190,
                                        child: Text(
                                          entry.address,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                entry.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[800],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
