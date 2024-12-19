import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/presentation/state/locale_provider.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  static const routeName = '/language';
  static const String name = 'language-screen';

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final List<Map<String, String>> languages = [
    {'name': 'Español', 'flag': '🇪🇸', 'code': 'es'},
    {'name': 'English', 'flag': '🇺🇸', 'code': 'en'},
  ];

  String selectedLanguage = 'es';

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Text(
              AppLocalizations.of(context)!.languageTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.languageChoose,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      tileColor: selectedLanguage == language['code']
                          ? Colors.blue.shade100
                          : Colors.white,
                      leading: Text(
                        language['name']!,
                        style: const TextStyle(fontSize: 15),
                      ),
                      trailing: Radio<String>(
                        value: language['code']!,
                        groupValue: selectedLanguage,
                        onChanged: (value) {
                          localeProvider.setLocale(Locale(value!, ''));
                          setState(() {
                            selectedLanguage = value;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                      onTap: () {
                        localeProvider.setLocale(Locale(language['code']!, ''));
                        setState(() {
                          selectedLanguage = language['code']!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.languageFooterText,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                context.pop();
              },
              child: Text(
                AppLocalizations.of(context)!.languageTextButton,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
