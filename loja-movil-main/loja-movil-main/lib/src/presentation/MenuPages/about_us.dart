import 'package:flutter/material.dart';
import 'package:loja_movil/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  static const routeName = '/about_us';
  static const String name = 'about-us-screen';

  @override
  State<AboutUs> createState() => _AboutUs();
}

class _AboutUs extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.menuPageAboutUsTitle,
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
              padding: const EdgeInsets.only(right: 15.0),
              child: Image.asset(
                'assets/images/escudo.png',
                height: 40,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: SizedBox(
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 25),
                    Center(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [Colors.transparent, Colors.black],
                            stops: [0.5, 1.0],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.dstOut,
                        child: Image.asset(
                          'assets/images/municipio-loja.jpeg',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      AppLocalizations.of(context)!.institutionName,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Text(
                      AppLocalizations.of(context)!.menuPageAboutUsDescription,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 30.0),
                    Text(
                        AppLocalizations.of(context)!
                            .menuPageAboutUsDevelopedBy,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10.0),
                    Text(
                        AppLocalizations.of(context)!.menuPageAboutUsDevelopers,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontStyle: FontStyle.italic)),
                    const SizedBox(height: 10),
                    Text(
                        '${AppLocalizations.of(context)!.menuPageAboutUsAppVersion} 1.5.0',
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontStyle: FontStyle.italic)),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                            onPressed: () => launchUrl(
                                  Uri.parse(
                                      'https://www.loja.gob.ec/privacidad/politica-de-privacidad-loja-en-linea'),
                                ),
                            icon: const Icon(
                              Icons.description_outlined,
                              color: kPrimaryColor,
                            ),
                            label: Column(
                              children: [
                                Text(
                                    AppLocalizations.of(context)!
                                        .menuPrivacyPolicy,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: kPrimaryColor,
                                    ))
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 1, 45),
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () =>
                          launchUrlString('https://www.loja.gob.ec'),
                      child: Text(
                        AppLocalizations.of(context)!.commonVisitWebPage,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
