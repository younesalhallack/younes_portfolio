import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:younes_alhallack_portfolio/core/constant/app_colors.dart';
import 'package:younes_alhallack_portfolio/presentation/home/sections/about_section.dart';
import 'package:younes_alhallack_portfolio/presentation/home/sections/app_footer.dart';
import 'package:younes_alhallack_portfolio/presentation/home/sections/contact_section.dart';
import 'package:younes_alhallack_portfolio/presentation/home/sections/hero_section.dart';
import 'package:younes_alhallack_portfolio/presentation/home/sections/projects_section.dart';
import 'package:younes_alhallack_portfolio/presentation/home/sections/tech_stack_section.dart';
import '../../core/state/app_settings.dart';
import '../../core/state/nav_controller.dart';
import '../shared_widgets/animated_particles_background.dart';
import '../shared_widgets/custom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // مفاتيح لكل قسم رئيسي (تُستخدم لتحديد موضعه على الشاشة ولتمرير التمرير إليه)
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // موقع المؤشر الحالي لتأثير التوهج المتتبّع (Cursor Glow)، على مستوى
  // الصفحة كاملة — null تعني المؤشر خارج النافذة أو جهاز لمسي بلا مؤشر.
  Offset? _cursorPosition;

  void _onMouseMove(PointerEvent event) {
    setState(() => _cursorPosition = event.localPosition);
  }

  void _onMouseExit() {
    setState(() => _cursorPosition = null);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // 1) تحديث حالة "تم التمرير" (يُستخدم لتقليص/تعتيم شريط التنقل)
    NavBarController.instance.updateScrollOffset(_scrollController.offset);

    // 2) تحديد القسم النشط حالياً بناءً على موضع كل قسم من أعلى الشاشة
    const activationThreshold = 140.0; // تقريباً ارتفاع شريط التنقل + هامش
    final sections = <PortfolioSection, GlobalKey>{
      PortfolioSection.contact: _contactKey,
      PortfolioSection.projects: _projectsKey,
      PortfolioSection.about: _aboutKey,
      PortfolioSection.hero: _heroKey,
    };

    for (final entry in sections.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;
      final renderObject = ctx.findRenderObject();
      if (renderObject is! RenderBox) continue;
      final position = renderObject.localToGlobal(Offset.zero).dy;
      if (position <= activationThreshold) {
        NavBarController.instance.setActiveSection(entry.key);
        break;
      }
    }
  }

  void _scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, _) {
        final isDark = AppSettings.instance.isDarkMode;
        final primaryColor = isDark
            ? AppColors.darkPrimary
            : AppColors.lightPrimary;

        return Scaffold(
          backgroundColor: isDark
              ? AppColors.darkBackground
              : AppColors.lightBackground,
          appBar: CustomNavBar(
            onHomeTap: () => _scrollToKey(_heroKey),
            onAboutTap: () => _scrollToKey(_aboutKey),
            onProjectsTap: () => _scrollToKey(_projectsKey),
            onContactTap: () => _scrollToKey(_contactKey),
          ),
          body: MouseRegion(
            onHover: _onMouseMove,
            onExit: (_) => _onMouseExit(),
            child: Stack(
              children: [
                // ================= Fixed Background Layer =================
                // توضع خارج CustomScrollView عمداً، لذا لا تتحرك مع التمرير
                // وتبقى ثابتة خلف كل الأقسام طوال الصفحة.

                // ---------------- Background Image (Ken Burns) ----------------
                Positioned.fill(
                  child:
                      Image.asset(
                            'assets/images/background.jpg',
                            fit: BoxFit.cover,
                          )
                          .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: true),
                          )
                          .scale(
                            begin: const Offset(1.0, 1.0),
                            end: const Offset(1.06, 1.06),
                            duration: 18.seconds,
                            curve: Curves.easeInOut,
                          ),
                ),

                // ---------------- Gradient Overlay (لوضوح النص في كل الأقسام) ----------------
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          (isDark
                                  ? AppColors.darkBackground
                                  : AppColors.lightBackground)
                              .withOpacity(0.82),
                          (isDark
                                  ? AppColors.darkBackground
                                  : AppColors.lightBackground)
                              .withOpacity(0.94),
                        ],
                      ),
                    ),
                  ),
                ),

                // ---------------- Animated Particles ----------------
                Positioned.fill(
                  child: ClipRect(
                    child: AnimatedParticlesBackground(isDark: isDark),
                  ),
                ),

                // ---------------- Cursor-following Glow (كل الأقسام) ----------------
                if (_cursorPosition != null)
                  Positioned(
                    left: _cursorPosition!.dx - 180,
                    top: _cursorPosition!.dy - 180,
                    child: IgnorePointer(
                      child: Container(
                        width: 360,
                        height: 360,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              primaryColor.withOpacity(0.16),
                              primaryColor.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                // ================= Scrollable Foreground Content =================
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: KeyedSubtree(
                        key: _heroKey,
                        child: HeroSection(
                          onProjectsTap: () => _scrollToKey(_projectsKey),
                          onContactTap: () => _scrollToKey(_contactKey),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: KeyedSubtree(
                        key: _aboutKey,
                        child: const AboutSection(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: KeyedSubtree(
                        key: _projectsKey,
                        child: const ProjectsSection(),
                      ),
                    ),
                    const SliverToBoxAdapter(child: TechStackSection()),
                    SliverToBoxAdapter(
                      child: KeyedSubtree(
                        key: _contactKey,
                        child: const ContactSection(),
                      ),
                    ),
                    const SliverToBoxAdapter(child: AppFooter()),
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
