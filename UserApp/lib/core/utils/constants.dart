import 'package:flutter/material.dart';

// Constantes de l'application
class AppConstants {
  // Informations de base
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

// Constantes pour les routes
class AppRoutes {
  static const String splash = '/';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String search = '/search';
  static const String request = '/request';
  static const String chat = '/chat';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String workerDetails = '/worker-details';
  static const String requestDetails = '/request-details';
  static const String chatRoom = '/chat-room';
  static const String notifications = '/notifications';
  static const String help = '/help';
  static const String about = '/about';
  static const String privacy = '/privacy';
  static const String terms = '/terms';
}

// Constantes pour les animations
class AppAnimations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);
  
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.bounceOut;
  static const Curve elasticCurve = Curves.elasticOut;
  static const Curve fastCurve = Curves.fastOutSlowIn;
}

// Constantes pour les dimensions
class AppDimensions {
  // Padding et marges
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;
  
  // Rayons de bordure
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusXXL = 32.0;
  
  // Élévations
  static const double elevationXS = 1.0;
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 16.0;
  
  // Tailles d'icônes
  static const double iconSizeXS = 16.0;
  static const double iconSizeS = 20.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 48.0;
  
  // Tailles de texte
  static const double textSizeXS = 10.0;
  static const double textSizeS = 12.0;
  static const double textSizeM = 14.0;
  static const double textSizeL = 16.0;
  static const double textSizeXL = 18.0;
  static const double textSizeXXL = 20.0;
  static const double textSizeXXXL = 24.0;
  static const double textSizeDisplay = 32.0;
}

// Constantes pour les métiers
class ProfessionConstants {
  static const Map<String, String> professionIcons = {
    'Plomberie': 'assets/icons/plomberie.svg',
    'Électricité': 'assets/icons/electricite.svg',
    'Nettoyage': 'assets/icons/nettoyage.svg',
    'Livraison': 'assets/icons/livraison.svg',
    'Peinture': 'assets/icons/peinture.svg',
    'Réparation électroménager': 'assets/icons/electromenager.svg',
    'Maçonnerie': 'assets/icons/maconnerie.svg',
    'Climatisation': 'assets/icons/climatisation.svg',
    'Cours particuliers': 'assets/icons/cours.svg',
  };
  
  static const Map<String, List<String>> professionSkills = {
    'Plomberie': [
      'Installation sanitaires',
      'Réparation fuites',
      'Débouchage canalisations',
      'Installation chauffe-eau',
      'Maintenance systèmes',
    ],
    'Électricité': [
      'Installation électrique',
      'Dépannage panne',
      'Mise aux normes',
      'Installation éclairage',
      'Maintenance tableaux',
    ],
    'Nettoyage': [
      'Nettoyage domicile',
      'Nettoyage bureau',
      'Nettoyage après travaux',
      'Désinfection',
      'Entretien régulier',
    ],
    'Livraison': [
      'Livraison colis',
      'Livraison courses',
      'Livraison documents',
      'Livraison express',
      'Livraison spécialisée',
    ],
    'Peinture': [
      'Peinture intérieure',
      'Peinture extérieure',
      'Peinture décorative',
      'Préparation surfaces',
      'Finition professionnelle',
    ],
    'Réparation électroménager': [
      'Réparation réfrigérateur',
      'Réparation machine à laver',
      'Réparation four',
      'Réparation lave-vaisselle',
      'Maintenance préventive',
    ],
    'Maçonnerie': [
      'Construction murs',
      'Réparation fissures',
      'Installation portes/fenêtres',
      'Rénovation façade',
      'Travaux terrassement',
    ],
    'Climatisation': [
      'Installation climatiseur',
      'Maintenance système',
      'Réparation panne',
      'Nettoyage filtres',
      'Régulation température',
    ],
    'Cours particuliers': [
      'Mathématiques',
      'Physique-Chimie',
      'Français',
      'Anglais',
      'Arabe',
      'Histoire-Géographie',
      'Sciences',
    ],
  };
  
  static const Map<String, double> professionAverageRates = {
    'Plomberie': 1500.0,
    'Électricité': 1800.0,
    'Nettoyage': 800.0,
    'Livraison': 500.0,
    'Peinture': 1200.0,
    'Réparation électroménager': 2000.0,
    'Maçonnerie': 2500.0,
    'Climatisation': 3000.0,
    'Cours particuliers': 1000.0,
  };
}

// Constantes pour les statuts
class StatusConstants {
  static const Map<String, String> requestStatusLabels = {
    'pending': 'En attente',
    'accepted': 'Acceptée',
    'inProgress': 'En cours',
    'completed': 'Terminée',
    'cancelled': 'Annulée',
    'disputed': 'En litige',
  };
  
  static const Map<String, Color> requestStatusColors = {
    'pending': Colors.orange,
    'accepted': Colors.blue,
    'inProgress': Colors.purple,
    'completed': Colors.green,
    'cancelled': Colors.red,
    'disputed': Colors.red,
  };
  
  static const Map<String, String> priorityLabels = {
    'low': 'Basse',
    'normal': 'Normale',
    'high': 'Haute',
    'urgent': 'Urgente',
  };
  
  static const Map<String, Color> priorityColors = {
    'low': Colors.green,
    'normal': Colors.blue,
    'high': Colors.orange,
    'urgent': Colors.red,
  };
}

// Constantes pour les messages
class MessageConstants {
  static const String errorGeneric = 'Une erreur est survenue. Veuillez réessayer.';
  static const String errorNetwork = 'Erreur de connexion. Vérifiez votre connexion internet.';
  static const String errorTimeout = 'Délai d\'attente dépassé. Veuillez réessayer.';
  static const String errorUnauthorized = 'Accès non autorisé. Veuillez vous connecter.';
  static const String errorNotFound = 'Ressource non trouvée.';
  static const String errorServer = 'Erreur du serveur. Veuillez réessayer plus tard.';
  
  static const String successSaved = 'Données sauvegardées avec succès.';
  static const String successDeleted = 'Élément supprimé avec succès.';
  static const String successUpdated = 'Données mises à jour avec succès.';
  static const String successSent = 'Message envoyé avec succès.';
  
  static const String confirmDelete = 'Êtes-vous sûr de vouloir supprimer cet élément ?';
  static const String confirmCancel = 'Êtes-vous sûr de vouloir annuler cette action ?';
  static const String confirmLogout = 'Êtes-vous sûr de vouloir vous déconnecter ?';
  
  static const String loading = 'Chargement en cours...';
  static const String saving = 'Sauvegarde en cours...';
  static const String processing = 'Traitement en cours...';
  static const String searching = 'Recherche en cours...';
}

// Constantes pour les validations
class ValidationConstants {
  static const String required = 'Ce champ est obligatoire.';
  static const String invalidEmail = 'Adresse email invalide.';
  static const String invalidPhone = 'Numéro de téléphone invalide.';
  static const String invalidPassword = 'Le mot de passe doit contenir au moins 8 caractères.';
  static const String passwordMismatch = 'Les mots de passe ne correspondent pas.';
  static const String invalidName = 'Le nom doit contenir au moins 2 caractères.';
  static const String invalidAddress = 'L\'adresse doit contenir au moins 10 caractères.';
  static const String invalidBudget = 'Le budget doit être supérieur à 100 DA.';
  static const String invalidDescription = 'La description doit contenir au moins 20 caractères.';
  
  static const int minPasswordLength = 8;
  static const int minNameLength = 2;
  static const int minAddressLength = 10;
  static const int minDescriptionLength = 20;
  static const int maxDescriptionLength = 2000;
  static const double minBudget = 100.0;
  static const double maxBudget = 100000.0;
}

// Constantes pour les préférences
class PreferenceConstants {
  static const String themeMode = 'theme_mode';
  static const String language = 'language';
  static const String notifications = 'notifications';
  static const String locationPermission = 'location_permission';
  static const String searchRadius = 'search_radius';
  static const String favoriteWorkers = 'favorite_workers';
  static const String recentSearches = 'recent_searches';
  static const String userProfile = 'user_profile';
  static const String appSettings = 'app_settings';
  static const String privacySettings = 'privacy_settings';
  static const String paymentMethods = 'payment_methods';
  static const String chatSettings = 'chat_settings';
  static const String mapSettings = 'map_settings';
}

// Constantes pour les notifications
class NotificationConstants {
  static const String channelId = 'algerian_workers';
  static const String channelName = 'Algerian Workers';
  static const String channelDescription = 'Notifications de la plateforme Algerian Workers';
  
  static const String newRequest = 'Nouvelle demande de service';
  static const String requestAccepted = 'Demande acceptée';
  static const String requestCompleted = 'Demande terminée';
  static const String newMessage = 'Nouveau message';
  static const String paymentReceived = 'Paiement reçu';
  static const String workerAvailable = 'Travailleur disponible';
  static const String reminder = 'Rappel';
  static const String system = 'Notification système';
}

// Constantes pour les erreurs Firebase
class FirebaseErrorConstants {
  static const String userNotFound = 'user-not-found';
  static const String wrongPassword = 'wrong-password';
  static const String emailAlreadyInUse = 'email-already-in-use';
  static const String weakPassword = 'weak-password';
  static const String invalidEmail = 'invalid-email';
  static const String operationNotAllowed = 'operation-not-allowed';
  static const String tooManyRequests = 'too-many-requests';
  static const String networkRequestFailed = 'network-request-failed';
  static const String requiresRecentLogin = 'requires-recent-login';
  static const String userDisabled = 'user-disabled';
  static const String invalidCredential = 'invalid-credential';
  static const String accountExistsWithDifferentCredential = 'account-exists-with-different-credential';
  static const String invalidVerificationCode = 'invalid-verification-code';
  static const String invalidVerificationId = 'invalid-verification-id';
  static const String quotaExceeded = 'quota-exceeded';
  static const String unavailable = 'unavailable';
  static const String deadlineExceeded = 'deadline-exceeded';
  static const String alreadyExists = 'already-exists';
  static const String permissionDenied = 'permission-denied';
  static const String resourceExhausted = 'resource-exhausted';
  static const String failedPrecondition = 'failed-precondition';
  static const String aborted = 'aborted';
  static const String outOfRange = 'out-of-range';
  static const String unimplemented = 'unimplemented';
  static const String internal = 'internal';
  static const String dataLoss = 'data-loss';
  static const String unauthenticated = 'unauthenticated';
}