import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_local_response.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/local_events_fiav_detail/local_events_fiav_detail_screen.dart';

class LocalFavCard extends StatelessWidget {
  final LocalFav local;
  final double? width;

  const LocalFavCard({
    super.key,
    required this.local,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(LocalEventsFiavDetailScreen.routeName, extra: local);
      },
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  width == null
                      ? SizedBox(
                          height: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.0),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(
                                '${kUrlBackEnd}event/lugares/${local.ubicacion}',
                              ),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.0),
                            border: Border.all(
                              color: kFavPrimary,
                              width: 2.0,
                            ),
                          ),
                          height: double.infinity,
                          width: width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(
                                '${kUrlBackEnd}event/lugares/${local.ubicacion}',
                              ),
                            ),
                          ),
                        ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: kFavPrimary,
                          width: 2.0,
                        ),
                        gradient: const LinearGradient(
                          stops: [
                            0.4,
                            1.0,
                          ],
                          colors: [
                            Colors.transparent,
                            Colors.black,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: kFavSecondary,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0)),
                      border: Border.all(
                        color: kFavPrimary,
                        width: 2.0,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo_festival.png',
                        height: 35.0,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5.0,
                    child: SizedBox(
                      width: 170.0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 7.0,
                            ),
                            Expanded(
                              child: Text(
                                local.direccion,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          border: Border.all(
                            color: kFavSecondary,
                            width: 1,
                          ),
                        ),
                        width: 70.0,
                        height: 25.0,
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
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: 40.0,
              width: double.infinity,
              child: Text(
                local.nombre,
                style: const TextStyle(
                  color: kFavPrimary,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
