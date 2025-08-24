/// Classe représentant une demande de service reçue dans l'application Khidmeti-worker (Travailleurs)
/// 
/// Cette classe contient toutes les informations nécessaires pour qu'un travailleur
/// puisse consulter et répondre aux demandes de service.
class Request {
  /// Identifiant unique de la demande
  final String id;
  
  /// Identifiant de l'utilisateur qui a créé la demande
  final String userId;
  
  /// Identifiant du service demandé
  final String serviceId;
  
  /// Titre de la demande
  final String title;
  
  /// Description détaillée de la demande
  final String description;
  
  /// Description en arabe
  final String descriptionAr;
  
  /// Description en anglais
  final String descriptionEn;
  
  /// Catégorie du service
  final String serviceCategory;
  
  /// Statut de la demande
  final RequestStatus status;
  
  /// Priorité de la demande
  final RequestPriority priority;
  
  /// Adresse d'intervention
  final RequestAddress address;
  
  /// Date et heure souhaitées
  final DateTime? preferredDateTime;
  
  /// Indicateur si c'est urgent
  final bool isUrgent;
  
  /// Budget estimé (en DA)
  final double? estimatedBudget;
  
  /// Budget maximum (en DA)
  final double? maxBudget;
  
  /// Médias associés (photos, vidéos)
  final List<RequestMedia> media;
  
  /// Statut de candidature du travailleur
  final ApplicationStatus applicationStatus;
  
  /// Date de candidature
  final DateTime? appliedAt;
  
  /// Devis proposé (en DA)
  final double? proposedQuote;
  
  /// Commentaire du devis
  final String? quoteComment;
  
  /// Date de soumission du devis
  final DateTime? quoteSubmittedAt;
  
  /// Date de création
  final DateTime createdAt;
  
  /// Date de dernière modification
  final DateTime updatedAt;
  
  /// Date de clôture
  final DateTime? closedAt;
  
  /// Raison de clôture
  final String? closureReason;
  
  /// Distance depuis la position du travailleur (en km)
  final double? distanceFromWorker;
  
  /// Temps de trajet estimé (en minutes)
  final int? estimatedTravelTime;
  
  /// Indicateur si la demande correspond aux compétences du travailleur
  final bool matchesWorkerSkills;
  
  /// Score de correspondance (0-100)
  final int matchScore;

  /// Constructeur de la classe Request
  const Request({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.title,
    required this.description,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.serviceCategory,
    this.status = RequestStatus.pending,
    this.priority = RequestPriority.normal,
    required this.address,
    this.preferredDateTime,
    this.isUrgent = false,
    this.estimatedBudget,
    this.maxBudget,
    this.media = const [],
    this.applicationStatus = ApplicationStatus.notApplied,
    this.appliedAt,
    this.proposedQuote,
    this.quoteComment,
    this.quoteSubmittedAt,
    required this.createdAt,
    required this.updatedAt,
    this.closedAt,
    this.closureReason,
    this.distanceFromWorker,
    this.estimatedTravelTime,
    this.matchesWorkerSkills = false,
    this.matchScore = 0,
  });

  /// Création d'une demande à partir d'un Map (JSON)
  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'] as String,
      userId: json['userId'] as String,
      serviceId: json['serviceId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      descriptionAr: json['descriptionAr'] as String,
      descriptionEn: json['descriptionEn'] as String,
      serviceCategory: json['serviceCategory'] as String,
      status: RequestStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => RequestStatus.pending,
      ),
      priority: RequestPriority.values.firstWhere(
        (e) => e.toString().split('.').last == json['priority'],
        orElse: () => RequestPriority.normal,
      ),
      address: RequestAddress.fromJson(json['address'] as Map<String, dynamic>),
      preferredDateTime: json['preferredDateTime'] != null 
          ? DateTime.parse(json['preferredDateTime'] as String) 
          : null,
      isUrgent: json['isUrgent'] as bool? ?? false,
      estimatedBudget: json['estimatedBudget'] != null 
          ? (json['estimatedBudget'] as num).toDouble() 
          : null,
      maxBudget: json['maxBudget'] != null 
          ? (json['maxBudget'] as num).toDouble() 
          : null,
      media: json['media'] != null
          ? (json['media'] as List)
              .map((e) => RequestMedia.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      applicationStatus: ApplicationStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['applicationStatus'],
        orElse: () => ApplicationStatus.notApplied,
      ),
      appliedAt: json['appliedAt'] != null 
          ? DateTime.parse(json['appliedAt'] as String) 
          : null,
      proposedQuote: json['proposedQuote'] != null 
          ? (json['proposedQuote'] as num).toDouble() 
          : null,
      quoteComment: json['quoteComment'] as String?,
      quoteSubmittedAt: json['quoteSubmittedAt'] != null 
          ? DateTime.parse(json['quoteSubmittedAt'] as String) 
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      closedAt: json['closedAt'] != null 
          ? DateTime.parse(json['closedAt'] as String) 
          : null,
      closureReason: json['closureReason'] as String?,
      distanceFromWorker: json['distanceFromWorker'] != null 
          ? (json['distanceFromWorker'] as num).toDouble() 
          : null,
      estimatedTravelTime: json['estimatedTravelTime'] as int?,
      matchesWorkerSkills: json['matchesWorkerSkills'] as bool? ?? false,
      matchScore: json['matchScore'] as int? ?? 0,
    );
  }

  /// Conversion de la demande en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'serviceId': serviceId,
      'title': title,
      'description': description,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
      'serviceCategory': serviceCategory,
      'status': status.toString().split('.').last,
      'priority': priority.toString().split('.').last,
      'address': address.toJson(),
      'preferredDateTime': preferredDateTime?.toIso8601String(),
      'isUrgent': isUrgent,
      'estimatedBudget': estimatedBudget,
      'maxBudget': maxBudget,
      'media': media.map((e) => e.toJson()).toList(),
      'applicationStatus': applicationStatus.toString().split('.').last,
      'appliedAt': appliedAt?.toIso8601String(),
      'proposedQuote': proposedQuote,
      'quoteComment': quoteComment,
      'quoteSubmittedAt': quoteSubmittedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'closedAt': closedAt?.toIso8601String(),
      'closureReason': closureReason,
      'distanceFromWorker': distanceFromWorker,
      'estimatedTravelTime': estimatedTravelTime,
      'matchesWorkerSkills': matchesWorkerSkills,
      'matchScore': matchScore,
    };
  }

  /// Création d'une copie de la demande avec modifications
  Request copyWith({
    String? id,
    String? userId,
    String? serviceId,
    String? title,
    String? description,
    String? descriptionAr,
    String? descriptionEn,
    String? serviceCategory,
    RequestStatus? status,
    RequestPriority? priority,
    RequestAddress? address,
    DateTime? preferredDateTime,
    bool? isUrgent,
    double? estimatedBudget,
    double? maxBudget,
    List<RequestMedia>? media,
    ApplicationStatus? applicationStatus,
    DateTime? appliedAt,
    double? proposedQuote,
    String? quoteComment,
    DateTime? quoteSubmittedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? closedAt,
    String? closureReason,
    double? distanceFromWorker,
    int? estimatedTravelTime,
    bool? matchesWorkerSkills,
    int? matchScore,
  }) {
    return Request(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      serviceId: serviceId ?? this.serviceId,
      title: title ?? this.title,
      description: description ?? this.description,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      serviceCategory: serviceCategory ?? this.serviceCategory,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      address: address ?? this.address,
      preferredDateTime: preferredDateTime ?? this.preferredDateTime,
      isUrgent: isUrgent ?? this.isUrgent,
      estimatedBudget: estimatedBudget ?? this.estimatedBudget,
      maxBudget: maxBudget ?? this.maxBudget,
      media: media ?? this.media,
      applicationStatus: applicationStatus ?? this.applicationStatus,
      appliedAt: appliedAt ?? this.appliedAt,
      proposedQuote: proposedQuote ?? this.proposedQuote,
      quoteComment: quoteComment ?? this.quoteComment,
      quoteSubmittedAt: quoteSubmittedAt ?? this.quoteSubmittedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      closedAt: closedAt ?? this.closedAt,
      closureReason: closureReason ?? this.closureReason,
      distanceFromWorker: distanceFromWorker ?? this.distanceFromWorker,
      estimatedTravelTime: estimatedTravelTime ?? this.estimatedTravelTime,
      matchesWorkerSkills: matchesWorkerSkills ?? this.matchesWorkerSkills,
      matchScore: matchScore ?? this.matchScore,
    );
  }

  /// Vérification de l'égalité entre deux demandes
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Request && other.id == id;
  }

  /// Génération du hash code
  @override
  int get hashCode => id.hashCode;

  /// Représentation en string de la demande
  @override
  String toString() {
    return 'Request(id: $id, title: $title, status: $status)';
  }

  /// Vérification si la demande est en attente
  bool get isPending => status == RequestStatus.pending;

  /// Vérification si la demande est en cours
  bool get isInProgress => status == RequestStatus.inProgress;

  /// Vérification si la demande est complétée
  bool get isCompleted => status == RequestStatus.completed;

  /// Vérification si la demande est annulée
  bool get isCancelled => status == RequestStatus.cancelled;

  /// Vérification si la demande est fermée
  bool get isClosed => status == RequestStatus.closed;

  /// Vérification si le travailleur n'a pas encore postulé
  bool get hasNotApplied => applicationStatus == ApplicationStatus.notApplied;

  /// Vérification si le travailleur a postulé
  bool get hasApplied => applicationStatus == ApplicationStatus.applied;

  /// Vérification si le travailleur a soumis un devis
  bool get hasSubmittedQuote => applicationStatus == ApplicationStatus.quoteSubmitted;

  /// Vérification si le travailleur a été sélectionné
  bool get hasBeenSelected => applicationStatus == ApplicationStatus.selected;

  /// Vérification si le travailleur a été rejeté
  bool get hasBeenRejected => applicationStatus == ApplicationStatus.rejected;

  /// Vérification si la demande a des médias
  bool get hasMedia => media.isNotEmpty;

  /// Vérification si la demande a un budget défini
  bool get hasBudget => estimatedBudget != null || maxBudget != null;

  /// Vérification si la demande est urgente
  bool get isHighPriority => priority == RequestPriority.high || isUrgent;

  /// Vérification si la demande correspond aux compétences
  bool get isGoodMatch => matchesWorkerSkills && matchScore >= 70;

  /// Vérification si la demande est proche
  bool get isNearby => distanceFromWorker != null && distanceFromWorker! <= 10.0;

  /// Vérification si la demande est accessible
  bool get isAccessible => distanceFromWorker != null && distanceFromWorker! <= 50.0;

  /// Obtention de la description dans la langue spécifiée
  String getDescriptionByLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
        return descriptionAr;
      case 'en':
        return descriptionEn;
      case 'fr':
      default:
        return description;
    }
  }

  /// Calcul de la durée depuis la création
  Duration get age {
    return DateTime.now().difference(createdAt);
  }

  /// Obtention de l'âge en jours
  int get ageInDays => age.inDays;

  /// Obtention de l'âge en heures
  int get ageInHours => age.inHours;

  /// Vérification si la demande est récente (< 24h)
  bool get isRecent => ageInHours < 24;

  /// Vérification si la demande est ancienne (> 7 jours)
  bool get isOld => ageInDays > 7;

  /// Obtention de la distance formatée
  String? get formattedDistance {
    if (distanceFromWorker == null) return null;
    if (distanceFromWorker! < 1.0) {
      return '${(distanceFromWorker! * 1000).round()} m';
    }
    return '${distanceFromWorker!.toStringAsFixed(1)} km';
  }

  /// Obtention du temps de trajet formaté
  String? get formattedTravelTime {
    if (estimatedTravelTime == null) return null;
    if (estimatedTravelTime! < 60) {
      return '${estimatedTravelTime} min';
    }
    final hours = estimatedTravelTime! ~/ 60;
    final minutes = estimatedTravelTime! % 60;
    if (minutes == 0) {
      return '${hours}h';
    }
    return '${hours}h ${minutes}min';
  }

  /// Obtention du budget formaté
  String? get formattedBudget {
    if (estimatedBudget == null && maxBudget == null) return null;
    if (estimatedBudget != null && maxBudget != null) {
      return '${estimatedBudget!.toStringAsFixed(0)} - ${maxBudget!.toStringAsFixed(0)} DA';
    }
    if (estimatedBudget != null) {
      return '${estimatedBudget!.toStringAsFixed(0)} DA';
    }
    return 'Max ${maxBudget!.toStringAsFixed(0)} DA';
  }

  /// Obtention du score de correspondance en pourcentage
  String get formattedMatchScore => '$matchScore%';

  /// Obtention du niveau de correspondance
  String get matchLevel {
    if (matchScore >= 90) return 'Excellente';
    if (matchScore >= 80) return 'Très bonne';
    if (matchScore >= 70) return 'Bonne';
    if (matchScore >= 50) return 'Moyenne';
    return 'Faible';
  }
}

/// Énumération des statuts de demande
enum RequestStatus {
  pending,      // En attente de candidats
  inProgress,   // En cours de traitement
  completed,    // Terminée avec succès
  cancelled,    // Annulée par l'utilisateur
  closed,       // Fermée (annulée ou terminée)
}

/// Énumération des priorités de demande
enum RequestPriority {
  low,          // Faible priorité
  normal,       // Priorité normale
  high,         // Haute priorité
  urgent,       // Urgente
}

/// Énumération des statuts de candidature
enum ApplicationStatus {
  notApplied,      // Pas encore postulé
  applied,         // Candidature soumise
  quoteSubmitted,  // Devis soumis
  selected,        // Sélectionné
  rejected,        // Rejeté
  withdrawn,       // Retiré
}

/// Classe représentant l'adresse d'intervention
class RequestAddress {
  /// Rue et numéro
  final String street;
  
  /// Code postal
  final String postalCode;
  
  /// Ville
  final String city;
  
  /// Wilaya (province algérienne)
  final String wilaya;
  
  /// Coordonnées GPS (latitude)
  final double latitude;
  
  /// Coordonnées GPS (longitude)
  final double longitude;
  
  /// Informations complémentaires
  final String? additionalInfo;
  
  /// Instructions d'accès
  final String? accessInstructions;

  /// Constructeur de la classe RequestAddress
  const RequestAddress({
    required this.street,
    required this.postalCode,
    required this.city,
    required this.wilaya,
    required this.latitude,
    required this.longitude,
    this.additionalInfo,
    this.accessInstructions,
  });

  /// Création d'une adresse à partir d'un Map (JSON)
  factory RequestAddress.fromJson(Map<String, dynamic> json) {
    return RequestAddress(
      street: json['street'] as String,
      postalCode: json['postalCode'] as String,
      city: json['city'] as String,
      wilaya: json['wilaya'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      additionalInfo: json['additionalInfo'] as String?,
      accessInstructions: json['accessInstructions'] as String?,
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
      'accessInstructions': accessInstructions,
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

  /// Obtention des coordonnées formatées
  String get coordinates => '$latitude, $longitude';
}

/// Classe représentant un média associé à une demande
class RequestMedia {
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
  
  /// Date d'upload
  final DateTime uploadedAt;
  
  /// Description du média
  final String? description;

  /// Constructeur de la classe RequestMedia
  const RequestMedia({
    required this.id,
    required this.type,
    required this.url,
    required this.fileName,
    required this.fileSize,
    required this.mimeType,
    required this.uploadedAt,
    this.description,
  });

  /// Création d'un média à partir d'un Map (JSON)
  factory RequestMedia.fromJson(Map<String, dynamic> json) {
    return RequestMedia(
      id: json['id'] as String,
      type: MediaType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => MediaType.image,
      ),
      url: json['url'] as String,
      fileName: json['fileName'] as String,
      fileSize: json['fileSize'] as int,
      mimeType: json['mimeType'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      description: json['description'] as String?,
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
      'uploadedAt': uploadedAt.toIso8601String(),
      'description': description,
    };
  }

  /// Vérification si c'est une image
  bool get isImage => type == MediaType.image;

  /// Vérification si c'est une vidéo
  bool get isVideo => type == MediaType.video;

  /// Vérification si c'est un document
  bool get isDocument => type == MediaType.document;

  /// Obtention de la taille formatée
  String get formattedSize {
    if (fileSize < 1024) return '${fileSize} B';
    if (fileSize < 1024 * 1024) return '${(fileSize / 1024).toStringAsFixed(1)} KB';
    return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}