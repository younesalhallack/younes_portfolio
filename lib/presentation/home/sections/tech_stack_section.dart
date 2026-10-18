import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_colors.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_sizes.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_text_styles.dart';
import '../../../core/localization/app_translations.dart';
import '../../../core/state/app_settings.dart';

class _TechItem {
  final String label;
  final IconData icon;
  const _TechItem(this.label, this.icon);
}

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  static const List<_TechItem> _techs = [
    _TechItem('Flutter', Icons.flutter_dash_rounded),
    _TechItem('Dart', Icons.code_rounded),
    _TechItem('Riverpod', Icons.hub_rounded),
    _TechItem('Clean Architecture', Icons.layers_rounded),
    _TechItem('Node.js', Icons.terminal_rounded),
    _TechItem('NestJS', Icons.account_tree_rounded),
    _TechItem('REST APIs', Icons.api_rounded),
    _TechItem('Firebase', Icons.local_fire_department_rounded),
    _TechItem('MySQL / SQL', Icons.storage_rounded),
    _TechItem('ISAR / SQLite', Icons.sd_storage_rounded),
    _TechItem('Git', Icons.merge_type_rounded),
    _TechItem('Payment Gateways', Icons.payments_rounded),
    // Re-enable only if you actually use CI/CD (GitHub Actions, Codemagic...):
    // _TechItem('CI/CD', Icons.settings_suggest_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, _) {
        final settings = AppSettings.instance;
        final isDark = settings.isDarkMode;
        final isArabic = settings.isArabic;
        final primaryColor = isDark
            ? AppColors.darkPrimary
            : AppColors.lightPrimary;
        final surfaceColor = isDark
            ? AppColors.darkSurface
            : AppColors.lightSurface;
        final borderColor = isDark
            ? AppColors.darkBorder
            : AppColors.lightBorder;
        final textColor = isDark
            ? AppColors.darkTextPrimary
            : AppColors.lightTextPrimary;

        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < AppSizes.breakpointMobile;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSizes.spacingMd : AppSizes.spacingXl,
            vertical: AppSizes.spacingXl,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSizes.maxContentWidth,
              ),
              child: Column(
                children: [
                  Text(
                        AppTranslations.translate('techstack_title', isArabic),
                        style: AppTextStyles.sectionTitle(isDark),
                      )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.2, end: 0),

                  const SizedBox(height: AppSizes.spacingSm),

                  Text(
                    AppTranslations.translate('techstack_subtitle', isArabic),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.sectionSubtitle(isDark),
                  ).animate().fadeIn(duration: 500.ms, delay: 100.ms),

                  const SizedBox(height: AppSizes.spacingLg),

                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: AppSizes.spacingMd,
                    runSpacing: AppSizes.spacingMd,
                    children: List.generate(_techs.length, (index) {
                      final tech = _techs[index];
                      return Container(
                            width: isMobile ? 140 : 160,
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: BorderRadius.circular(
                                AppSizes.radiusMedium,
                              ),
                              border: Border.all(color: borderColor),
                            ),
                            child: Column(
                              children: [
                                Icon(tech.icon, color: primaryColor, size: 30),
                                const SizedBox(height: 10),
                                Text(
                                  tech.label,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 400.ms, delay: (80 * index).ms)
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            end: const Offset(1, 1),
                          );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
