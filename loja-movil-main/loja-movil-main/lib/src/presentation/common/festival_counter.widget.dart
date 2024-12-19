import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:loja_movil/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FestivalCounter extends StatelessWidget {
  final int days;

  const FestivalCounter({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background_fiav.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'FALTAN',
              style: TextStyle(fontSize: 30, color: kFavPrimary),
            ),
            const SizedBox(height: 1),
            Text(
              '${NumberFormat("00").format(days)} DÍAS',
              style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: kFavPrimary),
            ),
            const SizedBox(height: 1),
            const Text(
              'PARA EL FESTIVAL',
              style: TextStyle(fontSize: 30, color: kFavPrimary),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: kFavSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () => launchUrlString('http://festival.loja.gob.ec'),
              child: const Text(
                'Visitar página web',
                style: TextStyle(color: kFavPrimary, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
