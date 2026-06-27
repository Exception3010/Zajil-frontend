import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zajil/l10n/app_localizations.dart';

import 'firebase_options.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final String? languageCode = prefs.getString('language_code');

  runApp(MyApp(savedLocale: languageCode != null ? Locale(languageCode) : null));
}

class MyApp extends StatefulWidget {
  final Locale? savedLocale;
  const MyApp({super.key, this.savedLocale});

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    if (widget.savedLocale != null) {
      _locale = widget.savedLocale!;
    } else {
      final String deviceLocale = Platform.localeName.split('_')[0];
      if (deviceLocale == 'ar') {
        _locale = const Locale('ar');
      } else {
        _locale = const Locale('en');
      }
    }
  }

  void setLocale(Locale value) async {
    setState(() {
      _locale = value;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', value.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zajil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D6683),
          primary: const Color(0xFF0D6683),
          surface: const Color(0xFFF7FAFC),
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: const SplashScreen(),
    );
  }
}
