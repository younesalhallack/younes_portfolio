import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_colors.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_sizes.dart';
import '../../core/localization/app_translations.dart';
import '../../core/state/app_settings.dart';

class InteractiveEmulator extends StatefulWidget {
  final String projectTitle;
  final IconData projectIcon;
  final Widget? demoWidget; // محتوى تفاعلي مخصص
  final List<String>? screenshots; // صور الشاشات (اختياري)
  final String? demoVideoPath; // مسار فيديو الديمو (WebM) (اختياري)

  const InteractiveEmulator({
    super.key,
    required this.projectTitle,
    required this.projectIcon,
    this.demoWidget,
    this.screenshots,
    this.demoVideoPath,
  });

  static void show(
    BuildContext context, {
    required String projectTitle,
    required IconData projectIcon,
    Widget? demoWidget,
    List<String>? screenshots,
    String? demoVideoPath,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (_) => InteractiveEmulator(
        projectTitle: projectTitle,
        projectIcon: projectIcon,
        demoWidget: demoWidget,
        screenshots: screenshots,
        demoVideoPath: demoVideoPath,
      ),
    );
  }

  @override
  State<InteractiveEmulator> createState() => _InteractiveEmulatorState();
}

class _InteractiveEmulatorState extends State<InteractiveEmulator> {
  int _currentImageIndex = 0;

  // ---------------- Video Player State ----------------
  VideoPlayerController? _videoController;
  bool _isVideoReady = false;
  bool _hasVideoError = false;

  @override
  void initState() {
    super.initState();
    if (widget.demoVideoPath != null) {
      _initVideo(widget.demoVideoPath!);
    }
  }

  void _initVideo(String path) {
    final controller = VideoPlayerController.asset(path);
    _videoController = controller;
    controller
        .initialize()
        .then((_) {
          if (!mounted) return;
          setState(() => _isVideoReady = true);
          controller
            ..setLooping(true)
            ..setVolume(
              0,
            ) // كتم الصوت افتراضياً لضمان التشغيل التلقائي في المتصفح
            ..play();
        })
        .catchError((_) {
          if (mounted) setState(() => _hasVideoError = true);
        });
  }

  void _toggleVideoPlayPause() {
    final controller = _videoController;
    if (controller == null || !_isVideoReady) return;
    setState(() {
      controller.value.isPlaying ? controller.pause() : controller.play();
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

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
        final screenBg = isDark
            ? AppColors.darkBackground
            : AppColors.lightBackground;
        final textColor = isDark
            ? AppColors.darkTextPrimary
            : AppColors.lightTextPrimary;
        final textSecondary = isDark
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary;

        // ---------------- Dynamic Phone Frame Sizing ----------------
        // نحسب الحجم المتاح فعلياً على الشاشة (بعد خصم insetPadding
        // والمسافة الفاصلة وزر الإغلاق) لتفادي أي Overflow على الشاشات
        // القصيرة، مع الحفاظ على نسبة العرض إلى الارتفاع الأصلية (1:2).
        final screenHeight = MediaQuery.of(context).size.height;
        const verticalChrome =
            24 * 2 +
            AppSizes.spacingMd +
            56; // insetPadding + spacing + close button
        final maxPhoneHeight = (screenHeight - verticalChrome).clamp(
          320.0,
          600.0,
        );
        final phoneHeight = maxPhoneHeight;
        final phoneWidth = (phoneHeight / 2).clamp(160.0, 300.0);

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ---------------- Phone Frame ----------------
              Container(
                width: phoneWidth,
                height: phoneHeight,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D0D0D),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.35),
                      blurRadius: 40,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Container(
                    color: screenBg,
                    child: Column(
                      children: [
                        // Notch
                        Container(
                          height: 28,
                          alignment: Alignment.center,
                          child: Container(
                            width: 90,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(14),
                              ),
                            ),
                          ),
                        ),

                        // Mini App Content
                        Expanded(
                          child: Directionality(
                            textDirection: settings.textDirection,
                            child: _buildScreenContent(
                              primaryColor: primaryColor,
                              textColor: textColor,
                              textSecondary: textSecondary,
                              isArabic: isArabic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.spacingMd),

              // ---------------- Close Button ----------------
              TextButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                label: Text(
                  AppTranslations.translate('emulator_close', isArabic),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // دالة تحديد نوع المحتوى المعروض
  // أولوية العرض: demoWidget المخصص > فيديو الديمو > صور الشاشات > محتوى افتراضي
  Widget _buildScreenContent({
    required Color primaryColor,
    required Color textColor,
    required Color textSecondary,
    required bool isArabic,
  }) {
    // 1. إذا تم تمرير ودجت تفاعلية مخصصة
    if (widget.demoWidget != null) {
      return widget.demoWidget!;
    }

    // 2. إذا تم تمرير مسار فيديو ديمو (WebM)
    if (widget.demoVideoPath != null) {
      return _buildVideoContent(primaryColor: primaryColor, isArabic: isArabic);
    }

    // 3. إذا تم تمرير صور للمشروع (Carousel)
    if (widget.screenshots != null && widget.screenshots!.isNotEmpty) {
      return Stack(
        children: [
          PageView.builder(
            itemCount: widget.screenshots!.length,
            onPageChanged: (index) {
              setState(() => _currentImageIndex = index);
            },
            itemBuilder: (context, index) {
              return Image.asset(
                widget.screenshots![index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
          ),
          // مؤشر النظرات (Dots)
          if (widget.screenshots!.length > 1)
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.screenshots!.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _currentImageIndex == index ? 16 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _currentImageIndex == index
                          ? primaryColor
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    }

    // 4. المحتوى الافتراضي (في حال عدم تمرير أي شيء)
    return Padding(
      padding: const EdgeInsets.all(AppSizes.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(widget.projectIcon, color: primaryColor, size: 26),
              Icon(Icons.more_vert_rounded, color: textSecondary, size: 20),
            ],
          ),
          const SizedBox(height: AppSizes.spacingMd),
          Text(
            widget.projectTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: textColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            AppTranslations.translate('emulator_title', isArabic),
            style: TextStyle(fontSize: 12, color: textSecondary),
          ),
          const SizedBox(height: AppSizes.spacingMd),
          const Expanded(
            child: Center(child: Text('Demo Preview Placeholder')),
          ),
        ],
      ),
    );
  }

  /// يعرض فيديو الديمو (WebM) بملء شاشة الهاتف، مع عنوان المشروع
  /// فوق تدرج شفاف أسفل الشاشة، وإمكانية إيقاف/تشغيل بالنقر.
  Widget _buildVideoContent({
    required Color primaryColor,
    required bool isArabic,
  }) {
    if (_hasVideoError) {
      return Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: Icon(Icons.error_outline_rounded, color: primaryColor, size: 32),
      );
    }

    if (!_isVideoReady || _videoController == null) {
      return Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: primaryColor,
          ),
        ),
      );
    }

    final controller = _videoController!;

    return GestureDetector(
      onTap: _toggleVideoPlayPause,
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.value.size.width,
              height: controller.value.size.height,
              child: VideoPlayer(controller),
            ),
          ),

          // أيقونة تشغيل/إيقاف تظهر عند الإيقاف فقط
          Center(
            child: AnimatedOpacity(
              opacity: controller.value.isPlaying ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),

          // عنوان المشروع فوق تدرج شفاف أسفل الشاشة
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 24, 14, 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
                ),
              ),
              child: Row(
                children: [
                  Icon(widget.projectIcon, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.projectTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
