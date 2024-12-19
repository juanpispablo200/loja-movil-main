import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/presentation/cero_baches/utils/constants.dart';
import 'package:loja_movil/src/presentation/cero_baches/widgets/reports_card.dart';
import 'package:loja_movil/src/presentation/cero_baches/utils/lottie_animations.dart';
import 'package:loja_movil/src/presentation/cero_baches/state/cero_baches_state.dart';
import 'package:loja_movil/src/presentation/cero_baches/widgets/admin_menu.widget.dart';
import 'package:loja_movil/src/presentation/cero_baches/utils/get_current_location.dart';
import 'package:loja_movil/src/presentation/cero_baches/utils/get_incidence_detail.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/attend_incidence_page.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/update_incidence_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  static const routeName = '/admin_cero_daches';
  static const String name = 'admin-page';

  @override
  State<AdminPage> createState() => _AdminPage();
}

class _AdminPage extends State<AdminPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CeroBachesStateBLoC>(context, listen: false)
            .fetchAdminData());
  }

  // Uint8List getImageData(String image) {
  //   return Uint8List.fromList(base64.decode(image));
  // }

  Future<Uint8List?> getImageData(String imageId) async {
    return await Provider.of<CeroBachesStateBLoC>(context, listen: false)
        .getImageData(imageId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CeroBachesStateBLoC>(context);

    bool calculateElapsedTime(DateTime reportDate) {
      DateTime fechaActual = DateTime.now();
      Duration diferencia = fechaActual.difference(reportDate);
      return diferencia.inHours >= numHoursAnimation;
    }

    showModal(int i) {
      showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Detalle de incidencia',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Chip(
                            label: Text(
                              provider.incidencesByRole[i].status.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            backgroundColor: getIncidenceColor(
                                colorCode:
                                    provider.incidencesByRole[i].status.color),
                            padding: const EdgeInsets.all(1.5),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tipo incidencia',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    provider
                                        .incidencesByRole[i].incidenceType.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: kBlueColor),
                                  ),
                                ],
                              )),
                              const SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Fecha de reporte',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(DateFormat.yMd().format(provider
                                      .incidencesByRole[i].reportedDate!))
                                ],
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Latitud',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    provider.incidencesByRole[i].longitude
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              )),
                              const SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Longitud',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    provider.incidencesByRole[i].latitude
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Descripción',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(provider.incidencesByRole[i].description),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Imagen',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: FutureBuilder<Uint8List?>(
                                    future: getImageData(
                                        provider.incidencesByRole[i].urlImage),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return const Text(
                                            'Error al cargar la imagen');
                                      } else if (!snapshot.hasData ||
                                          snapshot.data == null) {
                                        return const Text(
                                            'Imagen no disponible');
                                      } else {
                                        return Image.memory(snapshot.data!);
                                      }
                                    },
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    provider.incidencesByRole[i].status.code ==
                                            incidenceStatus['attended']['value']
                                        ? kGrayDisabledColor
                                        : kGrayColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed:
                                  provider.incidencesByRole[i].status.code ==
                                          incidenceStatus['attended']['value']
                                      ? null
                                      : () {
                                          context.push(
                                              '${UpdateIncidencePage.routeName}/${provider.incidencesByRole[i].id}');
                                        },
                              child: const Text(
                                'Reasignar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    provider.incidencesByRole[i].status.code ==
                                            incidenceStatus['attended']['value']
                                        ? kGrayDisabledColor
                                        : kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed:
                                  provider.incidencesByRole[i].status.code ==
                                          incidenceStatus['attended']['value']
                                      ? null
                                      : () {
                                          context.push(
                                              '${AttendIncidencePage.routeName}/${provider.incidencesByRole[i].id}');
                                        },
                              child: const Text(
                                'Atender',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return LoadingView(
      isLoading:
          provider.loadingStatusByRole || provider.loadingIncidencesByRole,
      backgroundColor: const Color(0XFFF4F6F9),
      appBar: AppBar(
        title: const Text(
          'Administración',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0XFFF4F6F9),
        elevation: 0,
        centerTitle: true,
        actions: [
          AdminMenu(
            provider: provider,
          ),
        ],
      ),
      child: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(-4.002010, -79.207084),
          initialZoom: 13.5,
          maxZoom: 18.0,
          minZoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          getCurrentLocation(),
          MarkerLayer(
            markers: [
              for (var i = 0; i < provider.incidencesByRole.length; i++)
                Marker(
                  width: 40,
                  height: 40,
                  point: LatLng(provider.incidencesByRole[i].longitude,
                      provider.incidencesByRole[i].latitude),
                  child: !calculateElapsedTime(
                              provider.incidencesByRole[i].reportedDate!) &&
                          provider.incidencesByRole[i].status.code ==
                              incidenceStatus['pending']['value']
                      ? IconButton(
                          icon: newReportsAnimation(),
                          onPressed: () {
                            showModal(i);
                          })
                      : IconButton(
                          icon: Icon(
                            Icons.circle,
                            size: 20.0,
                            color: getIncidenceColor(
                                colorCode:
                                    provider.incidencesByRole[i].status.color),
                          ),
                          onPressed: () {
                            showModal(i);
                          }),
                ),
            ],
          ),
          ReportsCard(
              allStatus: provider.statusByRole,
              reload: provider.getIncidencesByRoleAndStatus),
        ],
      ),
    );
  }
}
