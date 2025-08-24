/// Utilitaire de gestion des langues pour l'application Khidmeti (Utilisateurs)
class LanguageUtils {
  LanguageUtils._();

  static const String arabic = 'ar';
  static const String french = 'fr';
  static const String english = 'en';
  static const String defaultLanguage = french;

  static String getText(String text, String languageCode) {
    if (languageCode == defaultLanguage) {
      return text;
    }

    final translation = _translations[text];
    if (translation != null && translation.containsKey(languageCode)) {
      return translation[languageCode]!;
    }

    return text;
  }

  static const Map<String, Map<String, String>> _translations = {
    'Khidmeti': {
      'ar': 'خدمتي',
      'en': 'Khidmeti',
    },
    'Bienvenue sur Khidmeti': {
      'ar': 'مرحباً بك في خدمتي',
      'en': 'Welcome to Khidmeti',
    },
    'Trouvez les meilleurs travailleurs pour vos besoins': {
      'ar': 'اعثر على أفضل العمال لاحتياجاتك',
      'en': 'Find the best workers for your needs',
    },
    'Services Populaires': {
      'ar': 'الخدمات الشائعة',
      'en': 'Popular Services',
    },
    'Statistiques du Réseau': {
      'ar': 'إحصائيات الشبكة',
      'en': 'Network Statistics',
    },
    'Actualités & Promotions': {
      'ar': 'الأخبار والعروض',
      'en': 'News & Promotions',
    },
    'Accès Rapide': {
      'ar': 'الوصول السريع',
      'en': 'Quick Access',
    },
    'Travailleurs': {
      'ar': 'عمال',
      'en': 'Workers',
    },
    'Note Moyenne': {
      'ar': 'متوسط التقييم',
      'en': 'Average Rating',
    },
    'Missions': {
      'ar': 'مهام',
      'en': 'Missions',
    },
    'Nouveaux travailleurs certifiés': {
      'ar': 'عمال جدد معتمدون',
      'en': 'New certified workers',
    },
    'Plus de 50 nouveaux travailleurs ont rejoint notre réseau': {
      'ar': 'انضم أكثر من 50 عاملاً جديداً إلى شبكتنا',
      'en': 'More than 50 new workers have joined our network',
    },
    'Promotion spéciale': {
      'ar': 'عرض خاص',
      'en': 'Special offer',
    },
    '-20% sur tous les services de nettoyage ce mois-ci': {
      'ar': '-20% على جميع خدمات التنظيف هذا الشهر',
      'en': '-20% on all cleaning services this month',
    },
    'Voir tout': {
      'ar': 'عرض الكل',
      'en': 'View all',
    },
    'Rechercher': {
      'ar': 'بحث',
      'en': 'Search',
    },
    'Nouvelle Demande': {
      'ar': 'طلب جديد',
      'en': 'New Request',
    },
    'Messages': {
      'ar': 'رسائل',
      'en': 'Messages',
    },
    'Historique': {
      'ar': 'سجل',
      'en': 'History',
    },
    'Plomberie': {
      'ar': 'سباكة',
      'en': 'Plumbing',
    },
    'Électricité': {
      'ar': 'كهرباء',
      'en': 'Electricity',
    },
    'Nettoyage': {
      'ar': 'تنظيف',
      'en': 'Cleaning',
    },
    'Services de plomberie professionnels': {
      'ar': 'خدمات سباكة احترافية',
      'en': 'Professional plumbing services',
    },
    'Installation et réparation électrique': {
      'ar': 'تركيب وإصلاح كهربائي',
      'en': 'Electrical installation and repair',
    },
    'Services de nettoyage professionnels': {
      'ar': 'خدمات تنظيف احترافية',
      'en': 'Professional cleaning services',
    },
  };
}