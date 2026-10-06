import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:younes_alhallack_portfolio/presentation/home/home_page.dart';

import 'core/state/app_settings.dart';
import 'core/theme/app_themes.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, _) {
        final settings = AppSettings.instance;

        return MaterialApp(
          title: 'Younes Al-Hallak | Flutter Developer',
          debugShowCheckedModeBanner: false,

          // ---------------- Theming ----------------
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: settings.themeMode,

          // ---------------- Localization ----------------
          locale: settings.locale,
          supportedLocales: const [Locale('ar'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          builder: (context, child) {
            return Directionality(
              textDirection: settings.textDirection,
              child: child ?? const SizedBox.shrink(),
            );
          },

          home: const HomePage(),
        );
      },
    );
  }
}
