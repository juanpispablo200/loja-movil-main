import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('es');

  Locale get locale => _locale;

  final List<Locale> supportedLocales = [
    const Locale('en', ''),
    const Locale('es', ''),
  ];

  void setLocale(Locale locale) {
    if (supportedLocales.contains(locale)) {
      _locale = locale;
      notifyListeners();
    }
  }
}
