import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:vector_math/vector_math.dart' as con;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/presentation/home/home_screen.dart';
import 'package:loja_movil/src/presentation/common/map.widget.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/presentation/common/event_card.widget.dart';
import 'package:loja_movil/src/domain/usecase/local_event_detail_usecase.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/local_events_detail/local_event_detail_bloc.dart';

class LocalEventDetailScreen extends StatelessWidget {
  const LocalEventDetailScreen._();

  static Widget init({
    required BuildContext context,
    required int lugarId,
  }) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocalEventDetailBLoC(
            useCase: LocalEventDetailUseCase(
              apiRepositoryInterface: context.read<ApiRepository>(),
            ),
          )..init(lugarId),
          builder: (_, __) => const LocalEventDetailScreen._(),
        ),
      ],
    );
  }

  static const routeName = '/local-events-detail';
  static const String name = 'local-event-detail-screen';

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
    final bloc = context.watch<LocalEventDetailBLoC>();
    return LoadingView(
      isLoading: bloc.loading,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cultureTitle,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Image.asset(
              'assets/images/escudo.png',
              height: 40.0,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(HomeScreen.routeName);
            }
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 250.0,
              width: double.infinity,
              child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: bloc.lugar == null
                          ? const SizedBox.shrink()
                          : Image.network(
                              '${kUrlBackEnd}event/lugares/${bloc.lugar!.ubicacion}',
                            ),
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.4),
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 50,
                    left: 15,
                    right: 15,
                    child: Text(
                      bloc.lugar == null ? '' : bloc.lugar!.nombre,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    right: 15,
                    bottom: 15,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            bloc.lugar != null &&
                                    (bloc.lugar!.latitude != '0' &&
                                        bloc.lugar!.longitude != '0')
                                ? showMapModal(context, bloc.lugar!.latitude,
                                    bloc.lugar!.longitude)
                                : null;
                          },
                          child: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            bloc.lugar == null ? '' : bloc.lugar!.direccion!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 60.0,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search_outlined,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            AppLocalizations.of(context)!.cultureFiavAvailableEvents,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        padding: const EdgeInsets.only(bottom: 30),
                        itemBuilder: (context, index) {
                          Evento evento = bloc.eventos[index];
                          return EventCard(
                            evento: evento,
                            showAddress: false,
                          );
                        },
                        itemCount: bloc.eventos.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderPainter extends CustomPainter {
  double radio = 70;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(100, size.height);
    path.lineTo(100, size.height - 50);

    final avatarBounds =
        Rect.fromCircle(center: const Offset(100, 130), radius: radio);
    path.arcTo(avatarBounds, con.radians(90), con.radians(-180), false);
    path.lineTo(100, 0);

    canvas.drawPath(path, paint);

    canvas.save();
    canvas.restore();

    final path1 = Path();

    path1.moveTo(0, 0);
    path1.lineTo(0, size.height);
    path1.lineTo(100, size.height);
    path1.lineTo(100, size.height - 50);
    path1.arcTo(avatarBounds, con.radians(90), con.radians(180), false);
    path1.lineTo(100, 0);
    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
