import 'package:flutter/material.dart';

///   color xonstant for both theme (Neon Cyan / Navy)
/// : (White / Light Grey / Blue).
class AppColors {
  AppColors._();

  // ---------------- Dark Theme (Futuristic Navy + Neon Cyan) ----------------
  static const Color darkBackground = Color(0xFF0A0E17);
  static const Color darkSurface = Color(0xFF12182B);
  static const Color darkSurfaceElevated = Color(0xFF1A2238);
  static const Color darkPrimary = Color(0xFF00F5FF); // Neon Cyan
  static const Color darkSecondary = Color(0xFF7B61FF); // Neon Purple accent
  static const Color darkTextPrimary = Color(0xFFF5F7FA);
  static const Color darkTextSecondary = Color(0xFF9AA5B8);
  static const Color darkBorder = Color(0xFF243055);

  // ---------------- Light Theme (Clean White + Blue) ----------------
  static const Color lightBackground = Color(0xFFF7F9FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF0F3F9);
  static const Color lightPrimary = Color(0xFF0066FF);
  static const Color lightSecondary = Color(0xFF5B47FB);
  static const Color lightTextPrimary = Color(0xFF14172B);
  static const Color lightTextSecondary = Color(0xFF5C6478);
  static const Color lightBorder = Color(0xFFE1E6EF);

  // ---------------- Shared / Semantic ----------------
  static const Color success = Color(0xFF00D68F);
  static const Color error = Color(0xFFFF4D6A);

  ///
  static const LinearGradient darkPrimaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [darkPrimary, darkSecondary], // Cyan -> Purple
  );

  static const LinearGradient lightPrimaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lightPrimary, lightSecondary], // Blue -> Purple
  );

  static const LinearGradient darkBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [darkBackground, Color(0xFF0D1420), darkBackground],
  );

  static const LinearGradient lightBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [lightBackground, Color(0xFFEFF3FA), lightBackground],
  );

  static LinearGradient primaryGradient(bool isDark) =>
      isDark ? darkPrimaryGradient : lightPrimaryGradient;

  static LinearGradient backgroundGradient(bool isDark) =>
      isDark ? darkBackgroundGradient : lightBackgroundGradient;
}
