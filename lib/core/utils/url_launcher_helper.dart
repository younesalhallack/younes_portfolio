import 'package:url_launcher/url_launcher.dart';

/// دالة مساعدة موحّدة لفتح الروابط الخارجية (مواقع، بريد إلكتروني)
/// وملفات الـ Assets المحلية (مثل السيرة الذاتية PDF) بأمان.
class UrlLauncherHelper {
  UrlLauncherHelper._();

  static Future<void> launchWebUrl(String rawUrl) async {
    final normalized = rawUrl.startsWith('http') ? rawUrl : 'https://$rawUrl';
    final uri = Uri.parse(normalized);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      // فشل الفتح (مثلاً رابط غير مدعوم) — يُهمل بصمت حالياً
    }
  }

  static Future<void> launchEmail(String email, {String subject = ''}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: subject.isNotEmpty ? {'subject': subject} : null,
    );
    try {
      await launchUrl(uri);
    } catch (_) {}
  }

  /// يفتح ملفاً محلياً معرّفاً في pubspec.yaml (مثل PDF السيرة الذاتية).
  /// على Flutter Web، أي أصل (asset) يُخدَّم تلقائياً عبر رابط نسبي
  /// بصيغة "assets/<المسار كما هو في pubspec.yaml>"، فيفتحه المتصفح
  /// في تبويب جديد (ويمنح المستخدم خيار التحميل من هناك).
  /// [assetPath] مثال: 'cv/resume.pdf' (بدون بادئة "assets/").
  static Future<void> launchAssetFile(String assetPath) async {
    final webPath = 'assets/assets/$assetPath';
    final uri = Uri.parse(webPath);
    try {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } catch (_) {}
  }
}
