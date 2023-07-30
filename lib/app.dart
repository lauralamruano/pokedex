import 'package:flutter/material.dart';
import 'package:pokedex/l10n/l10n.dart';
import 'package:pokedex/ui/views/welcome/welcome_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFFD500F9)),
        colorScheme: ColorScheme.light(
          primary:  Color(0xFFD500F9),
          secondary: Color(0xFFE1BEE7)
        ),
      ),
      home: Welcome(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
