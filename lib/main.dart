import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trabalho_flutter/app_theme.dart';
import 'package:trabalho_flutter/ui/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unipar - CNF',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeClass.darkTheme,
      darkTheme: ThemeClass.darkTheme,
      home: const HomePage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('pt')
      ],
    );
  }
}