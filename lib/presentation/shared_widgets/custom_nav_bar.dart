import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_colors.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_sizes.dart';
import '../../core/localization/app_translations.dart';
import '../../core/state/app_settings.dart';
import '../../core/state/nav_controller.dart';

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  /// دوال اختيارية للانتقال السلس عند الضغط على رابط تنقل.
  /// تبقى null حتى تُفعَّل من home_page.dart في المرحلة القادمة (Scroll Spy).
  final VoidCallback? onHomeTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;

  const CustomNavBar({
    super.key,
    this.onHomeTap,
    this.onAboutTap,
    this.onProjectsTap,
    this.onContactTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        AppSettings.instance,
        NavBarController.instance,
      ]),
      builder: (context, _) {
        final settings = AppSettings.instance;
        final navState = NavBarController.instance;
        final isDark = settings.isDarkMode;
        final isArabic = settings.isArabic;
        final isScrolled = navState.isScrolled;

        final borderColor = isDark
            ? AppColors.darkBorder
            : AppColors.lightBorder;
        final textColor = isDark
            ? AppColors.darkTextPrimary
            : AppColors.lightTextPrimary;
        final primaryColor = isDark
            ? AppColors.darkPrimary
            : AppColors.lightPrimary;

        final screenWidth = MediaQuery.of(context).size.width;
        final showNavLinks = screenWidth >= AppSizes.breakpointTablet;

        // خلفية زجاجية: شفافية أقل وضبابية أقوى عند بداية الصفحة (فوق الـ Hero)،
        // وتصبح أكثر وضوحاً (Solid) عند التمرير للأسفل، مع ظل خفيف.
        final glassOpacity = isScrolled ? 0.75 : 0.35;
        final blurAmount = isScrolled ? 18.0 : 10.0;
        final bgTint = isDark
            ? AppColors.darkBackground
            : AppColors.lightBackground;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          height: preferredSize.height,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  color: bgTint.withOpacity(glassOpacity),
                  border: Border(
                    bottom: BorderSide(
                      color: isScrolled
                          ? borderColor
                          : borderColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  boxShadow: isScrolled
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              isDark ? 0.25 : 0.06,
                            ),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.spacingLg,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ---------------- Logo / Name ----------------
                        Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.primaryGradient(isDark),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                isArabic ? 'ي' : 'Y',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: isDark
                                      ? AppColors.darkBackground
                                      : Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSizes.spacingSm),
                            Text(
                              AppTranslations.translate('nav_name', isArabic),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),

                        // ---------------- Nav Links (Desktop/Tablet only) ----------------
                        if (showNavLinks)
                          Row(
                            children: [
                              _NavLinkItem(
                                label: AppTranslations.translate(
                                  'nav_home',
                                  isArabic,
                                ),
                                isActive:
                                    navState.activeSection ==
                                    PortfolioSection.hero,
                                onTap: onHomeTap,
                                isDark: isDark,
                              ),
                              const SizedBox(width: AppSizes.spacingLg),
                              _NavLinkItem(
                                label: AppTranslations.translate(
                                  'nav_about',
                                  isArabic,
                                ),
                                isActive:
                                    navState.activeSection ==
                                    PortfolioSection.about,
                                onTap: onAboutTap,
                                isDark: isDark,
                              ),
                              const SizedBox(width: AppSizes.spacingLg),
                              _NavLinkItem(
                                label: AppTranslations.translate(
                                  'nav_projects',
                                  isArabic,
                                ),
                                isActive:
                                    navState.activeSection ==
                                    PortfolioSection.projects,
                                onTap: onProjectsTap,
                                isDark: isDark,
                              ),
                              const SizedBox(width: AppSizes.spacingLg),
                              _NavLinkItem(
                                label: AppTranslations.translate(
                                  'nav_contact',
                                  isArabic,
                                ),
                                isActive:
                                    navState.activeSection ==
                                    PortfolioSection.contact,
                                onTap: onContactTap,
                                isDark: isDark,
                              ),
                            ],
                          ),

                        // ---------------- Actions ----------------
                        Row(
                          children: [
                            _ActionIconButton(
                              tooltip: AppTranslations.translate(
                                'lang_toggle_tooltip',
                                isArabic,
                              ),
                              onTap: settings.toggleLocale,
                              isDark: isDark,
                              child: Text(
                                isArabic ? 'EN' : 'AR',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSizes.spacingSm),
                            _ActionIconButton(
                              tooltip: AppTranslations.translate(
                                'theme_toggle_tooltip',
                                isArabic,
                              ),
                              onTap: settings.toggleTheme,
                              isDark: isDark,
                              child: Icon(
                                isDark
                                    ? Icons.light_mode_rounded
                                    : Icons.dark_mode_rounded,
                                size: 20,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// رابط تنقل واحد في الشريط، مع خط متحرك أسفله عند كونه القسم النشط (Scroll Spy).
class _NavLinkItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onTap;
  final bool isDark;

  const _NavLinkItem({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDark
        ? AppColors.darkPrimary
        : AppColors.lightPrimary;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final inactiveColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? textColor : inactiveColor,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 2,
                width: isActive ? 18 : 0,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  final String tooltip;
  final VoidCallback onTap;
  final bool isDark;
  final Widget child;

  const _ActionIconButton({
    required this.tooltip,
    required this.onTap,
    required this.isDark,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final bgColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurfaceElevated;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor.withOpacity(0.7),
              border: Border.all(color: borderColor),
            ),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
