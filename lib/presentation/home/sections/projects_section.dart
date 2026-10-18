import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:video_player/video_player.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_colors.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_sizes.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_text_styles.dart';
import 'package:younes_alhallack_portfolio/core/utils/url_launcher_helper.dart';

import '../../../core/localization/app_translations.dart';
import '../../../core/state/app_settings.dart';
import '../../shared_widgets/interactive_emulator.dart';

//project data module
class _ProjectData {
  final String titleKey;
  final String descriptionKey;
  final IconData icon;
  final String repoUrl;
  final String demoVideoPath;

  const _ProjectData({
    required this.titleKey,
    required this.descriptionKey,
    required this.icon,
    required this.repoUrl,
    required this.demoVideoPath,
  });
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static const List<_ProjectData> _projects = [
    _ProjectData(
      titleKey: 'Rafiq',
      descriptionKey: 'project_rafiq_desc',
      icon: Icons.task_alt_outlined,
      repoUrl: 'https://github.com/younesalhallack/Rafiq',
      demoVideoPath: 'assets/videos/rafiq.webm',
    ),
    _ProjectData(
      titleKey: 'Clear-X',
      descriptionKey: 'project_clearx_desc',
      icon: Icons.account_balance_wallet_rounded,
      repoUrl: 'https://github.com/younesalhallack/clearx',
      demoVideoPath: 'assets/videos/clear_X.webm',
    ),
    _ProjectData(
      titleKey: 'Bill App',
      descriptionKey: 'project_bill_desc',
      icon: Icons.analytics_outlined,
      repoUrl: 'https://github.com/younesalhallack/bills_app',
      demoVideoPath: 'assets/videos/bill.webm',
    ),
    _ProjectData(
      titleKey: 'Dukan',
      descriptionKey: 'project_dukan_desc',
      icon: Icons.store_outlined,
      repoUrl: 'https://github.com/younesalhallack/dukan_special_app',
      demoVideoPath: 'assets/videos/dukan.webm',
    ),
  ];

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
        final isTablet = screenWidth < AppSizes.breakpointTablet;
        final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                        AppTranslations.translate('projects_title', isArabic),
                        style: AppTextStyles.sectionTitle(isDark),
                      )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.2, end: 0),

                  const SizedBox(height: AppSizes.spacingSm),

                  Text(
                    AppTranslations.translate('projects_subtitle', isArabic),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.sectionSubtitle(isDark),
                  ).animate().fadeIn(duration: 500.ms, delay: 100.ms),

                  const SizedBox(height: AppSizes.spacingLg),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _projects.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: AppSizes.spacingMd,
                      mainAxisSpacing: AppSizes.spacingMd,
                      childAspectRatio: isMobile ? 1.1 : 0.85,
                    ),
                    itemBuilder: (context, index) {
                      final project = _projects[index];
                      return _ProjectCard(
                            project: project,
                            isDark: isDark,
                            isArabic: isArabic,
                          )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: (150 * index).ms)
                          .slideY(begin: 0.15, end: 0);
                    },
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

/// Interactive project card with 3D Tilt effect when mouse over
class _ProjectCard extends StatefulWidget {
  final _ProjectData project;
  final bool isDark;
  final bool isArabic;

  const _ProjectCard({
    required this.project,
    required this.isDark,
    required this.isArabic,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  double _rotateX = 0;
  double _rotateY = 0;
  bool _isHovering = false;

  void _onHover(PointerEvent event, BoxConstraints constraints) {
    final localPos = event.localPosition;
    final centerX = constraints.maxWidth / 2;
    final centerY = constraints.maxHeight / 2;

    // Calculate the rotation angle based on the pointer's distance from the center of the card
    final dx = (localPos.dx - centerX) / centerX; // -1 to 1
    final dy = (localPos.dy - centerY) / centerY; // -1 to 1

    setState(() {
      _rotateY = dx * 0.18; //  max rotate Y
      _rotateX = -dy * 0.18; // max rotate X
    });
  }

  void _onExit() {
    setState(() {
      _rotateX = 0;
      _rotateY = 0;
      _isHovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final isArabic = widget.isArabic;
    final primaryColor = isDark
        ? AppColors.darkPrimary
        : AppColors.lightPrimary;
    final surfaceColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onHover: (event) => _onHover(event, constraints),
          onExit: (_) => _onExit(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015) // Perspective
              ..rotateX(_rotateX)
              ..rotateY(_rotateY)
              ..scale(_isHovering ? 1.03 : 1.0),
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              border: Border.all(
                color: _isHovering
                    ? primaryColor.withOpacity(0.6)
                    : borderColor,
                width: _isHovering ? 1.5 : 1,
              ),
              boxShadow: _isHovering
                  ? [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.25),
                        blurRadius: 24,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            padding: const EdgeInsets.all(AppSizes.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ---------------- Animated Video Preview ----------------
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  child: _ProjectCardVideoPreview(
                    videoPath: widget.project.demoVideoPath,
                    icon: widget.project.icon,
                    isDark: isDark,
                    isHovering: _isHovering,
                  ),
                ),

                const SizedBox(height: AppSizes.spacingMd),

                // ---------------- Title ----------------
                Text(
                  AppTranslations.translate(widget.project.titleKey, isArabic),
                  style: AppTextStyles.cardTitle(isDark),
                ),

                const SizedBox(height: AppSizes.spacingSm),

                // ---------------- Description ----------------
                Expanded(
                  child: Text(
                    AppTranslations.translate(
                      widget.project.descriptionKey,
                      isArabic,
                    ),
                    style: AppTextStyles.cardBody(isDark),
                  ),
                ),

                const SizedBox(height: AppSizes.spacingSm),

                // ---------------- Demo Button ----------------
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          InteractiveEmulator.show(
                            context,
                            projectTitle: AppTranslations.translate(
                              widget.project.titleKey,
                              isArabic,
                            ),
                            projectIcon: widget.project.icon,
                            demoVideoPath: widget.project.demoVideoPath,
                          );
                        },
                        icon: const Icon(
                          Icons.play_circle_outline_rounded,
                          size: 16,
                        ),
                        label: Text(
                          AppTranslations.translate(
                            'project_demo_button',
                            isArabic,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spacingSm),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          UrlLauncherHelper.launchWebUrl(
                            widget.project.repoUrl,
                          );
                        },
                        icon: const Icon(Icons.code_rounded, size: 16),
                        label: Text(
                          AppTranslations.translate(
                            'project_source_button',
                            isArabic,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// demo privew
class _ProjectCardVideoPreview extends StatefulWidget {
  final String videoPath;
  final IconData icon;
  final bool isDark;
  final bool isHovering;

  const _ProjectCardVideoPreview({
    required this.videoPath,
    required this.icon,
    required this.isDark,
    required this.isHovering,
  });

  @override
  State<_ProjectCardVideoPreview> createState() =>
      _ProjectCardVideoPreviewState();
}

class _ProjectCardVideoPreviewState extends State<_ProjectCardVideoPreview> {
  static const _thumbnailPosition = Duration(milliseconds: 400);

  VideoPlayerController? _controller;
  bool _isReady = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    final controller = VideoPlayerController.asset(widget.videoPath);
    _controller = controller;
    controller
        .initialize()
        .then((_) async {
          if (!mounted) return;
          await controller.setLooping(true);
          await controller.setVolume(0);
          await controller.seekTo(_thumbnailPosition);
          setState(() => _isReady = true);
          if (widget.isHovering) {
            controller.play();
          }
        })
        .catchError((_) {
          if (mounted) setState(() => _hasError = true);
        });
  }

  @override
  void didUpdateWidget(covariant _ProjectCardVideoPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    final controller = _controller;
    if (!_isReady || controller == null) return;

    if (widget.isHovering && !oldWidget.isHovering) {
      controller.seekTo(Duration.zero);
      controller.play();
    } else if (!widget.isHovering && oldWidget.isHovering) {
      controller.pause();
      controller.seekTo(_thumbnailPosition);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.isDark
        ? AppColors.darkPrimary
        : AppColors.lightPrimary;

    const previewHeight = 220.0;

    if (_hasError || !_isReady || _controller == null) {
      return Container(
        height: previewHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.primaryGradient(
              widget.isDark,
            ).colors.map((c) => c.withOpacity(0.15)).toList(),
          ),
        ),
        alignment: Alignment.center,
        child: !_hasError
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: primaryColor,
                ),
              )
            : Icon(widget.icon, color: primaryColor, size: 30),
      );
    }

    return SizedBox(
      height: previewHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: _controller!.value.size.width,
              height: _controller!.value.size.height,
              child: VideoPlayer(_controller!),
            ),
          ),
          // مؤشر صغير يوضح أن المعاينة تتحرك عند التحويم (يختفي أثناء التشغيل)
          AnimatedOpacity(
            opacity: widget.isHovering ? 0 : 1,
            duration: const Duration(milliseconds: 200),
            child: Container(
              color: Colors.black.withOpacity(0.15),
              alignment: Alignment.center,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
