import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_colors.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_sizes.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_text_styles.dart';
import 'package:younes_alhallack_portfolio/core/utils/contact_form_service.dart';
import 'package:younes_alhallack_portfolio/core/utils/url_launcher_helper.dart';

import '../../../core/localization/app_translations.dart';
import '../../../core/state/app_settings.dart';

// ---------------------------------------------------------------------
// ⚠️ بيانات التواصل غير الظاهرة كنص على الصفحة (فقط أيقونات قابلة للنقر).
// عدّل القيم التالية بمعلوماتك الحقيقية:
// ---------------------------------------------------------------------
const String _githubUrl = 'github.com/younesalhallack';
const String _whatsappNumber = '963XXXXXXXXX'; // بدون + أو أصفار بادئة
const String _telegramUsername = 'your_telegram_username';

/// قسم "تواصل معي": نموذج رسالة يُرسِل عبر Formspree إلى بريدك دون
/// عرضه أبداً، بالإضافة إلى أيقونات GitHub/WhatsApp/Telegram فقط
/// (بدون عرض الرقم أو الرابط كنص على الصفحة).
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSizes.spacingMd : AppSizes.spacingXl,
            vertical: AppSizes.spacingXl,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                children: [
                  Text(
                        AppTranslations.translate('contact_title', isArabic),
                        style: AppTextStyles.sectionTitle(isDark),
                      )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.2, end: 0),

                  const SizedBox(height: AppSizes.spacingSm),

                  Text(
                    AppTranslations.translate('contact_subtitle', isArabic),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.sectionSubtitle(isDark),
                  ).animate().fadeIn(duration: 500.ms, delay: 100.ms),

                  const SizedBox(height: AppSizes.spacingLg),

                  const _ContactForm()
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 200.ms)
                      .slideY(begin: 0.15, end: 0),

                  const SizedBox(height: AppSizes.spacingLg),

                  Text(
                    AppTranslations.translate('contact_social_title', isArabic),
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 300.ms),

                  const SizedBox(height: AppSizes.spacingMd),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SocialIconButton(
                        iconData: FontAwesomeIcons.github,
                        tooltip: 'GitHub',
                        isDark: isDark,
                        onTap: () => UrlLauncherHelper.launchWebUrl(_githubUrl),
                      ),
                      const SizedBox(width: AppSizes.spacingMd),
                      _SocialIconButton(
                        iconData: FontAwesomeIcons.whatsapp,
                        tooltip: 'WhatsApp',
                        isDark: isDark,
                        onTap: () => UrlLauncherHelper.launchWebUrl(
                          'wa.me/$_whatsappNumber',
                        ),
                      ),
                      const SizedBox(width: AppSizes.spacingMd),
                      _SocialIconButton(
                        iconData: FontAwesomeIcons.telegram,
                        tooltip: 'Telegram',
                        isDark: isDark,
                        onTap: () => UrlLauncherHelper.launchWebUrl(
                          't.me/$_telegramUsername',
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 500.ms, delay: 400.ms),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

enum _FormStatus { idle, sending, success, error }

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  _FormStatus _status = _FormStatus.idle;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit(bool isArabic) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _status = _FormStatus.sending);

    final result = await ContactFormService.sendMessage(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      message: _messageController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      _status = result == ContactFormResult.success
          ? _FormStatus.success
          : _FormStatus.error;
    });

    if (result == ContactFormResult.success) {
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettings.instance;
    final isDark = settings.isDarkMode;
    final isArabic = settings.isArabic;

    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final fillColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final primaryColor = isDark
        ? AppColors.darkPrimary
        : AppColors.lightPrimary;

    InputDecoration decoration(String labelKey) => InputDecoration(
      labelText: AppTranslations.translate(labelKey, isArabic),
      filled: true,
      fillColor: fillColor,
      labelStyle: TextStyle(
        color: isDark
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        borderSide: BorderSide(color: primaryColor, width: 1.5),
      ),
    );

    final isSending = _status == _FormStatus.sending;

    return Container(
      padding: const EdgeInsets.all(AppSizes.spacingMd),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurface.withOpacity(0.4)
            : AppColors.lightSurfaceElevated,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(color: borderColor),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              style: TextStyle(color: textColor),
              decoration: decoration('contact_form_name'),
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? '' : null,
            ),
            const SizedBox(height: AppSizes.spacingMd),

            TextFormField(
              controller: _emailController,
              style: TextStyle(color: textColor),
              keyboardType: TextInputType.emailAddress,
              decoration: decoration('contact_form_email'),
              validator: (value) {
                final v = value?.trim() ?? '';
                final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                return emailRegex.hasMatch(v) ? null : '';
              },
            ),
            const SizedBox(height: AppSizes.spacingMd),

            TextFormField(
              controller: _messageController,
              style: TextStyle(color: textColor),
              minLines: 4,
              maxLines: 6,
              decoration: decoration('contact_form_message'),
              validator: (value) =>
                  (value == null || value.trim().length < 5) ? '' : null,
            ),
            const SizedBox(height: AppSizes.spacingMd),

            if (_status == _FormStatus.error)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.spacingSm),
                child: Text(
                  AppTranslations.translate('contact_form_error', isArabic),
                  style: const TextStyle(color: AppColors.error, fontSize: 13),
                ),
              ),

            if (_status == _FormStatus.success)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.spacingSm),
                child: Text(
                  AppTranslations.translate('contact_form_success', isArabic),
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: 13,
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
                  onTap: isSending ? null : () => _submit(isArabic),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isSending)
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: isDark
                                  ? AppColors.darkBackground
                                  : Colors.white,
                            ),
                          )
                        else
                          Icon(
                            Icons.send_rounded,
                            size: 18,
                            color: isDark
                                ? AppColors.darkBackground
                                : Colors.white,
                          ),
                        const SizedBox(width: 8),
                        Text(
                          AppTranslations.translate(
                            isSending
                                ? 'contact_form_sending'
                                : 'contact_form_send',
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final dynamic iconData;
  final String tooltip;
  final bool isDark;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.iconData,
    required this.tooltip,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final bgColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurfaceElevated;
    final iconColor = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
              border: Border.all(color: borderColor),
            ),
            alignment: Alignment.center,
            child: FaIcon(iconData, size: 20, color: iconColor),
          ),
        ),
      ),
    );
  }
}
