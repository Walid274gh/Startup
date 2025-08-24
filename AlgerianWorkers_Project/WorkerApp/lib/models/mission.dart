/// Classe représentant une mission dans l'application Khidmeti-worker (Travailleurs)
/// 
/// Cette classe contient toutes les informations nécessaires pour gérer
/// une mission assignée à un travailleur.
class Mission {
  /// Identifiant unique de la mission
  final String id;
  
  /// Identifiant de la demande associée
  final String requestId;
  
  /// Identifiant du travailleur assigné
  final String workerId;
  
  /// Identifiant de l'utilisateur client
  final String userId;
  
  /// Statut de la mission
  final MissionStatus status;
  
  /// Date de début prévue
  final DateTime? scheduledStartDate;
  
  /// Date de début effective
  final DateTime? actualStartDate;
  
  /// Date de fin prévue
  final DateTime? scheduledEndDate;
  
  /// Date de fin effective
  final DateTime? actualEndDate;
  
  /// Durée estimée en heures
  final double estimatedDuration;
  
  /// Durée effective en heures
  final double? actualDuration;
  
  /// Prix convenu (en DA)
  final double agreedPrice;
  
  /// Prix final facturé (en DA)
  final double? finalPrice;
  
  /// Commission de la plateforme (en DA)
  final double platformCommission;
  
  /// Revenu net du travailleur (en DA)
  final double workerEarnings;
  
  /// Description des travaux effectués
  final String? workDescription;
  
  /// Photos avant travaux
  final List<String> beforePhotos;
  
  /// Photos après travaux
  final List<String> afterPhotos;
  
  /// Photos pendant travaux
  final List<String> duringPhotos;
  
  /// Notes du travailleur
  final String? workerNotes;
  
  /// Notes du client
  final String? clientNotes;
  
  /// Date de création
  final DateTime createdAt;
  
  /// Date de dernière modification
  final DateTime updatedAt;
  
  /// Date d'annulation (si applicable)
  final DateTime? cancelledAt;
  
  /// Raison d'annulation
  final String? cancellationReason;
  
  /// Indicateur si la mission est urgente
  final bool isUrgent;
  
  /// Priorité de la mission
  final MissionPriority priority;

  /// Constructeur de la classe Mission
  const Mission({
    required this.id,
    required this.requestId,
    required this.workerId,
    required this.userId,
    this.status = MissionStatus.assigned,
    this.scheduledStartDate,
    this.actualStartDate,
    this.scheduledEndDate,
    this.actualEndDate,
    required this.estimatedDuration,
    this.actualDuration,
    required this.agreedPrice,
    this.finalPrice,
    required this.platformCommission,
    required this.workerEarnings,
    this.workDescription,
    this.beforePhotos = const [],
    this.afterPhotos = const [],
    this.duringPhotos = const [],
    this.workerNotes,
    this.clientNotes,
    required this.createdAt,
    required this.updatedAt,
    this.cancelledAt,
    this.cancellationReason,
    this.isUrgent = false,
    this.priority = MissionPriority.normal,
  });

  /// Création d'une mission à partir d'un Map (JSON)
  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'] as String,
      requestId: json['requestId'] as String,
      workerId: json['workerId'] as String,
      userId: json['userId'] as String,
      status: MissionStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => MissionStatus.assigned,
      ),
      scheduledStartDate: json['scheduledStartDate'] != null 
          ? DateTime.parse(json['scheduledStartDate'] as String) 
          : null,
      actualStartDate: json['actualStartDate'] != null 
          ? DateTime.parse(json['actualStartDate'] as String) 
          : null,
      scheduledEndDate: json['scheduledEndDate'] != null 
          ? DateTime.parse(json['scheduledEndDate'] as String) 
          : null,
      actualEndDate: json['actualEndDate'] != null 
          ? DateTime.parse(json['actualEndDate'] as String) 
          : null,
      estimatedDuration: (json['estimatedDuration'] as num).toDouble(),
      actualDuration: json['actualDuration'] != null 
          ? (json['actualDuration'] as num).toDouble() 
          : null,
      agreedPrice: (json['agreedPrice'] as num).toDouble(),
      finalPrice: json['finalPrice'] != null 
          ? (json['finalPrice'] as num).toDouble() 
          : null,
      platformCommission: (json['platformCommission'] as num).toDouble(),
      workerEarnings: (json['workerEarnings'] as num).toDouble(),
      workDescription: json['workDescription'] as String?,
      beforePhotos: List<String>.from(json['beforePhotos'] ?? []),
      afterPhotos: List<String>.from(json['afterPhotos'] ?? []),
      duringPhotos: List<String>.from(json['duringPhotos'] ?? []),
      workerNotes: json['workerNotes'] as String?,
      clientNotes: json['clientNotes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      cancelledAt: json['cancelledAt'] != null 
          ? DateTime.parse(json['cancelledAt'] as String) 
          : null,
      cancellationReason: json['cancellationReason'] as String?,
      isUrgent: json['isUrgent'] as bool? ?? false,
      priority: MissionPriority.values.firstWhere(
        (e) => e.toString().split('.').last == json['priority'],
        orElse: () => MissionPriority.normal,
      ),
    );
  }

  /// Conversion de la mission en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requestId': requestId,
      'workerId': workerId,
      'userId': userId,
      'status': status.toString().split('.').last,
      'scheduledStartDate': scheduledStartDate?.toIso8601String(),
      'actualStartDate': actualStartDate?.toIso8601String(),
      'scheduledEndDate': scheduledEndDate?.toIso8601String(),
      'actualEndDate': actualEndDate?.toIso8601String(),
      'estimatedDuration': estimatedDuration,
      'actualDuration': actualDuration,
      'agreedPrice': agreedPrice,
      'finalPrice': finalPrice,
      'platformCommission': platformCommission,
      'workerEarnings': workerEarnings,
      'workDescription': workDescription,
      'beforePhotos': beforePhotos,
      'afterPhotos': afterPhotos,
      'duringPhotos': duringPhotos,
      'workerNotes': workerNotes,
      'clientNotes': clientNotes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'cancelledAt': cancelledAt?.toIso8601String(),
      'cancellationReason': cancellationReason,
      'isUrgent': isUrgent,
      'priority': priority.toString().split('.').last,
    };
  }

  /// Vérification de l'égalité entre deux missions
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Mission && other.id == id;
  }

  /// Génération du hash code
  @override
  int get hashCode => id.hashCode;

  /// Représentation en string de la mission
  @override
  String toString() {
    return 'Mission(id: $id, status: $status, workerId: $workerId)';
  }

  /// Vérification si la mission est assignée
  bool get isAssigned => status == MissionStatus.assigned;

  /// Vérification si la mission est en cours
  bool get isInProgress => status == MissionStatus.inProgress;

  /// Vérification si la mission est complétée
  bool get isCompleted => status == MissionStatus.completed;

  /// Vérification si la mission est annulée
  bool get isCancelled => status == MissionStatus.cancelled;

  /// Vérification si la mission est en retard
  bool get isOverdue => 
      scheduledEndDate != null && 
      DateTime.now().isAfter(scheduledEndDate!) &&
      !isCompleted;

  /// Vérification si la mission a commencé
  bool get hasStarted => actualStartDate != null;

  /// Vérification si la mission a des photos avant
  bool get hasBeforePhotos => beforePhotos.isNotEmpty;

  /// Vérification si la mission a des photos après
  bool get hasAfterPhotos => afterPhotos.isNotEmpty;

  /// Vérification si la mission a des photos pendant
  bool get hasDuringPhotos => duringPhotos.isNotEmpty;

  /// Vérification si la mission a des notes du travailleur
  bool get hasWorkerNotes => workerNotes != null && workerNotes!.isNotEmpty;

  /// Vérification si la mission a des notes du client
  bool get hasClientNotes => clientNotes != null && clientNotes!.isNotEmpty;

  /// Calcul de la durée effective
  double get effectiveDuration => actualDuration ?? estimatedDuration;

  /// Calcul de la différence de durée
  double get durationDifference => effectiveDuration - estimatedDuration;

  /// Vérification si la mission a duré plus longtemps que prévu
  bool get tookLongerThanExpected => durationDifference > 0;

  /// Vérification si la mission a duré moins longtemps que prévu
  bool get tookLessThanExpected => durationDifference < 0;

  /// Obtention du prix final (agréé ou facturé)
  double get finalPriceOrAgreed => finalPrice ?? agreedPrice;

  /// Calcul de la marge bénéficiaire
  double get profitMargin => workerEarnings - platformCommission;

  /// Obtention du pourcentage de commission
  double get commissionPercentage => (platformCommission / agreedPrice) * 100;

  /// Calcul de la durée depuis la création
  Duration get age {
    return DateTime.now().difference(createdAt);
  }

  /// Obtention de l'âge en jours
  int get ageInDays => age.inDays;

  /// Obtention de l'âge en heures
  int get ageInHours => age.inHours;

  /// Vérification si la mission est récente (< 24h)
  bool get isRecent => ageInHours < 24;

  /// Vérification si la mission est ancienne (> 7 jours)
  bool get isOld => ageInDays > 7;

  /// Obtention du nombre total de photos
  int get totalPhotos => beforePhotos.length + afterPhotos.length + duringPhotos.length;

  /// Obtention de la durée formatée
  String get formattedEstimatedDuration {
    if (estimatedDuration < 1.0) {
      return '${(estimatedDuration * 60).round()} min';
    }
    final hours = estimatedDuration.floor();
    final minutes = ((estimatedDuration - hours) * 60).round();
    if (minutes == 0) {
      return '${hours}h';
    }
    return '${hours}h ${minutes}min';
  }

  /// Obtention de la durée effective formatée
  String? get formattedActualDuration {
    if (actualDuration == null) return null;
    if (actualDuration! < 1.0) {
      return '${(actualDuration! * 60).round()} min';
    }
    final hours = actualDuration!.floor();
    final minutes = ((actualDuration! - hours) * 60).round();
    if (minutes == 0) {
      return '${hours}h';
    }
    return '${hours}h ${minutes}min';
  }

  /// Obtention du prix formaté
  String get formattedAgreedPrice => '${agreedPrice.toStringAsFixed(0)} DA';

  /// Obtention du prix final formaté
  String? get formattedFinalPrice {
    if (finalPrice == null) return null;
    return '${finalPrice!.toStringAsFixed(0)} DA';
  }

  /// Obtention des revenus formatés
  String get formattedWorkerEarnings => '${workerEarnings.toStringAsFixed(0)} DA';
}

/// Énumération des statuts de mission
enum MissionStatus {
  assigned,     // Assignée au travailleur
  inProgress,   // En cours d'exécution
  completed,    // Terminée avec succès
  cancelled,    // Annulée
  onHold,       // En attente
}

/// Énumération des priorités de mission
enum MissionPriority {
  low,          // Faible priorité
  normal,       // Priorité normale
  high,         // Haute priorité
  urgent,       // Urgente
}