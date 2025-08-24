/// Classe représentant un travailleur dans l'application Khidmeti-worker (Travailleurs)
/// 
/// Cette classe contient toutes les informations nécessaires pour identifier,
/// authentifier et gérer un travailleur qui fournit des services.
class Worker {
  /// Identifiant unique du travailleur
  final String id;
  
  /// Nom d'utilisateur unique
  final String username;
  
  /// Prénom du travailleur
  final String firstName;
  
  /// Nom de famille du travailleur
  final String lastName;
  
  /// Numéro de téléphone (unique)
  final String phoneNumber;
  
  /// Adresse email (optionnelle)
  final String? email;
  
  /// Langue préférée du travailleur
  final String preferredLanguage;
  
  /// Date de naissance
  final DateTime? dateOfBirth;
  
  /// Genre du travailleur
  final Gender? gender;
  
  /// Adresse complète
  final Address? address;
  
  /// Photo de profil (URL)
  final String? profilePhotoUrl;
  
  /// Photo de la pièce d'identité (URL)
  final String? identityDocumentUrl;
  
  /// Statut de vérification du compte
  final VerificationStatus verificationStatus;
  
  /// Statut d'activité (disponible/inactif)
  final ActivityStatus activityStatus;
  
  /// Date de création du compte
  final DateTime createdAt;
  
  /// Date de dernière connexion
  final DateTime? lastLoginAt;
  
  /// Date de dernière modification
  final DateTime updatedAt;
  
  /// Indicateur si le compte est actif
  final bool isActive;
  
  /// Indicateur si le travailleur a accepté les conditions d'utilisation
  final bool hasAcceptedTerms;
  
  /// Indicateur si le travailleur a accepté la politique de confidentialité
  final bool hasAcceptedPrivacyPolicy;
  
  /// Préférences de notifications
  final NotificationPreferences notificationPreferences;
  
  /// Services proposés par le travailleur
  final List<WorkerService> services;
  
  /// Portfolio des réalisations
  final List<PortfolioItem> portfolio;
  
  /// Historique des missions
  final List<String> missionHistory;
  
  /// Rating moyen reçu des clients
  final double averageRating;
  
  /// Nombre total de missions complétées
  final int totalMissionsCompleted;
  
  /// Nombre total de clients servis
  final int totalClientsServed;
  
  /// Revenus totaux (en DA)
  final double totalEarnings;
  
  /// Revenus du mois en cours (en DA)
  final double monthlyEarnings;
  
  /// Abonnement actuel
  final Subscription? currentSubscription;
  
  /// Disponibilités du travailleur
  final List<Availability> availabilities;
  
  /// Coordonnées GPS actuelles
  final Location? currentLocation;
  
  /// Dernière mise à jour de la position
  final DateTime? lastLocationUpdate;

  /// Constructeur de la classe Worker
  const Worker({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.email,
    this.preferredLanguage = 'fr',
    this.dateOfBirth,
    this.gender,
    this.address,
    this.profilePhotoUrl,
    this.identityDocumentUrl,
    this.verificationStatus = VerificationStatus.pending,
    this.activityStatus = ActivityStatus.inactive,
    required this.createdAt,
    this.lastLoginAt,
    required this.updatedAt,
    this.isActive = true,
    this.hasAcceptedTerms = false,
    this.hasAcceptedPrivacyPolicy = false,
    this.notificationPreferences = const NotificationPreferences(),
    this.services = const [],
    this.portfolio = const [],
    this.missionHistory = const [],
    this.averageRating = 0.0,
    this.totalMissionsCompleted = 0,
    this.totalClientsServed = 0,
    this.totalEarnings = 0.0,
    this.monthlyEarnings = 0.0,
    this.currentSubscription,
    this.availabilities = const [],
    this.currentLocation,
    this.lastLocationUpdate,
  });

  /// Création d'un travailleur à partir d'un Map (JSON)
  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      id: json['id'] as String,
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String?,
      preferredLanguage: json['preferredLanguage'] as String? ?? 'fr',
      dateOfBirth: json['dateOfBirth'] != null 
          ? DateTime.parse(json['dateOfBirth'] as String) 
          : null,
      gender: json['gender'] != null 
          ? Gender.values.firstWhere(
              (e) => e.toString().split('.').last == json['gender'],
              orElse: () => Gender.other,
            )
          : null,
      address: json['address'] != null 
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : null,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      identityDocumentUrl: json['identityDocumentUrl'] as String?,
      verificationStatus: VerificationStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['verificationStatus'],
        orElse: () => VerificationStatus.pending,
      ),
      activityStatus: ActivityStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['activityStatus'],
        orElse: () => ActivityStatus.inactive,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLoginAt: json['lastLoginAt'] != null 
          ? DateTime.parse(json['lastLoginAt'] as String) 
          : null,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isActive: json['isActive'] as bool? ?? true,
      hasAcceptedTerms: json['hasAcceptedTerms'] as bool? ?? false,
      hasAcceptedPrivacyPolicy: json['hasAcceptedPrivacyPolicy'] as bool? ?? false,
      notificationPreferences: json['notificationPreferences'] != null
          ? NotificationPreferences.fromJson(json['notificationPreferences'] as Map<String, dynamic>)
          : const NotificationPreferences(),
      services: json['services'] != null
          ? (json['services'] as List)
              .map((e) => WorkerService.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      portfolio: json['portfolio'] != null
          ? (json['portfolio'] as List)
              .map((e) => PortfolioItem.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      missionHistory: List<String>.from(json['missionHistory'] ?? []),
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalMissionsCompleted: json['totalMissionsCompleted'] as int? ?? 0,
      totalClientsServed: json['totalClientsServed'] as int? ?? 0,
      totalEarnings: (json['totalEarnings'] as num?)?.toDouble() ?? 0.0,
      monthlyEarnings: (json['monthlyEarnings'] as num?)?.toDouble() ?? 0.0,
      currentSubscription: json['currentSubscription'] != null
          ? Subscription.fromJson(json['currentSubscription'] as Map<String, dynamic>)
          : null,
      availabilities: json['availabilities'] != null
          ? (json['availabilities'] as List)
              .map((e) => Availability.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      currentLocation: json['currentLocation'] != null
          ? Location.fromJson(json['currentLocation'] as Map<String, dynamic>)
          : null,
      lastLocationUpdate: json['lastLocationUpdate'] != null
          ? DateTime.parse(json['lastLocationUpdate'] as String)
          : null,
    );
  }

  /// Conversion du travailleur en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'preferredLanguage': preferredLanguage,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender?.toString().split('.').last,
      'address': address?.toJson(),
      'profilePhotoUrl': profilePhotoUrl,
      'identityDocumentUrl': identityDocumentUrl,
      'verificationStatus': verificationStatus.toString().split('.').last,
      'activityStatus': activityStatus.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
      'hasAcceptedTerms': hasAcceptedTerms,
      'hasAcceptedPrivacyPolicy': hasAcceptedPrivacyPolicy,
      'notificationPreferences': notificationPreferences.toJson(),
      'services': services.map((e) => e.toJson()).toList(),
      'portfolio': portfolio.map((e) => e.toJson()).toList(),
      'missionHistory': missionHistory,
      'averageRating': averageRating,
      'totalMissionsCompleted': totalMissionsCompleted,
      'totalClientsServed': totalClientsServed,
      'totalEarnings': totalEarnings,
      'monthlyEarnings': monthlyEarnings,
      'currentSubscription': currentSubscription?.toJson(),
      'availabilities': availabilities.map((e) => e.toJson()).toList(),
      'currentLocation': currentLocation?.toJson(),
      'lastLocationUpdate': lastLocationUpdate?.toIso8601String(),
    };
  }

  /// Création d'une copie du travailleur avec modifications
  Worker copyWith({
    String? id,
    String? username,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? preferredLanguage,
    DateTime? dateOfBirth,
    Gender? gender,
    Address? address,
    String? profilePhotoUrl,
    String? identityDocumentUrl,
    VerificationStatus? verificationStatus,
    ActivityStatus? activityStatus,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? hasAcceptedTerms,
    bool? hasAcceptedPrivacyPolicy,
    NotificationPreferences? notificationPreferences,
    List<WorkerService>? services,
    List<PortfolioItem>? portfolio,
    List<String>? missionHistory,
    double? averageRating,
    int? totalMissionsCompleted,
    int? totalClientsServed,
    double? totalEarnings,
    double? monthlyEarnings,
    Subscription? currentSubscription,
    List<Availability>? availabilities,
    Location? currentLocation,
    DateTime? lastLocationUpdate,
  }) {
    return Worker(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      identityDocumentUrl: identityDocumentUrl ?? this.identityDocumentUrl,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      activityStatus: activityStatus ?? this.activityStatus,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      hasAcceptedTerms: hasAcceptedTerms ?? this.hasAcceptedTerms,
      hasAcceptedPrivacyPolicy: hasAcceptedPrivacyPolicy ?? this.hasAcceptedPrivacyPolicy,
      notificationPreferences: notificationPreferences ?? this.notificationPreferences,
      services: services ?? this.services,
      portfolio: portfolio ?? this.portfolio,
      missionHistory: missionHistory ?? this.missionHistory,
      averageRating: averageRating ?? this.averageRating,
      totalMissionsCompleted: totalMissionsCompleted ?? this.totalMissionsCompleted,
      totalClientsServed: totalClientsServed ?? this.totalClientsServed,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      monthlyEarnings: monthlyEarnings ?? this.monthlyEarnings,
      currentSubscription: currentSubscription ?? this.currentSubscription,
      availabilities: availabilities ?? this.availabilities,
      currentLocation: currentLocation ?? this.currentLocation,
      lastLocationUpdate: lastLocationUpdate ?? this.lastLocationUpdate,
    );
  }

  /// Vérification de l'égalité entre deux travailleurs
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Worker && other.id == id;
  }

  /// Génération du hash code
  @override
  int get hashCode => id.hashCode;

  /// Représentation en string du travailleur
  @override
  String toString() {
    return 'Worker(id: $id, username: $username, name: $firstName $lastName)';
  }

  /// Obtention du nom complet du travailleur
  String get fullName => '$firstName $lastName';

  /// Obtention du nom complet en arabe (si applicable)
  String get fullNameAr {
    if (preferredLanguage == 'ar') {
      return '$lastName $firstName';
    }
    return fullName;
  }

  /// Vérification si le travailleur est vérifié
  bool get isVerified => verificationStatus == VerificationStatus.verified;

  /// Vérification si le travailleur est en attente de vérification
  bool get isPendingVerification => verificationStatus == VerificationStatus.pending;

  /// Vérification si le travailleur est rejeté
  bool get isRejected => verificationStatus == VerificationStatus.rejected;

  /// Vérification si le travailleur est actif et disponible
  bool get isAvailable => 
      isActive && 
      isVerified && 
      activityStatus == ActivityStatus.active &&
      currentLocation != null;

  /// Vérification si le travailleur a un profil complet
  bool get hasCompleteProfile => 
      firstName.isNotEmpty && 
      lastName.isNotEmpty && 
      address != null &&
      profilePhotoUrl != null &&
      identityDocumentUrl != null &&
      hasAcceptedTerms &&
      hasAcceptedPrivacyPolicy;

  /// Calcul du taux de satisfaction des missions
  double get satisfactionRate {
    if (totalMissionsCompleted == 0) return 0.0;
    return (averageRating / 5.0) * 100;
  }

  /// Vérification si le travailleur a des services
  bool get hasServices => services.isNotEmpty;

  /// Vérification si le travailleur a un portfolio
  bool get hasPortfolio => portfolio.isNotEmpty;

  /// Vérification si le travailleur a un abonnement actif
  bool get hasActiveSubscription => 
      currentSubscription != null && 
      currentSubscription!.isActive;

  /// Obtention de l'âge du travailleur
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month || 
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  /// Vérification si le travailleur est majeur
  bool get isAdult => age != null && age! >= 18;

  /// Obtention du nom d'affichage (username ou nom complet)
  String get displayName => username.isNotEmpty ? username : fullName;

  /// Obtention du nombre de services proposés
  int get servicesCount => services.length;

  /// Obtention du nombre d'éléments du portfolio
  int get portfolioCount => portfolio.length;

  /// Calcul des revenus moyens par mission
  double get averageEarningsPerMission {
    if (totalMissionsCompleted == 0) return 0.0;
    return totalEarnings / totalMissionsCompleted;
  }

  /// Vérification si le travailleur a une bonne réputation
  bool get hasGoodReputation => averageRating >= 4.0;

  /// Obtention du niveau d'expérience basé sur les missions
  ExperienceLevel get experienceLevel {
    if (totalMissionsCompleted < 10) return ExperienceLevel.beginner;
    if (totalMissionsCompleted < 50) return ExperienceLevel.intermediate;
    if (totalMissionsCompleted < 100) return ExperienceLevel.advanced;
    return ExperienceLevel.expert;
  }
}

/// Énumération des genres
enum Gender {
  male,
  female,
  other,
}

/// Énumération des statuts de vérification
enum VerificationStatus {
  pending,    // En attente de vérification
  verified,   // Vérifié
  rejected,   // Rejeté
  suspended,  // Suspendu
}

/// Énumération des statuts d'activité
enum ActivityStatus {
  active,     // Actif et disponible
  inactive,   // Inactif
  busy,       // Occupé sur une mission
  offline,    // Hors ligne
}

/// Énumération des niveaux d'expérience
enum ExperienceLevel {
  beginner,     // Débutant (0-9 missions)
  intermediate, // Intermédiaire (10-49 missions)
  advanced,     // Avancé (50-99 missions)
  expert,       // Expert (100+ missions)
}

/// Classe représentant l'adresse d'un travailleur
class Address {
  /// Rue et numéro
  final String street;
  
  /// Code postal
  final String postalCode;
  
  /// Ville
  final String city;
  
  /// Wilaya (province algérienne)
  final String wilaya;
  
  /// Coordonnées GPS (latitude)
  final double? latitude;
  
  /// Coordonnées GPS (longitude)
  final double? longitude;
  
  /// Informations complémentaires
  final String? additionalInfo;

  /// Constructeur de la classe Address
  const Address({
    required this.street,
    required this.postalCode,
    required this.city,
    required this.wilaya,
    this.latitude,
    this.longitude,
    this.additionalInfo,
  });

  /// Création d'une adresse à partir d'un Map (JSON)
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String,
      postalCode: json['postalCode'] as String,
      city: json['city'] as String,
      wilaya: json['wilaya'] as String,
      latitude: json['latitude'] != null 
          ? (json['latitude'] as num).toDouble() 
          : null,
      longitude: json['longitude'] != null 
          ? (json['longitude'] as num).toDouble() 
          : null,
      additionalInfo: json['additionalInfo'] as String?,
    );
  }

  /// Conversion de l'adresse en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'postalCode': postalCode,
      'city': city,
      'wilaya': wilaya,
      'latitude': latitude,
      'longitude': longitude,
      'additionalInfo': additionalInfo,
    };
  }

  /// Obtention de l'adresse complète formatée
  String get fullAddress {
    String address = '$street, $postalCode $city, $wilaya';
    if (additionalInfo != null && additionalInfo!.isNotEmpty) {
      address += ' ($additionalInfo)';
    }
    return address;
  }

  /// Vérification si l'adresse a des coordonnées GPS
  bool get hasCoordinates => latitude != null && longitude != null;
}

/// Classe représentant les préférences de notifications
class NotificationPreferences {
  /// Notifications push activées
  final bool pushEnabled;
  
  /// Notifications SMS activées
  final bool smsEnabled;
  
  /// Notifications email activées
  final bool emailEnabled;
  
  /// Notifications de nouvelles demandes
  final bool newRequestsEnabled;
  
  /// Notifications de mises à jour de statut
  final bool statusUpdatesEnabled;
  
  /// Notifications de messages
  final bool messagesEnabled;
  
  /// Notifications de paiements
  final bool paymentNotificationsEnabled;
  
  /// Notifications de promotions
  final bool promotionsEnabled;

  /// Constructeur de la classe NotificationPreferences
  const NotificationPreferences({
    this.pushEnabled = true,
    this.smsEnabled = true,
    this.emailEnabled = false,
    this.newRequestsEnabled = true,
    this.statusUpdatesEnabled = true,
    this.messagesEnabled = true,
    this.paymentNotificationsEnabled = true,
    this.promotionsEnabled = false,
  });

  /// Création des préférences à partir d'un Map (JSON)
  factory NotificationPreferences.fromJson(Map<String, dynamic> json) {
    return NotificationPreferences(
      pushEnabled: json['pushEnabled'] as bool? ?? true,
      smsEnabled: json['smsEnabled'] as bool? ?? true,
      emailEnabled: json['emailEnabled'] as bool? ?? false,
      newRequestsEnabled: json['newRequestsEnabled'] as bool? ?? true,
      statusUpdatesEnabled: json['statusUpdatesEnabled'] as bool? ?? true,
      messagesEnabled: json['messagesEnabled'] as bool? ?? true,
      paymentNotificationsEnabled: json['paymentNotificationsEnabled'] as bool? ?? true,
      promotionsEnabled: json['promotionsEnabled'] as bool? ?? false,
    );
  }

  /// Conversion des préférences en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'pushEnabled': pushEnabled,
      'smsEnabled': smsEnabled,
      'emailEnabled': emailEnabled,
      'newRequestsEnabled': newRequestsEnabled,
      'statusUpdatesEnabled': statusUpdatesEnabled,
      'messagesEnabled': messagesEnabled,
      'paymentNotificationsEnabled': paymentNotificationsEnabled,
      'promotionsEnabled': promotionsEnabled,
    };
  }

  /// Vérification si au moins un type de notification est activé
  bool get hasAnyNotificationsEnabled => 
      pushEnabled || smsEnabled || emailEnabled;

  /// Vérification si les notifications importantes sont activées
  bool get hasImportantNotificationsEnabled => 
      newRequestsEnabled || statusUpdatesEnabled || messagesEnabled || paymentNotificationsEnabled;
}

/// Classe représentant un service proposé par un travailleur
class WorkerService {
  /// Identifiant du service
  final String serviceId;
  
  /// Nom du service
  final String serviceName;
  
  /// Prix du service (en DA)
  final double price;
  
  /// Unité de prix (par heure, par mission, etc.)
  final String priceUnit;
  
  /// Description du service
  final String description;
  
  /// Niveau d'expertise dans ce service (1-5)
  final int expertiseLevel;
  
  /// Années d'expérience
  final int yearsOfExperience;
  
  /// Certifications associées
  final List<String> certifications;
  
  /// Indicateur si le service est actuellement proposé
  final bool isActive;
  
  /// Date d'ajout du service
  final DateTime addedAt;

  /// Constructeur de la classe WorkerService
  const WorkerService({
    required this.serviceId,
    required this.serviceName,
    required this.price,
    required this.priceUnit,
    required this.description,
    required this.expertiseLevel,
    required this.yearsOfExperience,
    this.certifications = const [],
    this.isActive = true,
    required this.addedAt,
  });

  /// Création d'un service à partir d'un Map (JSON)
  factory WorkerService.fromJson(Map<String, dynamic> json) {
    return WorkerService(
      serviceId: json['serviceId'] as String,
      serviceName: json['serviceName'] as String,
      price: (json['price'] as num).toDouble(),
      priceUnit: json['priceUnit'] as String,
      description: json['description'] as String,
      expertiseLevel: json['expertiseLevel'] as int,
      yearsOfExperience: json['yearsOfExperience'] as int,
      certifications: List<String>.from(json['certifications'] ?? []),
      isActive: json['isActive'] as bool? ?? true,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }

  /// Conversion du service en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'serviceId': serviceId,
      'serviceName': serviceName,
      'price': price,
      'priceUnit': priceUnit,
      'description': description,
      'expertiseLevel': expertiseLevel,
      'yearsOfExperience': yearsOfExperience,
      'certifications': certifications,
      'isActive': isActive,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  /// Obtention du prix formaté
  String get formattedPrice => '$price DA $priceUnit';

  /// Vérification si le travailleur est expert dans ce service
  bool get isExpert => expertiseLevel >= 4;

  /// Vérification si le travailleur a des certifications
  bool get hasCertifications => certifications.isNotEmpty;
}

/// Classe représentant un élément du portfolio
class PortfolioItem {
  /// Identifiant unique de l'élément
  final String id;
  
  /// Titre du projet
  final String title;
  
  /// Description du projet
  final String description;
  
  /// URL de l'image principale
  final String mainImageUrl;
  
  /// URLs des images supplémentaires
  final List<String> additionalImageUrls;
  
  /// Date de réalisation
  final DateTime completedAt;
  
  /// Catégorie du projet
  final String category;
  
  /// Tags associés
  final List<String> tags;
  
  /// Indicateur si l'élément est visible publiquement
  final bool isPublic;

  /// Constructeur de la classe PortfolioItem
  const PortfolioItem({
    required this.id,
    required this.title,
    required this.description,
    required this.mainImageUrl,
    this.additionalImageUrls = const [],
    required this.completedAt,
    required this.category,
    this.tags = const [],
    this.isPublic = true,
  });

  /// Création d'un élément à partir d'un Map (JSON)
  factory PortfolioItem.fromJson(Map<String, dynamic> json) {
    return PortfolioItem(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      mainImageUrl: json['mainImageUrl'] as String,
      additionalImageUrls: List<String>.from(json['additionalImageUrls'] ?? []),
      completedAt: DateTime.parse(json['completedAt'] as String),
      category: json['category'] as String,
      tags: List<String>.from(json['tags'] ?? []),
      isPublic: json['isPublic'] as bool? ?? true,
    );
  }

  /// Conversion de l'élément en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'mainImageUrl': mainImageUrl,
      'additionalImageUrls': additionalImageUrls,
      'completedAt': completedAt.toIso8601String(),
      'category': category,
      'tags': tags,
      'isPublic': isPublic,
    };
  }

  /// Vérification si l'élément a des images supplémentaires
  bool get hasAdditionalImages => additionalImageUrls.isNotEmpty;

  /// Obtention du nombre total d'images
  int get totalImages => 1 + additionalImageUrls.length;
}

/// Classe représentant un abonnement
class Subscription {
  /// Identifiant de l'abonnement
  final String id;
  
  /// Type d'abonnement
  final SubscriptionType type;
  
  /// Date de début
  final DateTime startDate;
  
  /// Date de fin
  final DateTime endDate;
  
  /// Prix payé
  final double price;
  
  /// Statut de l'abonnement
  final SubscriptionStatus status;
  
  /// Date de paiement
  final DateTime? paymentDate;

  /// Constructeur de la classe Subscription
  const Subscription({
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.status,
    this.paymentDate,
  });

  /// Création d'un abonnement à partir d'un Map (JSON)
  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'] as String,
      type: SubscriptionType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => SubscriptionType.monthly,
      ),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      price: (json['price'] as num).toDouble(),
      status: SubscriptionStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => SubscriptionStatus.active,
      ),
      paymentDate: json['paymentDate'] != null 
          ? DateTime.parse(json['paymentDate'] as String) 
          : null,
    );
  }

  /// Conversion de l'abonnement en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'price': price,
      'status': status.toString().split('.').last,
      'paymentDate': paymentDate?.toIso8601String(),
    };
  }

  /// Vérification si l'abonnement est actif
  bool get isActive => 
      status == SubscriptionStatus.active && 
      DateTime.now().isBefore(endDate);

  /// Vérification si l'abonnement est expiré
  bool get isExpired => DateTime.now().isAfter(endDate);

  /// Vérification si l'abonnement est en période d'essai
  bool get isTrial => type == SubscriptionType.trial;

  /// Calcul du nombre de jours restants
  int get daysRemaining {
    final now = DateTime.now();
    if (now.isAfter(endDate)) return 0;
    return endDate.difference(now).inDays;
  }
}

/// Énumération des types d'abonnement
enum SubscriptionType {
  trial,      // Période d'essai gratuite
  monthly,    // Abonnement mensuel
  yearly,     // Abonnement annuel
}

/// Énumération des statuts d'abonnement
enum SubscriptionStatus {
  active,     // Actif
  expired,    // Expiré
  cancelled,  // Annulé
  pending,    // En attente de paiement
}

/// Classe représentant une disponibilité
class Availability {
  /// Jour de la semaine (1-7, 1 = Lundi)
  final int dayOfWeek;
  
  /// Heure de début (format 24h)
  final TimeOfDay startTime;
  
  /// Heure de fin (format 24h)
  final TimeOfDay endTime;
  
  /// Indicateur si la disponibilité est active
  final bool isActive;

  /// Constructeur de la classe Availability
  const Availability({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.isActive = true,
  });

  /// Création d'une disponibilité à partir d'un Map (JSON)
  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      dayOfWeek: json['dayOfWeek'] as int,
      startTime: TimeOfDay.fromJson(json['startTime'] as Map<String, dynamic>),
      endTime: TimeOfDay.fromJson(json['endTime'] as Map<String, dynamic>),
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  /// Conversion de la disponibilité en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      'isActive': isActive,
    };
  }

  /// Obtention du nom du jour
  String get dayName {
    switch (dayOfWeek) {
      case 1: return 'Lundi';
      case 2: return 'Mardi';
      case 3: return 'Mercredi';
      case 4: return 'Jeudi';
      case 5: return 'Vendredi';
      case 6: return 'Samedi';
      case 7: return 'Dimanche';
      default: return 'Inconnu';
    }
  }

  /// Calcul de la durée en heures
  double get durationInHours {
    final start = startTime.hour + (startTime.minute / 60.0);
    final end = endTime.hour + (endTime.minute / 60.0);
    return end - start;
  }
}

/// Classe représentant une heure de la journée
class TimeOfDay {
  /// Heure (0-23)
  final int hour;
  
  /// Minute (0-59)
  final int minute;

  /// Constructeur de la classe TimeOfDay
  const TimeOfDay({
    required this.hour,
    required this.minute,
  });

  /// Création d'une heure à partir d'un Map (JSON)
  factory TimeOfDay.fromJson(Map<String, dynamic> json) {
    return TimeOfDay(
      hour: json['hour'] as int,
      minute: json['minute'] as int,
    );
  }

  /// Conversion de l'heure en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'minute': minute,
    };
  }

  /// Obtention de l'heure formatée
  String get formatted {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}

/// Classe représentant une localisation GPS
class Location {
  /// Latitude
  final double latitude;
  
  /// Longitude
  final double longitude;
  
  /// Précision en mètres
  final double? accuracy;
  
  /// Altitude en mètres
  final double? altitude;
  
  /// Vitesse en m/s
  final double? speed;
  
  /// Direction en degrés
  final double? heading;

  /// Constructeur de la classe Location
  const Location({
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.altitude,
    this.speed,
    this.heading,
  });

  /// Création d'une localisation à partir d'un Map (JSON)
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: json['accuracy'] != null 
          ? (json['accuracy'] as num).toDouble() 
          : null,
      altitude: json['altitude'] != null 
          ? (json['altitude'] as num).toDouble() 
          : null,
      speed: json['speed'] != null 
          ? (json['speed'] as num).toDouble() 
          : null,
      heading: json['heading'] != null 
          ? (json['heading'] as num).toDouble() 
          : null,
    );
  }

  /// Conversion de la localisation en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
      'altitude': altitude,
      'speed': speed,
      'heading': heading,
    };
  }

  /// Vérification si la localisation a une bonne précision
  bool get hasGoodAccuracy => accuracy != null && accuracy! < 10.0;

  /// Obtention des coordonnées formatées
  String get coordinates => '$latitude, $longitude';
}