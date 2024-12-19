import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/presentation/common/map.widget.dart';
import 'package:loja_movil/src/domain/response/lugars_with_events_response.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/local_events_detail/local_event_detail_screen.dart';

class LugarCard extends StatelessWidget {
  final LugarDTO lugar;
  final double? width;
  const LugarCard({
    super.key,
    required this.lugar,
    this.width,
  });

  showMapModal(BuildContext context, String? lat, String? lon) {
    double latitude = double.parse(lat!);
    double longitude = double.parse(lon!);

    showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        content: Builder(
          builder: (context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            return SizedBox(
              height: height - 200,
              width: width - 25,
              child: MapWidget(
                latitude: latitude,
                longitude: longitude,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .push('${LocalEventDetailScreen.routeName}/${lugar.id.toString()}');
      },
      child: SizedBox(
        width: width,
        child: Stack(
          children: [
            width == null
                ? SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                          '${kUrlBackEnd}event/lugares/${lugar.ubicacion}',
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: double.infinity,
                    width: width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                          '${kUrlBackEnd}event/lugares/${lugar.ubicacion}',
                        ),
                      ),
                    ),
                  ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.black.withOpacity(0.2),
              ),
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
              top: 1,
              left: 1,
              child: IconButton(
                iconSize: 22,
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                onPressed: () {
                  (lugar.latitude != '0' && lugar.longitude != '0')
                      ? showMapModal(context, lugar.latitude, lugar.longitude)
                      : null;
                },
              ),
            ),
            Positioned(
              bottom: 70,
              child: SizedBox(
                width: 170,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    lugar.nombre,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              child: SizedBox(
                width: 170,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Text(
                      '${AppLocalizations.of(context)!.cultureFiavEvents}: ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      maxRadius: 12,
                      backgroundColor: Colors.white,
                      child: Text(
                        lugar.total.toString(),
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  width: 70,
                  height: 25,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.commonDetail,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
