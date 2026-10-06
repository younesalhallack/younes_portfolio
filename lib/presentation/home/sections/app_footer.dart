import 'package:flutter/material.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_colors.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_sizes.dart';
import 'package:younes_alhallack_portfolio/core/localization/app_translations.dart';
import 'package:younes_alhallack_portfolio/core/state/app_settings.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, _) {
        final settings = AppSettings.instance;
        final isDark = settings.isDarkMode;
        final isArabic = settings.isArabic;
        final borderColor = isDark
            ? AppColors.darkBorder
            : AppColors.lightBorder;
        final textSecondary = isDark
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary;
        final primaryColor = isDark
            ? AppColors.darkPrimary
            : AppColors.lightPrimary;

        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < AppSizes.breakpointMobile;
        final year = DateTime.now().year;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSizes.spacingMd : AppSizes.spacingXl,
            vertical: AppSizes.spacingLg,
          ),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: borderColor)),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSizes.maxContentWidth,
              ),
              child: Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.center,
                children: [
                  Text(
                    '© $year ${AppTranslations.translate('nav_name', isArabic)} — '
                    '${AppTranslations.translate('footer_rights', isArabic)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: textSecondary),
                  ),
                  if (isMobile) const SizedBox(height: AppSizes.spacingSm),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.flutter_dash_rounded,
                        size: 16,
                        color: primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        AppTranslations.translate('footer_made_with', isArabic),
                        style: TextStyle(fontSize: 13, color: textSecondary),
                      ),
                    ],
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
