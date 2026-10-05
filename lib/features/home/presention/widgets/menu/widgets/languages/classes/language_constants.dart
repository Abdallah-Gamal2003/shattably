import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String languageCodeKey = 'languageCode';

//languages code
const String english = 'en';
const String arabic = 'ar';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(languageCodeKey, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(languageCodeKey) ?? english;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case english:
      return const Locale(english, '');
    case arabic:
      return const Locale(arabic, "");
    default:
      return const Locale(english, '');
  }
}

// AppLocalizations translation(BuildContext context) {
//   return AppLocalizations.of(context)!;
// }

