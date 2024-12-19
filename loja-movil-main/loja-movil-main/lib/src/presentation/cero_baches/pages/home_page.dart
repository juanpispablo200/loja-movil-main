// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/admin_page.dart';
import 'package:loja_movil/src/presentation/cero_baches/widgets/reports_card.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/new_report_page.dart';
import 'package:loja_movil/src/presentation/cero_baches/state/cero_baches_state.dart';
import 'package:loja_movil/src/presentation/cero_baches/utils/get_incidence_detail.dart';

class CeroBachesHomePage extends StatefulWidget {
  const CeroBachesHomePage({super.key});

  static const routeName = '/home-cero-baches';
  static const String name = 'home-cero-baches-page';

  @override
  State<CeroBachesHomePage> createState() => _CeroBachesHomePage();
}

class _CeroBachesHomePage extends State<CeroBachesHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CeroBachesStateBLoC>(context, listen: false).fetchInit());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CeroBachesStateBLoC>(context);

    return LoadingView(
      isLoading: provider.loadingUserIncidences || provider.loadingUserStatus,
      backgroundColor: const Color(0XFFF4F6F9),
      appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.incidencesTitle,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () async {
                  await provider.getUserAccount();
                  context.push(AdminPage.routeName);
                },
                icon: const Icon(Icons.manage_accounts_outlined),
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () => GoRouter.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kBlackColor,
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await provider.getAllIncidenceTypes();
          context.push(NewReportPage.routeName);
        },
        label: Text(
          AppLocalizations.of(context)!.incidencesNewReport,
          style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        icon: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        backgroundColor: kPrimaryColor,
      ),
      child: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(-4.002010, -79.207084),
          initialZoom: 13.5,
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
              for (var i = 0; i < provider.userIncidences.length; i++)
                Marker(
                  width: 80,
                  height: 80,
                  point: LatLng(provider.userIncidences[i].longitude,
                      provider.userIncidences[i].latitude),
                  child: Icon(
                    Icons.circle,
                    color: getIncidenceColor(
                            colorCode: provider.userIncidences[i].status.color)
                        .withOpacity(0.7),
                    size: 20.0,
                  ),
                ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: ReportsCard(
                allStatus: provider.userStatus,
                reload: provider.recargarDatos,
              )),
        ],
      ),
    );
  }
}
