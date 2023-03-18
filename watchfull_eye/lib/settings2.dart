// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // ...

// Future<Locale> _getLocale() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String languageCode = prefs.getString('language') ?? 'en';
//   return Locale(languageCode);
// }

// MaterialApp(
//   // ...
//   locale,
//   localizationsDelegates = AppLocalizations.localizationsDelegates,
//   supportedLocales = AppLocalizations.supportedLocales,
//   home = FutureBuilder<Locale>(
//     future: _getLocale(),
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         return Builder(
//           builder: (context) {
//             // Set the locale for this MaterialApp
//             return MaterialApp(
//               locale: snapshot.data,
//               localizationsDelegates: AppLocalizations.localizationsDelegates,
//               supportedLocales: AppLocalizations.supportedLocales,
//               home: MyHomePage(),
//             );
//           },
//         );
//       } else {
//         return CircularProgressIndicator();
//       }
//     },
//   ),
//   // ...
// )
