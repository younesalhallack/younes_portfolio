import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_colors.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_sizes.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_text_styles.dart';
import 'package:younes_alhallack_portfolio/core/utils/url_launcher_helper.dart';

import '../../../core/localization/app_translations.dart';
import '../../../core/state/app_settings.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, _) {
        final settings = AppSettings.instance;
        final isDark = settings.isDarkMode;
        final isArabic = settings.isArabic;

        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < AppSizes.breakpointMobile;
        final isWide = screenWidth >= AppSizes.breakpointTablet;

        final photo = _RotatingGradientAvatar(isDark: isDark)
            .animate()
            .fadeIn(duration: 600.ms)
            .scale(
              begin: const Offset(0.85, 0.85),
              end: const Offset(1, 1),
              curve: Curves.easeOutBack,
              duration: 700.ms,
            );

        final textBlock = Column(
          crossAxisAlignment: isWide
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Text(
                  AppTranslations.translate('about_title', isArabic),
                  textAlign: isWide ? TextAlign.start : TextAlign.center,
                  style: AppTextStyles.sectionTitle(isDark),
                )
                .animate()
                .fadeIn(duration: 500.ms, delay: 150.ms)
                .slideY(begin: 0.2, end: 0),

            const SizedBox(height: AppSizes.spacingSm),

            Text(
              AppTranslations.translate('about_subtitle', isArabic),
              textAlign: isWide ? TextAlign.start : TextAlign.center,
              style: AppTextStyles.sectionSubtitle(isDark),
            ).animate().fadeIn(duration: 500.ms, delay: 250.ms),

            const SizedBox(height: AppSizes.spacingMd),

            Text(
                  AppTranslations.translate('about_bio', isArabic),
                  textAlign: isWide ? TextAlign.start : TextAlign.center,
                  style: AppTextStyles.bodyLarge(isDark),
                )
                .animate()
                .fadeIn(duration: 500.ms, delay: 350.ms)
                .slideY(begin: 0.15, end: 0),

            const SizedBox(height: AppSizes.spacingMd),

            Wrap(
              alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
              spacing: AppSizes.spacingMd,
              runSpacing: AppSizes.spacingSm,
              children: [
                _StatChip(
                  icon: Icons.flutter_dash_rounded,
                  label: AppTranslations.translate(
                    'hero_years_flutter',
                    isArabic,
                  ),
                  isDark: isDark,
                ),
                _StatChip(
                  icon: Icons.account_balance_rounded,
                  label: AppTranslations.translate(
                    'hero_years_fintech',
                    isArabic,
                  ),
                  isDark: isDark,
                ),
              ],
            ).animate().fadeIn(duration: 500.ms, delay: 450.ms),

            const SizedBox(height: AppSizes.spacingLg),

            Align(
                  alignment: isWide
                      ? (isArabic
                            ? Alignment.centerRight
                            : Alignment.centerLeft)
                      : Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient(isDark),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => UrlLauncherHelper.launchAssetFile(
                          'cv/Younes_Alhallack_CV.pdf',
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.download_rounded,
                                size: 18,
                                color: isDark
                                    ? AppColors.darkBackground
                                    : Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                AppTranslations.translate(
                                  'about_download_cv',
                                  isArabic,
                                ),
                                style: TextStyle(
                                  color: isDark
                                      ? AppColors.darkBackground
                                      : Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 500.ms, delay: 550.ms)
                .slideY(begin: 0.15, end: 0),
          ],
        );

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
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        photo,
                        const SizedBox(width: AppSizes.spacingXl),
                        Expanded(child: textBlock),
                      ],
                    )
                  : Column(
                      children: [
                        photo,
                        const SizedBox(height: AppSizes.spacingLg),
                        textBlock,
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

/// صورة شخصية دائرية ثابتة، محاطة بحلقة تدرج لوني (Sweep Gradient)
/// تدور باستمرار وببطء خلفها — تأثير "هالة نيون" ينسجم مع الطابع المستقبلي.
class _RotatingGradientAvatar extends StatefulWidget {
  final bool isDark;
  const _RotatingGradientAvatar({required this.isDark});

  @override
  State<_RotatingGradientAvatar> createState() =>
      _RotatingGradientAvatarState();
}

class _RotatingGradientAvatarState extends State<_RotatingGradientAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondary = isDark
        ? AppColors.darkSecondary
        : AppColors.lightSecondary;
    final bgColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    const double ringSize = 230;
    const double photoSize = 200;

    return SizedBox(
      width: ringSize,
      height: ringSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ---------------- Rotating Gradient Ring ----------------
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * pi,
                child: child,
              );
            },
            child: Container(
              width: ringSize,
              height: ringSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    primary,
                    secondary,
                    primary.withOpacity(0.15),
                    primary,
                  ],
                  stops: const [0.0, 0.4, 0.75, 1.0],
                ),
              ),
            ),
          ),

          // ---------------- Mask (يُظهر الحلقة كإطار رفيع فقط) ----------------
          Container(
            width: ringSize - 10,
            height: ringSize - 10,
            decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
          ),

          // ---------------- Soft Glow ----------------
          Container(
            width: photoSize + 10,
            height: photoSize + 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(0.35),
                  blurRadius: 36,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),

          // ---------------- Static Profile Photo ----------------
          Container(
            width: photoSize,
            height: photoSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: bgColor, width: 4),
              image: const DecorationImage(
                image: AssetImage('assets/images/profile.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final bgColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurfaceElevated;
    final iconColor = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
