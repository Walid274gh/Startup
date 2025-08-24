import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'core/database/firebase_config.dart';
import 'core/providers/app_providers.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configuration Firebase
  await Firebase.initializeApp();
  
  // Configuration des crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  
  // Configuration des erreurs asynchrones
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  
  // Configuration de l'analytics
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  
  // Configuration Firebase personnalisée
  await FirebaseConfig.initialize();
  
  runApp(
    ProviderScope(
      child: AlgerianWorkersUserApp(),
    ),
  );
}

class AlgerianWorkersUserApp extends ConsumerWidget {
  AlgerianWorkersUserApp({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ref.watch(themeModeProvider),
          routerConfig: _router.config,
          locale: ref.watch(localeProvider),
          supportedLocales: AppConstants.supportedLocales,
          localizationsDelegates: AppConstants.localizationsDelegates,
          builder: (context, child) {
            // Configuration de l'orientation
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            
            // Configuration de la barre de statut
            SystemChrome.setSystemUIOverlayStyle(
              const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
            );
            
            return child!;
          },
          onGenerateTitle: (context) {
            return ref.watch(appLocalizationsProvider).appTitle;
          },
        );
      },
    );
  }
}

// Configuration des constantes de l'application
class AppConstants {
  static const String appName = 'Algerian Workers';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  
  // Métiers supportés
  static const List<String> supportedProfessions = [
    'Plomberie',
    'Électricité',
    'Nettoyage',
    'Livraison',
    'Peinture',
    'Réparation électroménager',
    'Maçonnerie',
    'Climatisation',
    'Cours particuliers',
  ];
  
  // Wilayas (provinces) d'Algérie
  static const List<String> algerianWilayas = [
    'Adrar', 'Chlef', 'Laghouat', 'Oum El Bouaghi', 'Batna',
    'Béjaïa', 'Biskra', 'Béchar', 'Blida', 'Bouira',
    'Tamanrasset', 'Tébessa', 'Tlemcen', 'Tiaret', 'Tizi Ouzou',
    'Alger', 'Djelfa', 'Jijel', 'Sétif', 'Saïda',
    'Skikda', 'Sidi Bel Abbès', 'Annaba', 'Guelma', 'Constantine',
    'Médéa', 'Mostaganem', "M'Sila", 'Mascara', 'Ouargla',
    'Oran', 'El Bayadh', 'Illizi', 'Bordj Bou Arréridj', 'Boumerdès',
    'El Tarf', 'Tindouf', 'Tissemsilt', 'El Oued', 'Khenchela',
    'Souk Ahras', 'Tipaza', 'Mila', 'Aïn Defla', 'Naâma',
    'Aïn Témouchent', 'Ghardaïa', 'Relizane', 'Timimoun', 'Bordj Badji Mokhtar',
    'Ouled Djellal', 'Béni Abbès', 'In Salah', 'In Guezzam', 'Touggourt',
    'Djanet', "El M'Ghair", 'El Meniaa',
  ];
  
  // Configuration des langues
  static const List<Locale> supportedLocales = [
    Locale('fr', 'DZ'), // Français Algérie
    Locale('ar', 'DZ'), // Arabe Algérie
    Locale('en', 'US'), // Anglais
  ];
  
  // Configuration des localisations
  static const localizationsDelegates = [
    // Ajouter les delegates de localisation ici
  ];
  
  // Configuration des couleurs de l'application
  static const Color primaryColor = Color(0xFFE02F75);
  static const Color secondaryColor = Color(0xFF6700A3);
  static const Color accentColor = Color(0xFFFF5A57);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFDC3545);
  static const Color successColor = Color(0xFF28A745);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color infoColor = Color(0xFF17A2B8);
  
  // Configuration des dimensions
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
  static const double defaultRadius = 12.0;
  static const double defaultElevation = 4.0;
  
  // Configuration des animations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);
  
  // Configuration des timeouts
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration shortTimeout = Duration(seconds: 10);
  static const Duration longTimeout = Duration(seconds: 60);
  
  // Configuration des limites
  static const int maxImageSize = 10 * 1024 * 1024; // 10 MB
  static const int maxVideoSize = 100 * 1024 * 1024; // 100 MB
  static const int maxMessageLength = 1000;
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 2000;
  
  // Configuration des distances
  static const double defaultSearchRadius = 50.0; // km
  static const double maxSearchRadius = 200.0; // km
  static const double minSearchRadius = 1.0; // km
  
  // Configuration des prix
  static const double minBudget = 100.0; // DA
  static const double maxBudget = 100000.0; // DA
  static const String defaultCurrency = 'DA';
  
  // Configuration des notifications
  static const String defaultNotificationChannel = 'algerian_workers';
  static const String defaultNotificationChannelName = 'Algerian Workers';
  static const String defaultNotificationChannelDescription = 'Notifications de la plateforme Algerian Workers';
  
  // Configuration des URLs
  static const String privacyPolicyUrl = 'https://algerianworkers.com/privacy';
  static const String termsOfServiceUrl = 'https://algerianworkers.com/terms';
  static const String supportUrl = 'https://algerianworkers.com/support';
  static const String websiteUrl = 'https://algerianworkers.com';
  
  // Configuration des emails
  static const String supportEmail = 'support@algerianworkers.com';
  static const String businessEmail = 'business@algerianworkers.com';
  static const String legalEmail = 'legal@algerianworkers.com';
  
  // Configuration des numéros de téléphone
  static const String supportPhone = '+213 123 456 789';
  static const String emergencyPhone = '+213 123 456 789';
  
  // Configuration des réseaux sociaux
  static const String facebookUrl = 'https://facebook.com/algerianworkers';
  static const String twitterUrl = 'https://twitter.com/algerianworkers';
  static const String instagramUrl = 'https://instagram.com/algerianworkers';
  static const String linkedinUrl = 'https://linkedin.com/company/algerianworkers';
  static const String youtubeUrl = 'https://youtube.com/algerianworkers';
  
  // Configuration des API
  static const String apiBaseUrl = 'https://api.algerianworkers.com';
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Configuration des cache
  static const Duration defaultCacheDuration = Duration(hours: 1);
  static const Duration longCacheDuration = Duration(days: 1);
  static const Duration shortCacheDuration = Duration(minutes: 15);
  
  // Configuration des logs
  static const bool enableLogs = true;
  static const bool enableCrashlytics = true;
  static const bool enableAnalytics = true;
  static const bool enablePerformanceMonitoring = true;
}