import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loja_movil/src/presentation/MenuPages/about_us.dart';
import 'package:loja_movil/src/presentation/MenuPages/language.dart';
import 'package:loja_movil/src/presentation/MenuPages/frequent_questions.dart';

class MenuLeft extends StatelessWidget {
  const MenuLeft({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 270,
      shape: const RoundedRectangleBorder(),
      child: Container(
        width: 140,
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          image: DecorationImage(
              image: AssetImage("assets/images/background-menu.png"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 180.0,
                      padding: const EdgeInsets.only(top: 70.0),
                      child: Image.asset('assets/images/loja-en-linea.png'),
                    ),
                  ],
                )),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.menuHomeTitle,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        context.pop();
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.desktop_mac_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.menuOnlineProcedures,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () => launchUrl(
                        Uri.parse('https://tramites.loja.gob.ec/#/'),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.question_mark_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!
                            .menuFrequentlyAskedQuestions,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        context.push(FrequentQuestions.routeName);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.language_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.menuLanguage,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        context.push(LanguagePage.routeName);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.menuAboutUs,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        context.push(AboutUs.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        color: Colors.white,
                        onPressed: () => launchUrl(
                          Uri.parse(
                              'https://www.youtube.com/channel/UC-BvWC0CNN-7RTq0vw11pww'),
                        ),
                        icon: const Icon(
                          FontAwesomeIcons.youtube,
                          size: 20,
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () => launchUrl(
                          Uri.parse(
                              'https://www.instagram.com/municipiodeloja'),
                        ),
                        icon: const Icon(
                          FontAwesomeIcons.instagram,
                          size: 20,
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () => launchUrl(
                          Uri.parse(
                              'https://www.facebook.com/MunicipiodeLoja/'),
                        ),
                        icon: const Icon(
                          FontAwesomeIcons.facebookF,
                          size: 20,
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () => launchUrl(
                          Uri.parse('https://twitter.com/municipiodeloja'),
                        ),
                        icon: const Icon(
                          FontAwesomeIcons.xTwitter,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Image.asset(
                    'assets/images/logos/logo_loja.png',
                    height: 60.0,
                  ),
                  const SizedBox(
                    height: 65,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
