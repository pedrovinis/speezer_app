import 'package:flutter/material.dart';
import 'package:speezer_app/widgets/HomePage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(const SpeezerApp());

class SpeezerApp extends StatelessWidget {
  const SpeezerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speezer App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primaryColor: Colors.black,
        primarySwatch: Colors.deepPurple,
        highlightColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Arial',
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => const HomePage(),
        '/discover': (context) => const HomePage(),
      },
    );
  }
}
