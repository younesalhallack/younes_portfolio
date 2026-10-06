import 'dart:math';
import 'package:flutter/material.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_colors.dart';

/// خلفية متحركة تعرض شبكة خطوط خافتة وجسيمات متوهجة تطفو ببطء،
/// بلون يتماشى مع لون السمة الأساسي (Primary Color).
class AnimatedParticlesBackground extends StatefulWidget {
  final bool isDark;
  const AnimatedParticlesBackground({super.key, required this.isDark});

  @override
  State<AnimatedParticlesBackground> createState() =>
      _AnimatedParticlesBackgroundState();
}

class _AnimatedParticlesBackgroundState
    extends State<AnimatedParticlesBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();

    final rand = Random(7);
    _particles = List.generate(26, (_) {
      return _Particle(
        x: rand.nextDouble(),
        y: rand.nextDouble(),
        radius: rand.nextDouble() * 2 + 1,
        speed: rand.nextDouble() * 0.35 + 0.08,
        phase: rand.nextDouble() * 2 * pi,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isDark
        ? AppColors.darkPrimary
        : const Color.fromARGB(255, 62, 112, 186);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          size: Size.infinite,
          painter: _ParticlesPainter(
            particles: _particles,
            progress: _controller.value,
            color: color,
            isDark: widget.isDark,
          ),
        );
      },
    );
  }
}

class _Particle {
  final double x, y, radius, speed, phase;
  _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.phase,
  });
}

class _ParticlesPainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Color color;
  final bool isDark;

  _ParticlesPainter({
    required this.particles,
    required this.progress,
    required this.color,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // شبكة خطوط خافتة جداً (Grid)
    final gridPaint = Paint()
      ..color = color.withOpacity(isDark ? 0.05 : 0.035)
      ..strokeWidth = 1;
    const step = 48.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // جسيمات متوهجة تطفو رأسياً مع اهتزاز أفقي بسيط
    for (final p in particles) {
      final dy = (p.y + progress * p.speed) % 1.0;
      final dx = p.x + sin((progress * 2 * pi) + p.phase) * 0.015;
      final offset = Offset(dx * size.width, dy * size.height);

      final glowPaint = Paint()
        ..color = color.withOpacity(0.30)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(offset, p.radius * 2.5, glowPaint);

      final dotPaint = Paint()..color = color.withOpacity(0.75);
      canvas.drawCircle(offset, p.radius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) => true;
}
