// // import 'package:flutter/material.dart';
// // import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // // ...

// // Future<Locale> _getLocale() async {
// //   SharedPreferences prefs = await SharedPreferences.getInstance();
// //   String languageCode = prefs.getString('language') ?? 'en';
// //   return Locale(languageCode);
// // }

// // MaterialApp(
// //   // ...
// //   locale,
// //   localizationsDelegates = AppLocalizations.localizationsDelegates,
// //   supportedLocales = AppLocalizations.supportedLocales,
// //   home = FutureBuilder<Locale>(
// //     future: _getLocale(),
// //     builder: (context, snapshot) {
// //       if (snapshot.hasData) {
// //         return Builder(
// //           builder: (context) {
// //             // Set the locale for this MaterialApp
// //             return MaterialApp(
// //               locale: snapshot.data,
// //               localizationsDelegates: AppLocalizations.localizationsDelegates,
// //               supportedLocales: AppLocalizations.supportedLocales,
// //               home: MyHomePage(),
// //             );
// //           },
// //         );
// //       } else {
// //         return CircularProgressIndicator();
// //       }
// //     },
// //   ),
// //   // ...
// // )

// import 'dart:async';
// import 'dart:io';

// import 'package:aws_s3/aws_s3.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// Future<void> downloadWavFilesFromS3AndUploadToFirebase(List<String> fileUrls) async {
//   final s3 = AwsS3(accessKey: 'YOUR_AWS_ACCESS_KEY', secretKey: 'YOUR_AWS_SECRET_KEY');

//   final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

//   for (final url in fileUrls) {
//     final response = await s3.getObject(url);
//     final data = response.bodyBytes;
//     final fileName = url.split('/').last;
//     final storageReference = firebaseStorage.ref().child(fileName);
//     final uploadTask = storageReference.putData(data);
//     await uploadTask.whenComplete(() => print('$fileName uploaded to Firebase storage'));
//   }
// }
