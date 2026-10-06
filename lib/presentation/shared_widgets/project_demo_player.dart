import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_colors.dart';

/// مشغّل فيديو مصغّر لعرض ديمو المشروع داخل إطار المحاكي (InteractiveEmulator).
/// يعمل تلقائياً (Autoplay + Loop + Muted) كعرض ديمو سريع بدون تحكم المستخدم اليدوي بالضرورة،
/// لكن يوفر زر تشغيل/إيقاف بسيط عند الحاجة.
class ProjectDemoPlayer extends StatefulWidget {
  final String videoAssetPath;
  final bool isDark;

  const ProjectDemoPlayer({
    super.key,
    required this.videoAssetPath,
    required this.isDark,
  });

  @override
  State<ProjectDemoPlayer> createState() => _ProjectDemoPlayerState();
}

class _ProjectDemoPlayerState extends State<ProjectDemoPlayer> {
  late VideoPlayerController _controller;
  bool _isReady = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoAssetPath)
      ..initialize()
          .then((_) {
            if (!mounted) return;
            setState(() => _isReady = true);
            _controller
              ..setLooping(true)
              ..setVolume(
                0,
              ) // كتم الصوت افتراضياً (سلوك متعارف عليه لديمو تلقائي)
              ..play();
          })
          .catchError((_) {
            if (mounted) setState(() => _hasError = true);
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.isDark
        ? AppColors.darkPrimary
        : AppColors.lightPrimary;

    if (_hasError) {
      return Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: Icon(Icons.error_outline_rounded, color: primaryColor, size: 32),
      );
    }

    if (!_isReady) {
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

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),
          // أيقونة تشغيل/إيقاف تظهر بشفافية عند الإيقاف فقط
          AnimatedOpacity(
            opacity: _controller.value.isPlaying ? 0 : 1,
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
        ],
      ),
    );
  }
}
