import 'package:flutter/material.dart';

enum PortfolioSection { hero, about, projects, contact }

/// ChangeNotifier مسؤول عن حالة شريط التنقل التفاعلية:
/// هل الصفحة مُمرّرة (لتقليص الشريط)، وما هو القسم النشط حالياً (Scroll Spy).
/// حالياً isScrolled/activeSection لا تتغيّر تلقائياً حتى تُربط بـ ScrollController
/// من home_page.dart (المرحلة القادمة) — لكن الشريط جاهز لاستقبال هذه القيم.
class NavBarController extends ChangeNotifier {
  NavBarController._internal();
  static final NavBarController instance = NavBarController._internal();

  bool _isScrolled = false;
  bool get isScrolled => _isScrolled;

  PortfolioSection _activeSection = PortfolioSection.hero;
  PortfolioSection get activeSection => _activeSection;

  void updateScrollOffset(double offset) {
    final scrolled = offset > 24;
    if (scrolled != _isScrolled) {
      _isScrolled = scrolled;
      notifyListeners();
    }
  }

  void setActiveSection(PortfolioSection section) {
    if (_activeSection != section) {
      _activeSection = section;
      notifyListeners();
    }
  }
}
