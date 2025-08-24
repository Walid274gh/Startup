import 'package:cloud_firestore/cloud_firestore.dart';

class WorkerModel {
  final String id;
  final String userId; // Référence vers le document utilisateur
  final String fullName;
  final String phoneNumber;
  final String? profileImageUrl;
  final List<String> professions; // Métiers exercés
  final Map<String, dynamic> skills; // Compétences détaillées par métier
  final Map<String, double> hourlyRates; // Tarifs par heure par métier
  final double rating;
  final int totalJobs;
  final int completedJobs;
  final bool isAvailable;
  final bool isOnline;
  final DateTime lastActive;
  final DateTime createdAt;
  final Map<String, dynamic> location;
  final double? currentLatitude;
  final double? currentLongitude;
  final String subscriptionStatus; // 'trial', 'monthly', 'yearly', 'expired'
  final DateTime? subscriptionExpiry;
  final List<String> certificates; // URLs des certificats
  final bool isVerified;
  final bool isPremium; // Travailleur premium avec vérification renforcée
  final Map<String, dynamic> workSchedule; // Horaires de travail
  final List<String> languages; // Langues parlées
  final String fcmToken;
  final Map<String, dynamic> preferences;
  final List<String> workingAreas; // Zones de travail
  final double maxDistance; // Distance maximale de déplacement (km)
  final Map<String, dynamic> availability; // Disponibilité par jour/semaine

  WorkerModel({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.phoneNumber,
    this.profileImageUrl,
    required this.professions,
    required this.skills,
    required this.hourlyRates,
    required this.rating,
    required this.totalJobs,
    required this.completedJobs,
    required this.isAvailable,
    required this.isOnline,
    required this.lastActive,
    required this.createdAt,
    required this.location,
    this.currentLatitude,
    this.currentLongitude,
    required this.subscriptionStatus,
    this.subscriptionExpiry,
    required this.certificates,
    required this.isVerified,
    required this.isPremium,
    required this.workSchedule,
    required this.languages,
    required this.fcmToken,
    required this.preferences,
    required this.workingAreas,
    required this.maxDistance,
    required this.availability,
  });

  // Factory constructor pour créer un travailleur depuis Firestore
  factory WorkerModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WorkerModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      fullName: data['fullName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      profileImageUrl: data['profileImageUrl'],
      professions: List<String>.from(data['professions'] ?? []),
      skills: Map<String, dynamic>.from(data['skills'] ?? {}),
      hourlyRates: Map<String, double>.from(
        (data['hourlyRates'] ?? {}).map((key, value) => 
          MapEntry(key, (value ?? 0.0).toDouble())
        )
      ),
      rating: (data['rating'] ?? 0.0).toDouble(),
      totalJobs: data['totalJobs'] ?? 0,
      completedJobs: data['completedJobs'] ?? 0,
      isAvailable: data['isAvailable'] ?? false,
      isOnline: data['isOnline'] ?? false,
      lastActive: (data['lastActive'] as Timestamp).toDate(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      location: Map<String, dynamic>.from(data['location'] ?? {}),
      currentLatitude: data['currentLatitude']?.toDouble(),
      currentLongitude: data['currentLongitude']?.toDouble(),
      subscriptionStatus: data['subscriptionStatus'] ?? 'trial',
      subscriptionExpiry: data['subscriptionExpiry'] != null 
        ? (data['subscriptionStatus'] as Timestamp).toDate() 
        : null,
      certificates: List<String>.from(data['certificates'] ?? []),
      isVerified: data['isVerified'] ?? false,
      isPremium: data['isPremium'] ?? false,
      workSchedule: Map<String, dynamic>.from(data['workSchedule'] ?? {}),
      languages: List<String>.from(data['languages'] ?? []),
      fcmToken: data['fcmToken'] ?? '',
      preferences: Map<String, dynamic>.from(data['preferences'] ?? {}),
      workingAreas: List<String>.from(data['workingAreas'] ?? []),
      maxDistance: (data['maxDistance'] ?? 50.0).toDouble(),
      availability: Map<String, dynamic>.from(data['availability'] ?? {}),
    );
  }

  // Méthode pour convertir le modèle en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'professions': professions,
      'skills': skills,
      'hourlyRates': hourlyRates,
      'rating': rating,
      'totalJobs': totalJobs,
      'completedJobs': completedJobs,
      'isAvailable': isAvailable,
      'isOnline': isOnline,
      'lastActive': Timestamp.fromDate(lastActive),
      'createdAt': Timestamp.fromDate(createdAt),
      'location': location,
      'currentLatitude': currentLatitude,
      'currentLongitude': currentLongitude,
      'subscriptionStatus': subscriptionStatus,
      'subscriptionExpiry': subscriptionExpiry != null 
        ? Timestamp.fromDate(subscriptionExpiry!) 
        : null,
      'certificates': certificates,
      'isVerified': isVerified,
      'isPremium': isPremium,
      'workSchedule': workSchedule,
      'languages': languages,
      'fcmToken': fcmToken,
      'preferences': preferences,
      'workingAreas': workingAreas,
      'maxDistance': maxDistance,
      'availability': availability,
      'userType': 'worker', // Identifiant pour différencier les types d'utilisateurs
      'lastUpdated': FieldValue.serverTimestamp(), // Timestamp de synchronisation
    };
  }

  // Méthode pour créer une copie modifiée du modèle
  WorkerModel copyWith({
    String? id,
    String? userId,
    String? fullName,
    String? phoneNumber,
    String? profileImageUrl,
    List<String>? professions,
    Map<String, dynamic>? skills,
    Map<String, double>? hourlyRates,
    double? rating,
    int? totalJobs,
    int? completedJobs,
    bool? isAvailable,
    bool? isOnline,
    DateTime? lastActive,
    DateTime? createdAt,
    Map<String, dynamic>? location,
    double? currentLatitude,
    double? currentLongitude,
    String? subscriptionStatus,
    DateTime? subscriptionExpiry,
    List<String>? certificates,
    bool? isVerified,
    bool? isPremium,
    Map<String, dynamic>? workSchedule,
    List<String>? languages,
    String? fcmToken,
    Map<String, dynamic>? preferences,
    List<String>? workingAreas,
    double? maxDistance,
    Map<String, dynamic>? availability,
  }) {
    return WorkerModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      professions: professions ?? this.professions,
      skills: skills ?? this.skills,
      hourlyRates: hourlyRates ?? this.hourlyRates,
      rating: rating ?? this.rating,
      totalJobs: totalJobs ?? this.totalJobs,
      completedJobs: completedJobs ?? this.completedJobs,
      isAvailable: isAvailable ?? this.isAvailable,
      isOnline: isOnline ?? this.isOnline,
      lastActive: lastActive ?? this.lastActive,
      createdAt: createdAt ?? this.createdAt,
      location: location ?? this.location,
      currentLatitude: currentLatitude ?? this.currentLatitude,
      currentLongitude: currentLongitude ?? this.currentLongitude,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      subscriptionExpiry: subscriptionExpiry ?? this.subscriptionExpiry,
      certificates: certificates ?? this.certificates,
      isVerified: isVerified ?? this.isVerified,
      isPremium: isPremium ?? this.isPremium,
      workSchedule: workSchedule ?? this.workSchedule,
      languages: languages ?? this.languages,
      fcmToken: fcmToken ?? this.fcmToken,
      preferences: preferences ?? this.preferences,
      workingAreas: workingAreas ?? this.workingAreas,
      maxDistance: maxDistance ?? this.maxDistance,
      availability: availability ?? this.availability,
    );
  }

  // Méthodes utilitaires
  bool get isSubscriptionActive {
    if (subscriptionStatus == 'trial') return true;
    if (subscriptionExpiry == null) return false;
    return DateTime.now().isBefore(subscriptionExpiry!);
  }

  bool get canAcceptJobs => isAvailable && isOnline && isSubscriptionActive;

  double getHourlyRate(String profession) {
    return hourlyRates[profession] ?? 0.0;
  }

  bool hasSkill(String skill) {
    return skills.values.any((skillList) => 
      skillList is List && skillList.contains(skill)
    );
  }

  bool isAvailableForProfession(String profession) {
    return professions.contains(profession) && canAcceptJobs;
  }

  // Calcul de distance depuis un point donné
  double getDistanceFrom(double lat, double lng) {
    if (currentLatitude == null || currentLongitude == null) {
      return double.infinity;
    }
    
    const double earthRadius = 6371; // km
    final dLat = _toRadians(lat - currentLatitude!);
    final dLng = _toRadians(lng - currentLongitude!);
    
    final a = (dLat / 2).sin() * (dLat / 2).sin() +
               (currentLatitude! * lat).cos() * (dLng / 2).sin() * (dLng / 2).sin();
    final c = 2 * (a.sqrt() / (1 - a).sqrt()).atan();
    
    return earthRadius * c;
  }

  double _toRadians(double degree) => degree * (3.14159 / 180);

  // Vérification de validité
  bool get isValid => 
    fullName.isNotEmpty && 
    phoneNumber.isNotEmpty && 
    professions.isNotEmpty &&
    isVerified;
}