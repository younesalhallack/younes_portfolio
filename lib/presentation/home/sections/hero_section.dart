import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_colors.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_sizes.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_text_styles.dart';

import '../../../core/localization/app_translations.dart';
import '../../../core/state/app_settings.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;

  const HeroSection({super.key, this.onProjectsTap, this.onContactTap});

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

        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < AppSizes.breakpointMobile;

        return Stack(
          children: [
            // ملاحظة: طبقات الخلفية (الصورة المتحركة + التدرج + الجسيمات)
            // وتأثير توهج المؤشر (Cursor Glow) انتقلت إلى home_page.dart
            // كطبقات ثابتة لكامل الصفحة، تبقى خلف كل الأقسام أثناء التمرير.

            // ---------------- Foreground Content ----------------
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppSizes.spacingMd : AppSizes.spacingXl,
                vertical: AppSizes.spacingXl,
              ),
              constraints: const BoxConstraints(minHeight: 640),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppSizes.maxContentWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ---------------- Greeting ----------------
                      Text(
                            AppTranslations.translate(
                              'hero_greeting',
                              isArabic,
                            ),
                            style: TextStyle(
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 500.ms)
                          .slideY(begin: 0.3, end: 0),

                      const SizedBox(height: AppSizes.spacingSm),

                      // ---------------- Name (Staggered Letters + Gradient) ----------------
                      _StaggeredGradientName(
                        key: ValueKey(isArabic),
                        text: AppTranslations.translate('hero_name', isArabic),
                        isDark: isDark,
                        fontSize: isMobile ? 36 : 52,
                      ),

                      // ---------------- Typewriter Roles ----------------
                      SizedBox(
                        height: 36,
                        child: AnimatedTextKit(
                          key: ValueKey('typewriter_$isArabic'),
                          repeatForever: true,
                          pause: const Duration(milliseconds: 1200),
                          animatedTexts: [
                            _typewriterText(
                              'hero_role_1',
                              isArabic,
                              primaryColor,
                              isMobile,
                            ),
                            _typewriterText(
                              'hero_role_2',
                              isArabic,
                              primaryColor,
                              isMobile,
                            ),
                            _typewriterText(
                              'hero_role_3',
                              isArabic,
                              primaryColor,
                              isMobile,
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 600.ms, delay: 300.ms),

                      const SizedBox(height: AppSizes.spacingLg),

                      // ---------------- Description ----------------
                      Text(
                            AppTranslations.translate(
                              'hero_description',
                              isArabic,
                            ),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyLarge(isDark),
                          )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 450.ms)
                          .slideY(begin: 0.2, end: 0),

                      const SizedBox(height: AppSizes.spacingLg),

                      // ---------------- Experience Stats ----------------
                      Wrap(
                        alignment: WrapAlignment.center,
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
                      ).animate().fadeIn(duration: 600.ms, delay: 600.ms),

                      const SizedBox(height: AppSizes.spacingLg),

                      // ---------------- CTA Buttons ----------------
                      Wrap(
                            alignment: WrapAlignment.center,
                            spacing: AppSizes.spacingMd,
                            runSpacing: AppSizes.spacingSm,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient(isDark),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: onProjectsTap,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 28,
                                        vertical: 16,
                                      ),
                                      child: Text(
                                        AppTranslations.translate(
                                          'hero_cta_projects',
                                          isArabic,
                                        ),
                                        style: TextStyle(
                                          color: isDark
                                              ? AppColors.darkBackground
                                              : Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient(isDark),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: onContactTap,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 28,
                                        vertical: 16,
                                      ),
                                      child: Text(
                                        AppTranslations.translate(
                                          'hero_cta_contact',
                                          isArabic,
                                        ),
                                        style: TextStyle(
                                          color: isDark
                                              ? AppColors.darkBackground
                                              : Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 750.ms)
                          .slideY(begin: 0.2, end: 0),
                    ],
                  ),
                ),
              ),
            ),

            // ---------------- Scroll Down Indicator ----------------
            Positioned(
              bottom: AppSizes.spacingLg,
              left: 0,
              right: 0,
              child: Center(
                child:
                    Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 32,
                          color: primaryColor.withOpacity(0.8),
                        )
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .moveY(
                          begin: 0,
                          end: 10,
                          duration: 900.ms,
                          curve: Curves.easeInOut,
                        )
                        .fadeIn(duration: 600.ms, delay: 1000.ms),
              ),
            ),
          ],
        );
      },
    );
  }

  TypewriterAnimatedText _typewriterText(
    String key,
    bool isArabic,
    Color color,
    bool isMobile,
  ) {
    return TypewriterAnimatedText(
      AppTranslations.translate(key, isArabic),
      textAlign: TextAlign.center,
      speed: const Duration(milliseconds: 70),
      textStyle: TextStyle(
        fontSize: isMobile ? 18 : 24,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}

/// يعرض اسم يونس بتدرج لوني موحّد (ShaderMask فوق الاسم كاملاً)، مع ظهوره
/// تدريجياً بتأثير الآلة الكاتبة (Typewriter) كنص واحد متصل — بخلاف تقسيم
/// الأحرف يدوياً إلى Widgets منفصلة، هذه الطريقة تحافظ على تشكيل الحروف
/// العربية الصحيح (اتصال الحروف ببعضها) لأن الحروف تُرسم كسلسلة نصية
/// طبيعية وليس كرموز معزولة.
class _StaggeredGradientName extends StatelessWidget {
  final String text;
  final bool isDark;
  final double fontSize;

  const _StaggeredGradientName({
    super.key,
    required this.text,
    required this.isDark,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = AppTextStyles.heroTitle(
      isDark,
    ).copyWith(fontSize: fontSize, color: Colors.white);

    return ShaderMask(
      shaderCallback: (bounds) =>
          AppColors.primaryGradient(isDark).createShader(bounds),
      child: SizedBox(
        width: double.infinity,
        height: fontSize * 1.3,
        child: AnimatedTextKit(
          isRepeatingAnimation: false,
          animatedTexts: [
            TypewriterAnimatedText(
              text,
              textAlign: TextAlign.center,
              speed: const Duration(milliseconds: 90),
              textStyle: baseStyle,
            ),
          ],
        ),
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
