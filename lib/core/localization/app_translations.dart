/// Portfolio copy, Arabic and English.
class AppTranslations {
  AppTranslations._();

  static const Map<String, Map<String, String>> _values = {
    // ------------------ Nav Bar ------------------
    'nav_name': {'ar': 'يونس الحلاق', 'en': 'Younes Alhallack'},
    'nav_home': {'ar': 'الرئيسية', 'en': 'Home'},
    'nav_projects': {'ar': 'المشاريع', 'en': 'Projects'},
    'nav_contact': {'ar': 'تواصل معي', 'en': 'Contact'},

    // ------------------ Hero Section ------------------
    'hero_greeting': {'ar': 'مرحباً، أنا', 'en': "Hi, I'm"},
    'hero_name': {'ar': 'يونس الحلاق', 'en': 'Younes Alhallack'},
    'hero_role_1': {'ar': 'مطور تطبيقات Flutter', 'en': 'Flutter Developer'},
    // Kept short: the typewriter box is a fixed 36px high.
    'hero_role_2': {
      'ar': 'مطور Full-stack · NestJS',
      'en': 'Full-Stack Developer · NestJS',
    },
    'hero_role_3': {
      'ar': 'خبرة 8 سنوات في المدفوعات',
      'en': '8 Years in Payment Systems',
    },
    'hero_description': {
      'ar':
          'أبني تطبيقات Flutter والسيرفر الذي يقف خلفها بـNode.js وNestJS، '
          'مع قواعد بيانات محلية وسحابية. وخلفي ثماني سنوات في المدفوعات '
          'الإلكترونية، فأعرف ما يعنيه أن يتعامل تطبيقك مع المال.',
      'en':
          'I build Flutter apps and the Node.js and NestJS servers behind '
          'them, with local and cloud databases. Eight years in electronic '
          'payments mean I know what it takes for an app to handle money '
          'properly.',
    },
    'hero_cta_projects': {'ar': 'استعرض مشاريعي', 'en': 'View My Projects'},
    'hero_cta_contact': {'ar': 'تواصل معي', 'en': 'Get In Touch'},
    'hero_years_flutter': {
      'ar': 'سنتان من Flutter',
      'en': '2 Years of Flutter',
    },
    'hero_years_fintech': {
      'ar': '8 سنوات في المدفوعات',
      'en': '8 Years in Payments',
    },

    // ------------------ Projects Section ------------------
    'projects_title': {'ar': 'مشاريعي', 'en': 'My Projects'},
    'projects_subtitle': {
      'ar': 'مشاريع مفتوحة المصدر بنيتها من أول سطر إلى آخر شاشة',
      'en':
          'Open-source projects I built from the first line to the last screen',
    },
    'project_demo_button': {'ar': 'عرض الديمو', 'en': 'View Demo'},

    // ------------------ Interactive Emulator ------------------
    'emulator_title': {'ar': 'معاينة مباشرة', 'en': 'Live Preview'},
    'emulator_close': {'ar': 'إغلاق', 'en': 'Close'},

    // ------------------ General ------------------
    'theme_toggle_tooltip': {
      'ar': 'تبديل الوضع الداكن/الفاتح',
      'en': 'Toggle Dark/Light Mode',
    },
    'lang_toggle_tooltip': {
      'ar': 'Switch to English',
      'en': 'التبديل إلى العربية',
    },

    // ------------------ Project cards ------------------
    // These replace the old generic project_1..3 entries
    // (Digital Payment Gateway / Smart Digital Wallet / QR Payment System),
    // which did not match the real projects shown on the site.
    // Point each card's description at the matching key below.
    'project_rafiq_desc': {
      'ar':
          'مخطط أهداف بالذكاء الاصطناعي: تكتب هدفك فيُعدّ لك خطة بمهام '
          'وأولويات ومواعيد، ويتتبع تقدمك بنسبة مئوية، مع مساعد محادثة.',
      'en':
          'AI goal planner: set a goal and get a plan with tasks, '
          'priorities, and due dates, tracked as a percentage, plus an '
          'assistant chat.',
    },
    'project_bill_desc': {
      'ar':
          'إدارة الدخل والمصاريف بعملات متعددة (ليرة ودولار ويورو) مع '
          'تقارير حسب الفئة، ومقارنة شهرية، ونسخ احتياطي على Google Drive.',
      'en':
          'Income and expense manager in SYP, USD, and EUR, with category '
          'reports, monthly comparison, and Google Drive backup.',
    },
    'project_clearx_desc': {
      'ar':
          'منصة مطابقة وتسوية: ترفع حركاتك وكشف الحساب البنكي، فتطابقها '
          'وتُظهر ما لا يتطابق. React وNestJS.',
      'en':
          "Matching and reconciliation platform: upload your transactions "
          "and a bank statement, and it flags what doesn't match. React, "
          "NestJS.",
    },
    'project_dukan_desc': {
      'ar':
          'تطبيق إدارة لمحل صغير: مخزون وفواتير وتقارير مبيعات وأرباح. '
          'flutter وSQLite',
      'en':
          'Small-shop system: inventory, invoices, and sales and profit '
          'reports.  Flutter , SQLite.',
    },

    // ------------------ Tech Stack Section ------------------
    'techstack_title': {'ar': 'التقنيات المستخدمة', 'en': 'Tech Stack'},
    'techstack_subtitle': {
      'ar': 'الأدوات التي أستخدمها لبناء التطبيق والسيرفر الذي يقف خلفه',
      'en': 'The tools I use to build the app and the server behind it',
    },

    // ------------------ Contact Section ------------------
    'contact_title': {'ar': 'تواصل معي', 'en': 'Get In Touch'},
    'contact_subtitle': {
      'ar':
          'هل لديك مشروع أو فرصة عمل؟ اكتب لي وسأرد في أقرب وقت. '
          'أنا متاح لوظائف عن بُعد بدوام كامل ولمشاريع فريلانس.',
      'en':
          "Have a project or a role in mind? Write to me and I'll reply "
          "soon. I'm open to full-time remote roles and freelance work.",
    },
    'contact_email_label': {'ar': 'البريد الإلكتروني', 'en': 'Email'},
    'contact_linkedin_label': {'ar': 'لينكدإن', 'en': 'LinkedIn'},
    'contact_github_label': {'ar': 'جيت هاب', 'en': 'GitHub'},
    'contact_send_email': {'ar': 'أرسل رسالة', 'en': 'Send a Message'},

    'contact_form_name': {'ar': 'الاسم', 'en': 'Name'},
    'contact_form_email': {'ar': 'بريدك الإلكتروني', 'en': 'Your Email'},
    'contact_form_message': {'ar': 'الرسالة', 'en': 'Message'},
    'contact_form_send': {'ar': 'إرسال الرسالة', 'en': 'Send Message'},
    'contact_form_sending': {'ar': 'جارٍ الإرسال...', 'en': 'Sending...'},
    'contact_form_success': {
      'ar': 'تم إرسال رسالتك بنجاح، شكراً لتواصلك!',
      'en': 'Your message was sent successfully — thanks for reaching out!',
    },
    'contact_form_error': {
      'ar': 'حدث خطأ أثناء الإرسال، حاول مرة أخرى لاحقاً.',
      'en':
          'Something went wrong sending your message. Please try again later.',
    },
    'contact_form_validation': {
      'ar': 'يرجى تعبئة جميع الحقول ببريد إلكتروني ورسالة صحيحين',
      'en': 'Please fill in all fields with a valid email and message',
    },
    'contact_social_title': {
      'ar': 'أو تواصل مباشرة عبر',
      'en': 'Or reach out directly via',
    },

    // ------------------ Footer ------------------
    'footer_rights': {'ar': 'جميع الحقوق محفوظة', 'en': 'All rights reserved'},
    'footer_made_with': {
      'ar': 'صُمم وطُوّر باستخدام Flutter',
      'en': 'Designed & built with Flutter',
    },

    // ------------------ Project Card ------------------
    'project_source_button': {'ar': 'الكود المصدري', 'en': 'Source Code'},

    'nav_about': {'ar': 'نبذة عني', 'en': 'About'},

    'about_title': {'ar': 'نبذة عني', 'en': 'About Me'},
    'about_subtitle': {
      'ar': 'من أنا وماذا أقدّم',
      'en': 'Who I am & what I bring',
    },
    'about_bio': {
      'ar':
          'أنا يونس الحلاق، مطور موبايل Full-stack. قبل Flutter قضيت ثماني '
          'سنوات داخل المدفوعات الإلكترونية: ربط سويتشات وبوابات دفع، '
          'وتسوية يومية، وبنية شبكة دفع وطنية. اليوم أضع هذه الدقة في '
          'تطبيقات منظمة البنية (Clean Architecture وRiverpod) وفي سيرفرات '
          'NestJS وNode.js.\n\n'
          'أشرفت على Q Pay، تطبيق Flutter لطلب الدفع، حتى مرحلة الترخيص، '
          'قبل أن تغلق الشركة قبل الإطلاق.',
      'en':
          "I'm Younes, a full-stack mobile developer. Before Flutter I spent "
          "eight years inside electronic payments: switch and gateway "
          "integration, daily reconciliation, and the infrastructure of a "
          "national payment network. Today I bring that precision to "
          "well-structured apps (Clean Architecture, Riverpod) and to NestJS "
          "and Node.js backends.\n\n"
          "I supervised Q Pay, a Flutter payment-request app, through to "
          "licensing, before the company closed ahead of launch.",
    },

    'about_download_cv': {'ar': 'تحميل السيرة الذاتية', 'en': 'Download CV'},
  };

  static String translate(String key, bool isArabic) {
    final entry = _values[key];
    if (entry == null) return key;
    return entry[isArabic ? 'ar' : 'en'] ?? key;
  }
}
