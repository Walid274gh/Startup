import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider pour le thème de l'application
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt('theme_mode') ?? 0;
    state = ThemeMode.values[themeModeIndex];
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = themeMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', themeMode.index);
  }

  Future<void> toggleTheme() async {
    if (state == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else if (state == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
    } else {
      // Si c'est system, on passe en light
      await setThemeMode(ThemeMode.light);
    }
  }
}

// Provider pour la langue de l'application
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('fr', 'DZ')) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'fr';
    final countryCode = prefs.getString('country_code') ?? 'DZ';
    state = Locale(languageCode, countryCode);
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    await prefs.setString('country_code', locale.countryCode ?? 'DZ');
  }

  Future<void> setLanguage(String languageCode, {String? countryCode}) async {
    final locale = Locale(languageCode, countryCode);
    await setLocale(locale);
  }
}

// Provider pour les localisations de l'application
final appLocalizationsProvider = Provider<AppLocalizations>((ref) {
  final locale = ref.watch(localeProvider);
  return AppLocalizations(locale);
});

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  String get appTitle {
    switch (locale.languageCode) {
      case 'ar':
        return 'عمال الجزائر';
      case 'en':
        return 'Algerian Workers';
      case 'fr':
      default:
        return 'Algerian Workers';
    }
  }

  String get welcomeMessage {
    switch (locale.languageCode) {
      case 'ar':
        return 'مرحباً بك في عمال الجزائر';
      case 'en':
        return 'Welcome to Algerian Workers';
      case 'fr':
      default:
        return 'Bienvenue sur Algerian Workers';
    }
  }

  String get searchWorkers {
    switch (locale.languageCode) {
      case 'ar':
        return 'البحث عن العمال';
      case 'en':
        return 'Search Workers';
      case 'fr':
      default:
        return 'Rechercher des travailleurs';
    }
  }

  String get createRequest {
    switch (locale.languageCode) {
      case 'ar':
        return 'إنشاء طلب';
      case 'en':
        return 'Create Request';
      case 'fr':
      default:
        return 'Créer une demande';
    }
  }

  String get chat {
    switch (locale.languageCode) {
      case 'ar':
        return 'المحادثة';
      case 'en':
        return 'Chat';
      case 'fr':
      default:
        return 'Chat';
    }
  }

  String get settings {
    switch (locale.languageCode) {
      case 'ar':
        return 'الإعدادات';
      case 'en':
        return 'Settings';
      case 'fr':
      default:
        return 'Paramètres';
    }
  }

  String get profile {
    switch (locale.languageCode) {
      case 'ar':
        return 'الملف الشخصي';
      case 'en':
        return 'Profile';
      case 'fr':
      default:
        return 'Profil';
    }
  }

  String get notifications {
    switch (locale.languageCode) {
      case 'ar':
        return 'الإشعارات';
      case 'en':
        return 'Notifications';
      case 'fr':
      default:
        return 'Notifications';
    }
  }

  String get help {
    switch (locale.languageCode) {
      case 'ar':
        return 'المساعدة';
      case 'en':
        return 'Help';
      case 'fr':
      default:
        return 'Aide';
    }
  }

  String get about {
    switch (locale.languageCode) {
      case 'ar':
        return 'حول';
      case 'en':
        return 'About';
      case 'fr':
      default:
        return 'À propos';
    }
  }

  String get privacy {
    switch (locale.languageCode) {
      case 'ar':
        return 'الخصوصية';
      case 'en':
        return 'Privacy';
      case 'fr':
      default:
        return 'Confidentialité';
    }
  }

  String get terms {
    switch (locale.languageCode) {
      case 'ar':
        return 'الشروط';
      case 'en':
        return 'Terms';
      case 'fr':
      default:
        return 'Conditions';
    }
  }

  String get logout {
    switch (locale.languageCode) {
      case 'ar':
        return 'تسجيل الخروج';
      case 'en':
        return 'Logout';
      case 'fr':
      default:
        return 'Déconnexion';
    }
  }

  String get login {
    switch (locale.languageCode) {
      case 'ar':
        return 'تسجيل الدخول';
      case 'en':
        return 'Login';
      case 'fr':
      default:
        return 'Connexion';
    }
  }

  String get register {
    switch (locale.languageCode) {
      case 'ar':
        return 'التسجيل';
      case 'en':
        return 'Register';
      case 'fr':
      default:
        return 'Inscription';
    }
  }

  String get email {
    switch (locale.languageCode) {
      case 'ar':
        return 'البريد الإلكتروني';
      case 'en':
        return 'Email';
      case 'fr':
      default:
        return 'Email';
    }
  }

  String get password {
    switch (locale.languageCode) {
      case 'ar':
        return 'كلمة المرور';
      case 'en':
        return 'Password';
      case 'fr':
      default:
        return 'Mot de passe';
    }
  }

  String get confirmPassword {
    switch (locale.languageCode) {
      case 'ar':
        return 'تأكيد كلمة المرور';
      case 'en':
        return 'Confirm Password';
      case 'fr':
      default:
        return 'Confirmer le mot de passe';
    }
  }

  String get phoneNumber {
    switch (locale.languageCode) {
      case 'ar':
        return 'رقم الهاتف';
      case 'en':
        return 'Phone Number';
      case 'fr':
      default:
        return 'Numéro de téléphone';
    }
  }

  String get fullName {
    switch (locale.languageCode) {
      case 'ar':
        return 'الاسم الكامل';
      case 'en':
        return 'Full Name';
      case 'fr':
      default:
        return 'Nom complet';
    }
  }

  String get username {
    switch (locale.languageCode) {
      case 'ar':
        return 'اسم المستخدم';
      case 'en':
        return 'Username';
      case 'fr':
      default:
        return 'Nom d\'utilisateur';
    }
  }

  String get address {
    switch (locale.languageCode) {
      case 'ar':
        return 'العنوان';
      case 'en':
        return 'Address';
      case 'fr':
      default:
        return 'Adresse';
    }
  }

  String get city {
    switch (locale.languageCode) {
      case 'ar':
        return 'المدينة';
      case 'en':
        return 'City';
      case 'fr':
      default:
        return 'Ville';
    }
  }

  String get wilaya {
    switch (locale.languageCode) {
      case 'ar':
        return 'الولاية';
      case 'en':
        return 'Province';
      case 'fr':
      default:
        return 'Wilaya';
    }
  }

  String get budget {
    switch (locale.languageCode) {
      case 'ar':
        return 'الميزانية';
      case 'en':
        return 'Budget';
      case 'fr':
      default:
        return 'Budget';
    }
  }

  String get description {
    switch (locale.languageCode) {
      case 'ar':
        return 'الوصف';
      case 'en':
        return 'Description';
      case 'fr':
      default:
        return 'Description';
    }
  }

  String get urgent {
    switch (locale.languageCode) {
      case 'ar':
        return 'عاجل';
      case 'en':
        return 'Urgent';
      case 'fr':
      default:
        return 'Urgent';
    }
  }

  String get normal {
    switch (locale.languageCode) {
      case 'ar':
        return 'عادي';
      case 'en':
        return 'Normal';
      case 'fr':
      default:
        return 'Normal';
    }
  }

  String get low {
    switch (locale.languageCode) {
      case 'ar':
        return 'منخفض';
      case 'en':
        return 'Low';
      case 'fr':
      default:
        return 'Basse';
    }
  }

  String get high {
    switch (locale.languageCode) {
      case 'ar':
        return 'عالي';
      case 'en':
        return 'High';
      case 'fr':
      default:
        return 'Haute';
    }
  }

  String get save {
    switch (locale.languageCode) {
      case 'ar':
        return 'حفظ';
      case 'en':
        return 'Save';
      case 'fr':
      default:
        return 'Sauvegarder';
    }
  }

  String get cancel {
    switch (locale.languageCode) {
      case 'ar':
        return 'إلغاء';
      case 'en':
        return 'Cancel';
      case 'fr':
      default:
        return 'Annuler';
    }
  }

  String get edit {
    switch (locale.languageCode) {
      case 'ar':
        return 'تعديل';
      case 'en':
        return 'Edit';
      case 'fr':
      default:
        return 'Modifier';
    }
  }

  String get delete {
    switch (locale.languageCode) {
      case 'ar':
        return 'حذف';
      case 'en':
        return 'Delete';
      case 'fr':
      default:
        return 'Supprimer';
    }
  }

  String get search {
    switch (locale.languageCode) {
      case 'ar':
        return 'بحث';
      case 'en':
        return 'Search';
      case 'fr':
      default:
        return 'Rechercher';
    }
  }

  String get filter {
    switch (locale.languageCode) {
      case 'ar':
        return 'تصفية';
      case 'en':
        return 'Filter';
      case 'fr':
      default:
        return 'Filtrer';
    }
  }

  String get sort {
    switch (locale.languageCode) {
      case 'ar':
        return 'ترتيب';
      case 'en':
        return 'Sort';
      case 'fr':
      default:
        return 'Trier';
    }
  }

  String get clear {
    switch (locale.languageCode) {
      case 'ar':
        return 'مسح';
      case 'en':
        return 'Clear';
      case 'fr':
      default:
        return 'Effacer';
    }
  }

  String get apply {
    switch (locale.languageCode) {
      case 'ar':
        return 'تطبيق';
      case 'en':
        return 'Apply';
      case 'fr':
      default:
        return 'Appliquer';
    }
  }

  String get reset {
    switch (locale.languageCode) {
      case 'ar':
        return 'إعادة تعيين';
      case 'en':
        return 'Reset';
      case 'fr':
      default:
        return 'Réinitialiser';
    }
  }

  String get loading {
    switch (locale.languageCode) {
      case 'ar':
        return 'جاري التحميل...';
      case 'en':
        return 'Loading...';
      case 'fr':
      default:
        return 'Chargement...';
    }
  }

  String get error {
    switch (locale.languageCode) {
      case 'ar':
        return 'خطأ';
      case 'en':
        return 'Error';
      case 'fr':
      default:
        return 'Erreur';
    }
  }

  String get success {
    switch (locale.languageCode) {
      case 'ar':
        return 'نجح';
      case 'en':
        return 'Success';
      case 'fr':
      default:
        return 'Succès';
    }
  }

  String get warning {
    switch (locale.languageCode) {
      case 'ar':
        return 'تحذير';
      case 'en':
        return 'Warning';
      case 'fr':
      default:
        return 'Avertissement';
    }
  }

  String get info {
    switch (locale.languageCode) {
      case 'ar':
        return 'معلومات';
      case 'en':
        return 'Info';
      case 'fr':
      default:
        return 'Information';
    }
  }

  String get yes {
    switch (locale.languageCode) {
      case 'ar':
        return 'نعم';
      case 'en':
        return 'Yes';
      case 'fr':
      default:
        return 'Oui';
    }
  }

  String get no {
    switch (locale.languageCode) {
      case 'ar':
        return 'لا';
      case 'en':
        return 'No';
      case 'fr':
      default:
        return 'Non';
    }
  }

  String get ok {
    switch (locale.languageCode) {
      case 'ar':
        return 'حسناً';
      case 'en':
        return 'OK';
      case 'fr':
      default:
        return 'OK';
    }
  }

  String get close {
    switch (locale.languageCode) {
      case 'ar':
        return 'إغلاق';
      case 'en':
        return 'Close';
      case 'fr':
      default:
        return 'Fermer';
    }
  }

  String get back {
    switch (locale.languageCode) {
      case 'ar':
        return 'رجوع';
      case 'en':
        return 'Back';
      case 'fr':
      default:
        return 'Retour';
    }
  }

  String get next {
    switch (locale.languageCode) {
      case 'ar':
        return 'التالي';
      case 'en':
        return 'Next';
      case 'fr':
      default:
        return 'Suivant';
    }
  }

  String get previous {
    switch (locale.languageCode) {
      case 'ar':
        return 'السابق';
      case 'en':
        return 'Previous';
      case 'fr':
      default:
        return 'Précédent';
    }
  }

  String get finish {
    switch (locale.languageCode) {
      case 'ar':
        return 'إنهاء';
      case 'en':
        return 'Finish';
      case 'fr':
      default:
        return 'Terminer';
    }
  }

  String get skip {
    switch (locale.languageCode) {
      case 'ar':
        return 'تخطي';
      case 'en':
        return 'Skip';
      case 'fr':
      default:
        return 'Passer';
    }
  }

  String get retry {
    switch (locale.languageCode) {
      case 'ar':
        return 'إعادة المحاولة';
      case 'en':
        return 'Retry';
      case 'fr':
      default:
        return 'Réessayer';
    }
  }

  String get refresh {
    switch (locale.languageCode) {
      case 'ar':
        return 'تحديث';
      case 'en':
        return 'Refresh';
      case 'fr':
      default:
        return 'Actualiser';
    }
  }

  String get sync {
    switch (locale.languageCode) {
      case 'ar':
        return 'مزامنة';
      case 'en':
        return 'Sync';
      case 'fr':
      default:
        return 'Synchroniser';
    }
  }

  String get offline {
    switch (locale.languageCode) {
      case 'ar':
        return 'غير متصل';
      case 'en':
        return 'Offline';
      case 'fr':
      default:
        return 'Hors ligne';
    }
  }

  String get online {
    switch (locale.languageCode) {
      case 'ar':
        return 'متصل';
      case 'en':
        return 'Online';
      case 'fr':
      default:
        return 'En ligne';
    }
  }

  String get connected {
    switch (locale.languageCode) {
      case 'ar':
        return 'متصل';
      case 'en':
        return 'Connected';
      case 'fr':
      default:
        return 'Connecté';
    }
  }

  String get disconnected {
    switch (locale.languageCode) {
      case 'ar':
        return 'غير متصل';
      case 'en':
        return 'Disconnected';
      case 'fr':
      default:
        return 'Déconnecté';
    }
  }

  String get unknown {
    switch (locale.languageCode) {
      case 'ar':
        return 'غير معروف';
      case 'en':
        return 'Unknown';
      case 'fr':
      default:
        return 'Inconnu';
    }
  }

  String get notAvailable {
    switch (locale.languageCode) {
      case 'ar':
        return 'غير متاح';
      case 'en':
        return 'Not Available';
      case 'fr':
      default:
        return 'Non disponible';
    }
  }

  String get available {
    switch (locale.languageCode) {
      case 'ar':
        return 'متاح';
      case 'en':
        return 'Available';
      case 'fr':
      default:
        return 'Disponible';
    }
  }

  String get busy {
    switch (locale.languageCode) {
      case 'ar':
        return 'مشغول';
      case 'en':
        return 'Busy';
      case 'fr':
      default:
        return 'Occupé';
    }
  }

  String get free {
    switch (locale.languageCode) {
      case 'ar':
        return 'حر';
      case 'en':
        return 'Free';
      case 'fr':
      default:
        return 'Libre';
    }
  }

  String get active {
    switch (locale.languageCode) {
      case 'ar':
        return 'نشط';
      case 'en':
        return 'Active';
      case 'fr':
      default:
        return 'Actif';
    }
  }

  String get inactive {
    switch (locale.languageCode) {
      case 'ar':
        return 'غير نشط';
      case 'en':
        return 'Inactive';
      case 'fr':
      default:
        return 'Inactif';
    }
  }

  String get enabled {
    switch (locale.languageCode) {
      case 'ar':
        return 'مفعل';
      case 'en':
        return 'Enabled';
      case 'fr':
      default:
        return 'Activé';
    }
  }

  String get disabled {
    switch (locale.languageCode) {
      case 'ar':
        return 'معطل';
      case 'en':
        return 'Disabled';
      case 'fr':
      default:
        return 'Désactivé';
    }
  }

  String get on {
    switch (locale.languageCode) {
      case 'ar':
        return 'تشغيل';
      case 'en':
        return 'On';
      case 'fr':
      default:
        return 'Activé';
    }
  }

  String get off {
    switch (locale.languageCode) {
      case 'ar':
        return 'إيقاف';
      case 'en':
        return 'Off';
      case 'fr':
      default:
        return 'Désactivé';
    }
  }

  String get show {
    switch (locale.languageCode) {
      case 'ar':
        return 'إظهار';
      case 'en':
        return 'Show';
      case 'fr':
      default:
        return 'Afficher';
    }
  }

  String get hide {
    switch (locale.languageCode) {
      case 'ar':
        return 'إخفاء';
      case 'en':
        return 'Hide';
      case 'fr':
      default:
        return 'Masquer';
    }
  }

  String get expand {
    switch (locale.languageCode) {
      case 'ar':
        return 'توسيع';
      case 'en':
        return 'Expand';
      case 'fr':
      default:
        return 'Développer';
    }
  }

  String get collapse {
    switch (locale.languageCode) {
      case 'ar':
        return 'طي';
      case 'en':
        return 'Collapse';
      case 'fr':
      default:
        return 'Réduire';
    }
  }

  String get more {
    switch (locale.languageCode) {
      case 'ar':
        return 'المزيد';
      case 'en':
        return 'More';
      case 'fr':
      default:
        return 'Plus';
    }
  }

  String get less {
    switch (locale.languageCode) {
      case 'ar':
        return 'أقل';
      case 'en':
        return 'Less';
      case 'fr':
      default:
        return 'Moins';
    }
  }

  String get all {
    switch (locale.languageCode) {
      case 'ar':
        return 'الكل';
      case 'en':
        return 'All';
      case 'fr':
      default:
        return 'Tout';
    }
  }

  String get none {
    switch (locale.languageCode) {
      case 'ar':
        return 'لا شيء';
      case 'en':
        return 'None';
      case 'fr':
      default:
        return 'Aucun';
    }
  }

  String get custom {
    switch (locale.languageCode) {
      case 'ar':
        return 'مخصص';
      case 'en':
        return 'Custom';
      case 'fr':
      default:
        return 'Personnalisé';
    }
  }

  String get default_ {
    switch (locale.languageCode) {
      case 'ar':
        return 'افتراضي';
      case 'en':
        return 'Default';
      case 'fr':
      default:
        return 'Par défaut';
    }
  }

  String get automatic {
    switch (locale.languageCode) {
      case 'ar':
        return 'تلقائي';
      case 'en':
        return 'Automatic';
      case 'fr':
      default:
        return 'Automatique';
    }
  }

  String get manual {
    switch (locale.languageCode) {
      case 'ar':
        return 'يدوي';
      case 'en':
        return 'Manual';
      case 'fr':
      default:
        return 'Manuel';
    }
  }

  String get auto {
    switch (locale.languageCode) {
      case 'ar':
        return 'تلقائي';
      case 'en':
        return 'Auto';
      case 'fr':
      default:
        return 'Auto';
    }
  }

  String get light {
    switch (locale.languageCode) {
      case 'ar':
        return 'فاتح';
      case 'en':
        return 'Light';
      case 'fr':
      default:
        return 'Clair';
    }
  }

  String get dark {
    switch (locale.languageCode) {
      case 'ar':
        return 'داكن';
      case 'en':
        return 'Dark';
      case 'fr':
      default:
        return 'Sombre';
    }
  }

  String get system {
    switch (locale.languageCode) {
      case 'ar':
        return 'النظام';
      case 'en':
        return 'System';
      case 'fr':
      default:
        return 'Système';
    }
  }
}

// Provider pour les préférences de l'application
final preferencesProvider = Provider<PreferencesService>((ref) {
  return PreferencesService();
});

class PreferencesService {
  static const String _themeModeKey = 'theme_mode';
  static const String _languageKey = 'language';
  static const String _notificationsKey = 'notifications';
  static const String _locationPermissionKey = 'location_permission';
  static const String _searchRadiusKey = 'search_radius';

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, themeMode.index);
  }

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeModeKey) ?? 0;
    return ThemeMode.values[index];
  }

  Future<void> setLanguage(String languageCode, {String? countryCode}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
    if (countryCode != null) {
      await prefs.setString('${_languageKey}_country', countryCode);
    }
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'fr';
  }

  Future<String?> getCountryCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('${_languageKey}_country');
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, enabled);
  }

  Future<bool> getNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsKey) ?? true;
  }

  Future<void> setLocationPermission(bool granted) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_locationPermissionKey, granted);
  }

  Future<bool> getLocationPermission() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_locationPermissionKey) ?? false;
  }

  Future<void> setSearchRadius(double radius) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_searchRadiusKey, radius);
  }

  Future<double> getSearchRadius() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_searchRadiusKey) ?? 50.0;
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

// Provider pour la gestion des erreurs
final errorProvider = StateNotifierProvider<ErrorNotifier, String?>((ref) {
  return ErrorNotifier();
});

class ErrorNotifier extends StateNotifier<String?> {
  ErrorNotifier() : super(null);

  void setError(String error) {
    state = error;
  }

  void clearError() {
    state = null;
  }

  bool get hasError => state != null;
}

// Provider pour la gestion du chargement
final loadingProvider = StateNotifierProvider<LoadingNotifier, bool>((ref) {
  return LoadingNotifier();
});

class LoadingNotifier extends StateNotifier<bool> {
  LoadingNotifier() : super(false);

  void setLoading(bool loading) {
    state = loading;
  }

  void startLoading() {
    state = true;
  }

  void stopLoading() {
    state = false;
  }

  bool get isLoading => state;
}

// Provider pour la gestion des messages de succès
final successProvider = StateNotifierProvider<SuccessNotifier, String?>((ref) {
  return SuccessNotifier();
});

class SuccessNotifier extends StateNotifier<String?> {
  SuccessNotifier() : super(null);

  void setSuccess(String message) {
    state = message;
  }

  void clearSuccess() {
    state = null;
  }

  bool get hasSuccess => state != null;
}

// Provider pour la gestion des confirmations
final confirmationProvider = StateNotifierProvider<ConfirmationNotifier, ConfirmationData?>((ref) {
  return ConfirmationNotifier();
});

class ConfirmationData {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  ConfirmationData({
    required this.title,
    required this.message,
    this.confirmText = 'OK',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
  });
}

class ConfirmationNotifier extends StateNotifier<ConfirmationData?> {
  ConfirmationNotifier() : super(null);

  void showConfirmation(ConfirmationData data) {
    state = data;
  }

  void hideConfirmation() {
    state = null;
  }

  bool get hasConfirmation => state != null;
}

// Provider pour la gestion de la navigation
final navigationProvider = StateNotifierProvider<NavigationNotifier, int>((ref) {
  return NavigationNotifier();
});

class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }

  int get currentIndex => state;
}

// Provider pour la gestion de l'état de l'application
final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});

class AppState {
  final bool isInitialized;
  final bool isAuthenticated;
  final bool isOnline;
  final String? currentUserId;
  final Map<String, dynamic>? currentUser;

  AppState({
    this.isInitialized = false,
    this.isAuthenticated = false,
    this.isOnline = true,
    this.currentUserId,
    this.currentUser,
  });

  AppState copyWith({
    bool? isInitialized,
    bool? isAuthenticated,
    bool? isOnline,
    String? currentUserId,
    Map<String, dynamic>? currentUser,
  }) {
    return AppState(
      isInitialized: isInitialized ?? this.isInitialized,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isOnline: isOnline ?? this.isOnline,
      currentUserId: currentUserId ?? this.currentUserId,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());

  void setInitialized(bool initialized) {
    state = state.copyWith(isInitialized: initialized);
  }

  void setAuthenticated(bool authenticated) {
    state = state.copyWith(isAuthenticated: authenticated);
  }

  void setOnline(bool online) {
    state = state.copyWith(isOnline: online);
  }

  void setCurrentUser(String? userId, Map<String, dynamic>? user) {
    state = state.copyWith(
      currentUserId: userId,
      currentUser: user,
    );
  }

  void clearCurrentUser() {
    state = state.copyWith(
      currentUserId: null,
      currentUser: null,
    );
  }

  void logout() {
    state = state.copyWith(
      isAuthenticated: false,
      currentUserId: null,
      currentUser: null,
    );
  }
}