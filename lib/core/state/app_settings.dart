import 'package:flutter/material.dart';

/// ChangeNotifier for theme and lang
class AppSettings extends ChangeNotifier {
  AppSettings._internal();

  ///   (Singleton)
  static final AppSettings instance = AppSettings._internal();

  // ---------------------------------------------------------------------
  // Theme Mode
  // ---------------------------------------------------------------------
  ThemeMode _themeMode = ThemeMode.dark; //  dark theme is default

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void setTheme(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }

  // ---------------------------------------------------------------------
  // Locale (Language)
  // ---------------------------------------------------------------------
  Locale _locale = const Locale('en'); // arabic is default

  Locale get locale => _locale;

  bool get isArabic => _locale.languageCode == 'ar';

  TextDirection get textDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;

  void toggleLocale() {
    _locale = isArabic ? const Locale('en') : const Locale('ar');
    notifyListeners();
  }

  void setLocale(Locale locale) {
    if (_locale.languageCode == locale.languageCode) return;
    _locale = locale;
    notifyListeners();
  }
}
