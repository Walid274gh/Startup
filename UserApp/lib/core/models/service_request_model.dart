import 'package:cloud_firestore/cloud_firestore.dart';

enum RequestStatus {
  pending,      // En attente de réponse
  accepted,     // Acceptée par un travailleur
  inProgress,   // Travaux en cours
  completed,    // Travaux terminés
  cancelled,    // Annulée
  disputed      // En litige
}

enum RequestPriority {
  low,          // Basse priorité
  normal,       // Priorité normale
  high,         // Haute priorité
  urgent        // Urgente
}

class ServiceRequestModel {
  final String id;
  final String clientId; // ID de l'utilisateur qui fait la demande
  final String? workerId; // ID du travailleur qui accepte (null si pas encore acceptée)
  final String title;
  final String description;
  final List<String> professions; // Métiers requis
  final Map<String, dynamic> requirements; // Exigences spécifiques
  final RequestStatus status;
  final RequestPriority priority;
  final DateTime createdAt;
  final DateTime? deadline; // Date limite souhaitée
  final DateTime? acceptedAt; // Quand la demande a été acceptée
  final DateTime? startedAt; // Quand les travaux ont commencé
  final DateTime? completedAt; // Quand les travaux ont été terminés
  final Map<String, dynamic> location; // Localisation du service
  final double? latitude;
  final double? longitude;
  final String address;
  final String city;
  final String wilaya; // Province algérienne
  final double estimatedBudget; // Budget estimé
  final double? finalPrice; // Prix final négocié
  final List<String> mediaUrls; // Photos/vidéos de la demande
  final Map<String, dynamic> clientPreferences; // Préférences du client
  final bool isUrgent; // Demande urgente
  final int estimatedDuration; // Durée estimée en heures
  final List<String> tags; // Tags pour faciliter la recherche
  final Map<String, dynamic> workerNotes; // Notes du travailleur
  final Map<String, dynamic> clientNotes; // Notes du client
  final double? clientRating; // Note donnée par le client
  final String? clientReview; // Avis du client
  final double? workerRating; // Note donnée par le travailleur
  final String? workerReview; // Avis du travailleur
  final bool isNegotiable; // Le prix est-il négociable
  final List<String> appliedWorkers; // Travailleurs qui ont postulé
  final Map<String, dynamic> paymentInfo; // Informations de paiement
  final String currency; // Devise (DA par défaut)
  final bool isRepeated; // Demande récurrente
  final String? parentRequestId; // ID de la demande parent si récurrente

  ServiceRequestModel({
    required this.id,
    required this.clientId,
    this.workerId,
    required this.title,
    required this.description,
    required this.professions,
    required this.requirements,
    required this.status,
    required this.priority,
    required this.createdAt,
    this.deadline,
    this.acceptedAt,
    this.startedAt,
    this.completedAt,
    required this.location,
    this.latitude,
    this.longitude,
    required this.address,
    required this.city,
    required this.wilaya,
    required this.estimatedBudget,
    this.finalPrice,
    required this.mediaUrls,
    required this.clientPreferences,
    required this.isUrgent,
    required this.estimatedDuration,
    required this.tags,
    required this.workerNotes,
    required this.clientNotes,
    this.clientRating,
    this.clientReview,
    this.workerRating,
    this.workerReview,
    required this.isNegotiable,
    required this.appliedWorkers,
    required this.paymentInfo,
    required this.currency,
    required this.isRepeated,
    this.parentRequestId,
  });

  // Factory constructor pour créer une demande depuis Firestore
  factory ServiceRequestModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ServiceRequestModel(
      id: doc.id,
      clientId: data['clientId'] ?? '',
      workerId: data['workerId'],
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      professions: List<String>.from(data['professions'] ?? []),
      requirements: Map<String, dynamic>.from(data['requirements'] ?? {}),
      status: RequestStatus.values.firstWhere(
        (e) => e.toString().split('.').last == data['status'],
        orElse: () => RequestStatus.pending
      ),
      priority: RequestPriority.values.firstWhere(
        (e) => e.toString().split('.').last == data['priority'],
        orElse: () => RequestPriority.normal
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      deadline: data['deadline'] != null 
        ? (data['deadline'] as Timestamp).toDate() 
        : null,
      acceptedAt: data['acceptedAt'] != null 
        ? (data['acceptedAt'] as Timestamp).toDate() 
        : null,
      startedAt: data['startedAt'] != null 
        ? (data['startedAt'] as Timestamp).toDate() 
        : null,
      completedAt: data['completedAt'] != null 
        ? (data['completedAt'] as Timestamp).toDate() 
        : null,
      location: Map<String, dynamic>.from(data['location'] ?? {}),
      latitude: data['latitude']?.toDouble(),
      longitude: data['longitude']?.toDouble(),
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      wilaya: data['wilaya'] ?? '',
      estimatedBudget: (data['estimatedBudget'] ?? 0.0).toDouble(),
      finalPrice: data['finalPrice']?.toDouble(),
      mediaUrls: List<String>.from(data['mediaUrls'] ?? []),
      clientPreferences: Map<String, dynamic>.from(data['clientPreferences'] ?? {}),
      isUrgent: data['isUrgent'] ?? false,
      estimatedDuration: data['estimatedDuration'] ?? 1,
      tags: List<String>.from(data['tags'] ?? []),
      workerNotes: Map<String, dynamic>.from(data['workerNotes'] ?? {}),
      clientNotes: Map<String, dynamic>.from(data['clientNotes'] ?? {}),
      clientRating: data['clientRating']?.toDouble(),
      clientReview: data['clientReview'],
      workerRating: data['workerRating']?.toDouble(),
      workerReview: data['workerReview'],
      isNegotiable: data['isNegotiable'] ?? true,
      appliedWorkers: List<String>.from(data['appliedWorkers'] ?? []),
      paymentInfo: Map<String, dynamic>.from(data['paymentInfo'] ?? {}),
      currency: data['currency'] ?? 'DA',
      isRepeated: data['isRepeated'] ?? false,
      parentRequestId: data['parentRequestId'],
    );
  }

  // Méthode pour convertir le modèle en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'clientId': clientId,
      'workerId': workerId,
      'title': title,
      'description': description,
      'professions': professions,
      'requirements': requirements,
      'status': status.toString().split('.').last,
      'priority': priority.toString().split('.').last,
      'createdAt': Timestamp.fromDate(createdAt),
      'deadline': deadline != null ? Timestamp.fromDate(deadline!) : null,
      'acceptedAt': acceptedAt != null ? Timestamp.fromDate(acceptedAt!) : null,
      'startedAt': startedAt != null ? Timestamp.fromDate(startedAt!) : null,
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'wilaya': wilaya,
      'estimatedBudget': estimatedBudget,
      'finalPrice': finalPrice,
      'mediaUrls': mediaUrls,
      'clientPreferences': clientPreferences,
      'isUrgent': isUrgent,
      'estimatedDuration': estimatedDuration,
      'tags': tags,
      'workerNotes': workerNotes,
      'clientNotes': clientNotes,
      'clientRating': clientRating,
      'clientReview': clientReview,
      'workerRating': workerRating,
      'workerReview': workerReview,
      'isNegotiable': isNegotiable,
      'appliedWorkers': appliedWorkers,
      'paymentInfo': paymentInfo,
      'currency': currency,
      'isRepeated': isRepeated,
      'parentRequestId': parentRequestId,
      'lastUpdated': FieldValue.serverTimestamp(), // Timestamp de synchronisation
    };
  }

  // Méthode pour créer une copie modifiée du modèle
  ServiceRequestModel copyWith({
    String? id,
    String? clientId,
    String? workerId,
    String? title,
    String? description,
    List<String>? professions,
    Map<String, dynamic>? requirements,
    RequestStatus? status,
    RequestPriority? priority,
    DateTime? createdAt,
    DateTime? deadline,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? completedAt,
    Map<String, dynamic>? location,
    double? latitude,
    double? longitude,
    String? address,
    String? city,
    String? wilaya,
    double? estimatedBudget,
    double? finalPrice,
    List<String>? mediaUrls,
    Map<String, dynamic>? clientPreferences,
    bool? isUrgent,
    int? estimatedDuration,
    List<String>? tags,
    Map<String, dynamic>? workerNotes,
    Map<String, dynamic>? clientNotes,
    double? clientRating,
    String? clientReview,
    double? workerRating,
    String? workerReview,
    bool? isNegotiable,
    List<String>? appliedWorkers,
    Map<String, dynamic>? paymentInfo,
    String? currency,
    bool? isRepeated,
    String? parentRequestId,
  }) {
    return ServiceRequestModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      workerId: workerId ?? this.workerId,
      title: title ?? this.title,
      description: description ?? this.description,
      professions: professions ?? this.professions,
      requirements: requirements ?? this.requirements,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      city: city ?? this.city,
      wilaya: wilaya ?? this.wilaya,
      estimatedBudget: estimatedBudget ?? this.estimatedBudget,
      finalPrice: finalPrice ?? this.finalPrice,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      clientPreferences: clientPreferences ?? this.clientPreferences,
      isUrgent: isUrgent ?? this.isUrgent,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      tags: tags ?? this.tags,
      workerNotes: workerNotes ?? this.workerNotes,
      clientNotes: clientNotes ?? this.clientNotes,
      clientRating: clientRating ?? this.clientRating,
      clientReview: clientReview ?? this.clientReview,
      workerRating: workerRating ?? this.workerRating,
      workerReview: workerReview ?? this.workerReview,
      isNegotiable: isNegotiable ?? this.isNegotiable,
      appliedWorkers: appliedWorkers ?? this.appliedWorkers,
      paymentInfo: paymentInfo ?? this.paymentInfo,
      currency: currency ?? this.currency,
      isRepeated: isRepeated ?? this.isRepeated,
      parentRequestId: parentRequestId ?? this.parentRequestId,
    );
  }

  // Méthodes utilitaires
  bool get isActive => status == RequestStatus.pending || status == RequestStatus.accepted;
  bool get isCompleted => status == RequestStatus.completed;
  bool get isCancelled => status == RequestStatus.cancelled;
  bool get hasWorker => workerId != null && workerId!.isNotEmpty;
  bool get canBeAccepted => status == RequestStatus.pending;
  bool get canBeStarted => status == RequestStatus.accepted;
  bool get canBeCompleted => status == RequestStatus.inProgress;

  // Calcul de la durée depuis la création
  Duration get durationSinceCreation => DateTime.now().difference(createdAt);
  
  // Vérification si la demande est en retard
  bool get isOverdue {
    if (deadline == null) return false;
    return DateTime.now().isAfter(deadline!);
  }

  // Vérification de validité
  bool get isValid => 
    title.isNotEmpty && 
    description.isNotEmpty && 
    professions.isNotEmpty &&
    address.isNotEmpty &&
    city.isNotEmpty &&
    wilaya.isNotEmpty &&
    estimatedBudget > 0;

  // Méthode pour obtenir le statut en français
  String get statusInFrench {
    switch (status) {
      case RequestStatus.pending:
        return 'En attente';
      case RequestStatus.accepted:
        return 'Acceptée';
      case RequestStatus.inProgress:
        return 'En cours';
      case RequestStatus.completed:
        return 'Terminée';
      case RequestStatus.cancelled:
        return 'Annulée';
      case RequestStatus.disputed:
        return 'En litige';
    }
  }

  // Méthode pour obtenir la priorité en français
  String get priorityInFrench {
    switch (priority) {
      case RequestPriority.low:
        return 'Basse';
      case RequestPriority.normal:
        return 'Normale';
      case RequestPriority.high:
        return 'Haute';
      case RequestPriority.urgent:
        return 'Urgente';
    }
  }
}