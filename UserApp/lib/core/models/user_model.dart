import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String phoneNumber;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime lastActive;
  final bool isOnline;
  final Map<String, dynamic> preferences;
  final List<String> favoriteWorkers;
  final int totalRequests;
  final double averageRating;
  final String language;
  final String fcmToken;
  final Map<String, dynamic> location;
  final bool isVerified;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.profileImageUrl,
    required this.createdAt,
    required this.lastActive,
    required this.isOnline,
    required this.preferences,
    required this.favoriteWorkers,
    required this.totalRequests,
    required this.averageRating,
    required this.language,
    required this.fcmToken,
    required this.location,
    required this.isVerified,
  });

  // Factory constructor pour créer un utilisateur depuis Firestore
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      profileImageUrl: data['profileImageUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastActive: (data['lastActive'] as Timestamp).toDate(),
      isOnline: data['isOnline'] ?? false,
      preferences: Map<String, dynamic>.from(data['preferences'] ?? {}),
      favoriteWorkers: List<String>.from(data['favoriteWorkers'] ?? []),
      totalRequests: data['totalRequests'] ?? 0,
      averageRating: (data['averageRating'] ?? 0.0).toDouble(),
      language: data['language'] ?? 'fr',
      fcmToken: data['fcmToken'] ?? '',
      location: Map<String, dynamic>.from(data['location'] ?? {}),
      isVerified: data['isVerified'] ?? false,
    );
  }

  // Méthode pour convertir le modèle en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastActive': Timestamp.fromDate(lastActive),
      'isOnline': isOnline,
      'preferences': preferences,
      'favoriteWorkers': favoriteWorkers,
      'totalRequests': totalRequests,
      'averageRating': averageRating,
      'language': language,
      'fcmToken': fcmToken,
      'location': location,
      'isVerified': isVerified,
      'userType': 'client', // Identifiant pour différencier les types d'utilisateurs
      'lastUpdated': FieldValue.serverTimestamp(), // Timestamp de synchronisation
    };
  }

  // Méthode pour créer une copie modifiée du modèle
  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? lastActive,
    bool? isOnline,
    Map<String, dynamic>? preferences,
    List<String>? favoriteWorkers,
    int? totalRequests,
    double? averageRating,
    String? language,
    String? fcmToken,
    Map<String, dynamic>? location,
    bool? isVerified,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
      isOnline: isOnline ?? this.isOnline,
      preferences: preferences ?? this.preferences,
      favoriteWorkers: favoriteWorkers ?? this.favoriteWorkers,
      totalRequests: totalRequests ?? this.totalRequests,
      averageRating: averageRating ?? this.averageRating,
      language: language ?? this.language,
      fcmToken: fcmToken ?? this.fcmToken,
      location: location ?? this.location,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  // Méthode pour vérifier si l'utilisateur a des données valides
  bool get isValid => 
    username.isNotEmpty && 
    email.isNotEmpty && 
    phoneNumber.isNotEmpty &&
    isVerified;

  // Méthode pour obtenir la distance depuis un point donné
  double getDistanceFrom(double lat, double lng) {
    if (location['latitude'] == null || location['longitude'] == null) {
      return double.infinity;
    }
    
    final userLat = location['latitude'] as double;
    final userLng = location['longitude'] as double;
    
    // Calcul de distance approximative (formule de Haversine)
    const double earthRadius = 6371; // km
    final dLat = _toRadians(lat - userLat);
    final dLng = _toRadians(lng - userLng);
    
    final a = (dLat / 2).sin() * (dLat / 2).sin() +
               (userLat * lat).cos() * (dLng / 2).sin() * (dLng / 2).sin();
    final c = 2 * (a.sqrt() / (1 - a).sqrt()).atan();
    
    return earthRadius * c;
  }

  double _toRadians(double degree) => degree * (3.14159 / 180);
}