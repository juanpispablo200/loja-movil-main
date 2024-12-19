import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/presentation/cero_baches/utils/get_current_location.dart';

class MapWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  const MapWidget({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(latitude, longitude),
        initialZoom: 13.5,
        maxZoom: 18.0,
        minZoom: 8.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        getCurrentLocation(),
        MarkerLayer(
          markers: [
            Marker(
              width: 80,
              height: 80,
              point: LatLng(latitude, longitude),
              child: const Icon(
                Icons.location_pin,
                color: kPrimaryColor,
                size: 30.0,
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 5.0,
          right: 5.0,
          child: ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              context.pop();
            },
            child: Text(
              AppLocalizations.of(context)!.commonClose,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
