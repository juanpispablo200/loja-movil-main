import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/response/status_response.dart';
import 'package:loja_movil/src/presentation/cero_baches/utils/get_incidence_detail.dart';

class ReportsCard extends StatelessWidget {
  final List<IncidenceStatus> allStatus;
  final Function reload;

  const ReportsCard(
      {super.key,
      required this.allStatus,
      required this.reload});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color.fromARGB(186, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 100,
          width: 150,
          child: Column(
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.incidencesAreas,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 58, 57, 57),
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.black,
                      size: 20.0,
                    ),
                    tooltip: 'Refrescar',
                    onPressed: () {
                      reload();
                    },
                  ),
                ],
              )),
              for (var status in allStatus)
                  Expanded(
                      child: Row(
                    children: [
                      Text(
                        status.name,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 58, 57, 57),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Icon(
                        Icons.linear_scale,
                        color: HexColor.fromHex('#${status.color}'),
                        size: 30.0,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
