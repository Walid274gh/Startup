/// Classe représentant une évaluation reçue dans l'application Khidmeti-worker (Travailleurs)
/// 
/// Cette classe contient toutes les informations nécessaires pour gérer
/// les évaluations reçues par les travailleurs de la part des clients.
class Rating {
  /// Identifiant unique de l'évaluation
  final String id;
  
  /// Identifiant du client qui a donné l'évaluation
  final String userId;
  
  /// Identifiant du travailleur évalué
  final String workerId;
  
  /// Identifiant de la mission associée
  final String missionId;
  
  /// Identifiant de la demande associée
  final String requestId;
  
  /// Note donnée (1-5 étoiles)
  final int stars;
  
  /// Commentaire de l'évaluation
  final String comment;
  
  /// Commentaire en arabe
  final String commentAr;
  
  /// Commentaire en anglais
  final String commentEn;
  
  /// Catégories d'évaluation
  final List<RatingCategory> categories;
  
  /// Date de l'évaluation
  final DateTime ratedAt;
  
  /// Date de dernière modification
  final DateTime updatedAt;
  
  /// Indicateur si l'évaluation est publique
  final bool isPublic;
  
  /// Indicateur si l'évaluation a été modérée
  final bool isModerated;
  
  /// Raison de modération (si modérée)
  final String? moderationReason;
  
  /// Statut de l'évaluation
  final RatingStatus status;
  
  /// Médias associés (photos avant/après)
  final List<RatingMedia> media;
  
  /// Réponse du travailleur (si applicable)
  final String? workerResponse;
  
  /// Date de réponse du travailleur
  final DateTime? workerResponseAt;
  
  /// Indicateur si le travailleur a répondu
  final bool hasWorkerResponded;
  
  /// Impact sur le score global du travailleur
  final double impactOnOverallScore;
  
  /// Indicateur si c'est une évaluation anonyme
  final bool isAnonymous;
  
  /// Type d'évaluation
  final RatingType ratingType;

  /// Constructeur de la classe Rating
  const Rating({
    required this.id,
    required this.userId,
    required this.workerId,
    required this.missionId,
    required this.requestId,
    required this.stars,
    required this.comment,
    required this.commentAr,
    required this.commentEn,
    this.categories = const [],
    required this.ratedAt,
    required this.updatedAt,
    this.isPublic = true,
    this.isModerated = false,
    this.moderationReason,
    this.status = RatingStatus.active,
    this.media = const [],
    this.workerResponse,
    this.workerResponseAt,
    this.hasWorkerResponded = false,
    this.impactOnOverallScore = 0.0,
    this.isAnonymous = false,
    this.ratingType = RatingType.mission,
  });

  /// Création d'une évaluation à partir d'un Map (JSON)
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] as String,
      userId: json['userId'] as String,
      workerId: json['workerId'] as String,
      missionId: json['missionId'] as String,
      requestId: json['requestId'] as String,
      stars: json['stars'] as int,
      comment: json['comment'] as String,
      commentAr: json['commentAr'] as String,
      commentEn: json['commentEn'] as String,
      categories: json['categories'] != null
          ? (json['categories'] as List)
              .map((e) => RatingCategory.values.firstWhere(
                (cat) => cat.toString().split('.').last == e,
                orElse: () => RatingCategory.quality,
              ))
              .toList()
          : [],
      ratedAt: DateTime.parse(json['ratedAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isPublic: json['isPublic'] as bool? ?? true,
      isModerated: json['isModerated'] as bool? ?? false,
      moderationReason: json['moderationReason'] as String?,
      status: RatingStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => RatingStatus.active,
      ),
      media: json['media'] != null
          ? (json['media'] as List)
              .map((e) => RatingMedia.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      workerResponse: json['workerResponse'] as String?,
      workerResponseAt: json['workerResponseAt'] != null 
          ? DateTime.parse(json['workerResponseAt'] as String) 
          : null,
      hasWorkerResponded: json['hasWorkerResponded'] as bool? ?? false,
      impactOnOverallScore: (json['impactOnOverallScore'] as num?)?.toDouble() ?? 0.0,
      isAnonymous: json['isAnonymous'] as bool? ?? false,
      ratingType: RatingType.values.firstWhere(
        (e) => e.toString().split('.').last == json['ratingType'],
        orElse: () => RatingType.mission,
      ),
    );
  }

  /// Conversion de l'évaluation en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'workerId': workerId,
      'missionId': missionId,
      'requestId': requestId,
      'stars': stars,
      'comment': comment,
      'commentAr': commentAr,
      'commentEn': commentEn,
      'categories': categories.map((e) => e.toString().split('.').last).toList(),
      'ratedAt': ratedAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isPublic': isPublic,
      'isModerated': isModerated,
      'moderationReason': moderationReason,
      'status': status.toString().split('.').last,
      'media': media.map((e) => e.toJson()).toList(),
      'workerResponse': workerResponse,
      'workerResponseAt': workerResponseAt?.toIso8601String(),
      'hasWorkerResponded': hasWorkerResponded,
      'impactOnOverallScore': impactOnOverallScore,
      'isAnonymous': isAnonymous,
      'ratingType': ratingType.toString().split('.').last,
    };
  }

  /// Vérification de l'égalité entre deux évaluations
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Rating && other.id == id;
  }

  /// Génération du hash code
  @override
  int get hashCode => id.hashCode;

  /// Représentation en string de l'évaluation
  @override
  String toString() {
    return 'Rating(id: $id, stars: $stars, workerId: $workerId)';
  }

  /// Vérification si l'évaluation est positive (4-5 étoiles)
  bool get isPositive => stars >= 4;

  /// Vérification si l'évaluation est neutre (3 étoiles)
  bool get isNeutral => stars == 3;

  /// Vérification si l'évaluation est négative (1-2 étoiles)
  bool get isNegative => stars <= 2;

  /// Vérification si l'évaluation est excellente (5 étoiles)
  bool get isExcellent => stars == 5;

  /// Vérification si l'évaluation est très mauvaise (1 étoile)
  bool get isVeryBad => stars == 1;

  /// Vérification si l'évaluation est active
  bool get isActive => status == RatingStatus.active;

  /// Vérification si l'évaluation est modérée
  bool get isModerated => status == RatingStatus.moderated;

  /// Vérification si l'évaluation est rejetée
  bool get isRejected => status == RatingStatus.rejected;

  /// Vérification si l'évaluation a des médias
  bool get hasMedia => media.isNotEmpty;

  /// Vérification si l'évaluation a des catégories
  bool get hasCategories => categories.isNotEmpty;

  /// Vérification si le travailleur a répondu
  bool get hasWorkerResponse => workerResponse != null && workerResponse!.isNotEmpty;

  /// Vérification si c'est une évaluation anonyme
  bool get isAnonymousRating => isAnonymous;

  /// Vérification si c'est une évaluation de mission
  bool get isMissionRating => ratingType == RatingType.mission;

  /// Vérification si c'est une évaluation de profil
  bool get isProfileRating => ratingType == RatingType.profile;

  /// Vérification si c'est une évaluation de service
  bool get isServiceRating => ratingType == RatingType.service;

  /// Obtention du commentaire dans la langue spécifiée
  String getCommentByLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
        return commentAr;
      case 'en':
        return commentEn;
      case 'fr':
      default:
        return comment;
    }
  }

  /// Obtention de la note en pourcentage
  double get percentageScore => (stars / 5.0) * 100;

  /// Obtention de la note en texte
  String get scoreText {
    switch (stars) {
      case 1:
        return 'Très mauvais';
      case 2:
        return 'Mauvais';
      case 3:
        return 'Moyen';
      case 4:
        return 'Bon';
      case 5:
        return 'Excellent';
      default:
        return 'Non défini';
    }
  }

  /// Calcul de la durée depuis l'évaluation
  Duration get age {
    return DateTime.now().difference(ratedAt);
  }

  /// Obtention de l'âge en jours
  int get ageInDays => age.inDays;

  /// Obtention de l'âge en heures
  int get ageInHours => age.inHours;

  /// Vérification si l'évaluation est récente (< 24h)
  bool get isRecent => ageInHours < 24;

  /// Vérification si l'évaluation est ancienne (> 30 jours)
  bool get isOld => ageInDays > 30;

  /// Obtention du nombre de catégories
  int get categoriesCount => categories.length;

  /// Obtention du nombre de médias
  int get mediaCount => media.length;

  /// Obtention de l'impact sur le score formaté
  String get formattedImpactScore {
    if (impactOnOverallScore > 0) {
      return '+${impactOnOverallScore.toStringAsFixed(1)}';
    }
    return impactOnOverallScore.toStringAsFixed(1);
  }

  /// Vérification si l'évaluation a un impact positif
  bool get hasPositiveImpact => impactOnOverallScore > 0;

  /// Vérification si l'évaluation a un impact négatif
  bool get hasNegativeImpact => impactOnOverallScore < 0;

  /// Vérification si l'évaluation n'a pas d'impact
  bool get hasNoImpact => impactOnOverallScore == 0;

  /// Obtention du type d'évaluation en texte
  String get ratingTypeText {
    switch (ratingType) {
      case RatingType.mission:
        return 'Mission';
      case RatingType.profile:
        return 'Profil';
      case RatingType.service:
        return 'Service';
      case RatingType.overall:
        return 'Général';
    }
  }
}

/// Énumération des catégories d'évaluation
enum RatingCategory {
  quality,        // Qualité du travail
  punctuality,    // Ponctualité
  communication,  // Communication
  professionalism, // Professionnalisme
  cleanliness,    // Propreté
  price,          // Rapport qualité/prix
  speed,          // Rapidité d'exécution
  courtesy,       // Courtoisie
  reliability,    // Fiabilité
  expertise,      // Expertise technique
}

/// Énumération des statuts d'évaluation
enum RatingStatus {
  active,         // Évaluation active et visible
  moderated,      // Évaluation modérée
  rejected,       // Évaluation rejetée
  pending,        // En attente de modération
  hidden,         // Cachée temporairement
}

/// Énumération des types d'évaluation
enum RatingType {
  mission,        // Évaluation de mission
  profile,        // Évaluation de profil
  service,        // Évaluation de service
  overall,        // Évaluation générale
}

/// Classe représentant un média associé à une évaluation
class RatingMedia {
  /// Identifiant unique du média
  final String id;
  
  /// Type de média
  final MediaType type;
  
  /// URL du fichier
  final String url;
  
  /// Nom du fichier
  final String fileName;
  
  /// Taille du fichier en bytes
  final int fileSize;
  
  /// Type MIME
  final String mimeType;
  
  /// Description du média
  final String? description;
  
  /// Type de média (avant/après travaux)
  final MediaTiming timing;
  
  /// Date d'upload
  final DateTime uploadedAt;

  /// Constructeur de la classe RatingMedia
  const RatingMedia({
    required this.id,
    required this.type,
    required this.url,
    required this.fileName,
    required this.fileSize,
    required this.mimeType,
    this.description,
    required this.timing,
    required this.uploadedAt,
  });

  /// Création d'un média à partir d'un Map (JSON)
  factory RatingMedia.fromJson(Map<String, dynamic> json) {
    return RatingMedia(
      id: json['id'] as String,
      type: MediaType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => MediaType.image,
      ),
      url: json['url'] as String,
      fileName: json['fileName'] as String,
      fileSize: json['fileSize'] as int,
      mimeType: json['mimeType'] as String,
      description: json['description'] as String?,
      timing: MediaTiming.values.firstWhere(
        (e) => e.toString().split('.').last == json['timing'],
        orElse: () => MediaTiming.after,
      ),
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
    );
  }

  /// Conversion du média en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'url': url,
      'fileName': fileName,
      'fileSize': fileSize,
      'mimeType': mimeType,
      'description': description,
      'timing': timing.toString().split('.').last,
      'uploadedAt': uploadedAt.toIso8601String(),
    };
  }

  /// Vérification si c'est une image
  bool get isImage => type == MediaType.image;

  /// Vérification si c'est une vidéo
  bool get isVideo => type == MediaType.video;

  /// Vérification si c'est un document
  bool get isDocument => type == MediaType.document;

  /// Vérification si c'est avant les travaux
  bool get isBefore => timing == MediaTiming.before;

  /// Vérification si c'est après les travaux
  bool get isAfter => timing == MediaTiming.after;

  /// Vérification si c'est pendant les travaux
  bool get isDuring => timing == MediaTiming.during;

  /// Obtention de la taille formatée
  String get formattedSize {
    if (fileSize < 1024) return '${fileSize} B';
    if (fileSize < 1024 * 1024) return '${(fileSize / 1024).toStringAsFixed(1)} KB';
    return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Obtention du timing en texte
  String get timingText {
    switch (timing) {
      case MediaTiming.before:
        return 'Avant travaux';
      case MediaTiming.during:
        return 'Pendant travaux';
      case MediaTiming.after:
        return 'Après travaux';
    }
  }
}

/// Énumération des types de timing des médias
enum MediaTiming {
  before,     // Avant les travaux
  during,     // Pendant les travaux
  after,      // Après les travaux
}