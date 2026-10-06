import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Google Fonts (Poppins  Inter ).
class AppTextStyles {
  AppTextStyles._();

  static TextStyle heroTitle(bool isDark) => GoogleFonts.poppins(
    fontSize: 52,
    fontWeight: FontWeight.w700,
    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
    height: 1.15,
  );

  static TextStyle heroSubtitle(bool isDark) => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
  );

  static TextStyle bodyLarge(bool isDark) => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
  );

  static TextStyle sectionTitle(bool isDark) => GoogleFonts.poppins(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
  );

  static TextStyle sectionSubtitle(bool isDark) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
  );

  static TextStyle buttonText(bool isDark) =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle navLink(bool isDark) => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
  );

  static TextStyle cardTitle(bool isDark) => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
  );

  static TextStyle cardBody(bool isDark) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
  );
}
