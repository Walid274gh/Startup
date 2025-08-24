/// Classe représentant un utilisateur dans l'application Khidmeti (Utilisateurs)
/// 
/// Cette classe contient toutes les informations nécessaires pour identifier,
/// authentifier et gérer un utilisateur qui recherche des services.
class User {
  /// Identifiant unique de l'utilisateur
  final String id;
  
  /// Nom d'utilisateur unique
  final String username;
  
  /// Prénom de l'utilisateur
  final String firstName;
  
  /// Nom de famille de l'utilisateur
  final String lastName;
  
  /// Numéro de téléphone (unique)
  final String phoneNumber;
  
  /// Adresse email (optionnelle)
  final String? email;
  
  /// Langue préférée de l'utilisateur
  final String preferredLanguage;
  
  /// Date de naissance
  final DateTime? dateOfBirth;
  
  /// Genre de l'utilisateur
  final Gender? gender;
  
  /// Adresse complète
  final Address? address;
  
  /// Avatar de l'utilisateur (URL)
  final String? avatarUrl;
  
  /// Statut de vérification du compte
  final VerificationStatus verificationStatus;
  
  /// Date de création du compte
  final DateTime createdAt;
  
  /// Date de dernière connexion
  final DateTime? lastLoginAt;
  
  /// Date de dernière modification
  final DateTime updatedAt;
  
  /// Indicateur si le compte est actif
  final bool isActive;
  
  /// Indicateur si l'utilisateur a accepté les conditions d'utilisation
  final bool hasAcceptedTerms;
  
  /// Indicateur si l'utilisateur a accepté la politique de confidentialité
  final bool hasAcceptedPrivacyPolicy;
  
  /// Préférences de notifications
  final NotificationPreferences notificationPreferences;
  
  /// Historique des demandes de service
  final List<String> requestHistory;
  
  /// Liste des travailleurs favoris
  final List<String> favoriteWorkers;
  
  /// Rating moyen donné par l'utilisateur
  final double averageRatingGiven;
  
  /// Nombre total de demandes créées
  final int totalRequestsCreated;
  
  /// Nombre total de demandes complétées
  final int totalRequestsCompleted;

  /// Constructeur de la classe User
  const User({
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
    this.avatarUrl,
    this.verificationStatus = VerificationStatus.pending,
    required this.createdAt,
    this.lastLoginAt,
    required this.updatedAt,
    this.isActive = true,
    this.hasAcceptedTerms = false,
    this.hasAcceptedPrivacyPolicy = false,
    this.notificationPreferences = const NotificationPreferences(),
    this.requestHistory = const [],
    this.favoriteWorkers = const [],
    this.averageRatingGiven = 0.0,
    this.totalRequestsCreated = 0,
    this.totalRequestsCompleted = 0,
  });

  /// Création d'un utilisateur à partir d'un Map (JSON)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
      avatarUrl: json['avatarUrl'] as String?,
      verificationStatus: VerificationStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['verificationStatus'],
        orElse: () => VerificationStatus.pending,
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
      requestHistory: List<String>.from(json['requestHistory'] ?? []),
      favoriteWorkers: List<String>.from(json['favoriteWorkers'] ?? []),
      averageRatingGiven: (json['averageRatingGiven'] as num?)?.toDouble() ?? 0.0,
      totalRequestsCreated: json['totalRequestsCreated'] as int? ?? 0,
      totalRequestsCompleted: json['totalRequestsCompleted'] as int? ?? 0,
    );
  }

  /// Conversion de l'utilisateur en Map (JSON)
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
      'avatarUrl': avatarUrl,
      'verificationStatus': verificationStatus.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
      'hasAcceptedTerms': hasAcceptedTerms,
      'hasAcceptedPrivacyPolicy': hasAcceptedPrivacyPolicy,
      'notificationPreferences': notificationPreferences.toJson(),
      'requestHistory': requestHistory,
      'favoriteWorkers': favoriteWorkers,
      'averageRatingGiven': averageRatingGiven,
      'totalRequestsCreated': totalRequestsCreated,
      'totalRequestsCompleted': totalRequestsCompleted,
    };
  }

  /// Création d'une copie de l'utilisateur avec modifications
  User copyWith({
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
    String? avatarUrl,
    VerificationStatus? verificationStatus,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? hasAcceptedTerms,
    bool? hasAcceptedPrivacyPolicy,
    NotificationPreferences? notificationPreferences,
    List<String>? requestHistory,
    List<String>? favoriteWorkers,
    double? averageRatingGiven,
    int? totalRequestsCreated,
    int? totalRequestsCompleted,
  }) {
    return User(
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
      avatarUrl: avatarUrl ?? this.avatarUrl,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      hasAcceptedTerms: hasAcceptedTerms ?? this.hasAcceptedTerms,
      hasAcceptedPrivacyPolicy: hasAcceptedPrivacyPolicy ?? this.hasAcceptedPrivacyPolicy,
      notificationPreferences: notificationPreferences ?? this.notificationPreferences,
      requestHistory: requestHistory ?? this.requestHistory,
      favoriteWorkers: favoriteWorkers ?? this.favoriteWorkers,
      averageRatingGiven: averageRatingGiven ?? this.averageRatingGiven,
      totalRequestsCreated: totalRequestsCreated ?? this.totalRequestsCreated,
      totalRequestsCompleted: totalRequestsCompleted ?? this.totalRequestsCompleted,
    );
  }

  /// Vérification de l'égalité entre deux utilisateurs
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  /// Génération du hash code
  @override
  int get hashCode => id.hashCode;

  /// Représentation en string de l'utilisateur
  @override
  String toString() {
    return 'User(id: $id, username: $username, name: $firstName $lastName)';
  }

  /// Obtention du nom complet de l'utilisateur
  String get fullName => '$firstName $lastName';

  /// Obtention du nom complet en arabe (si applicable)
  String get fullNameAr {
    if (preferredLanguage == 'ar') {
      return '$lastName $firstName';
    }
    return fullName;
  }

  /// Vérification si l'utilisateur est vérifié
  bool get isVerified => verificationStatus == VerificationStatus.verified;

  /// Vérification si l'utilisateur est en attente de vérification
  bool get isPendingVerification => verificationStatus == VerificationStatus.pending;

  /// Vérification si l'utilisateur est rejeté
  bool get isRejected => verificationStatus == VerificationStatus.rejected;

  /// Vérification si l'utilisateur a un profil complet
  bool get hasCompleteProfile => 
      firstName.isNotEmpty && 
      lastName.isNotEmpty && 
      address != null &&
      hasAcceptedTerms &&
      hasAcceptedPrivacyPolicy;

  /// Calcul du taux de satisfaction des demandes
  double get satisfactionRate {
    if (totalRequestsCreated == 0) return 0.0;
    return (totalRequestsCompleted / totalRequestsCreated) * 100;
  }

  /// Vérification si l'utilisateur a des travailleurs favoris
  bool get hasFavoriteWorkers => favoriteWorkers.isNotEmpty;

  /// Vérification si l'utilisateur a un historique de demandes
  bool get hasRequestHistory => requestHistory.isNotEmpty;

  /// Obtention de l'âge de l'utilisateur
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

  /// Vérification si l'utilisateur est majeur
  bool get isAdult => age != null && age! >= 18;

  /// Obtention du nom d'affichage (username ou nom complet)
  String get displayName => username.isNotEmpty ? username : fullName;
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

/// Classe représentant l'adresse d'un utilisateur
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
      'promotionsEnabled': promotionsEnabled,
    };
  }

  /// Vérification si au moins un type de notification est activé
  bool get hasAnyNotificationsEnabled => 
      pushEnabled || smsEnabled || emailEnabled;

  /// Vérification si les notifications importantes sont activées
  bool get hasImportantNotificationsEnabled => 
      newRequestsEnabled || statusUpdatesEnabled || messagesEnabled;
}