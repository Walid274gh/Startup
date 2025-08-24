/// Classe représentant une notification professionnelle dans l'application Khidmeti-worker (Travailleurs)
/// 
/// Cette classe contient toutes les informations nécessaires pour gérer
/// les notifications push, SMS et email reçues par les travailleurs.
class Notification {
  /// Identifiant unique de la notification
  final String id;
  
  /// Identifiant du travailleur destinataire
  final String workerId;
  
  /// Type de notification
  final NotificationType type;
  
  /// Titre de la notification
  final String title;
  
  /// Titre en arabe
  final String titleAr;
  
  /// Titre en anglais
  final String titleEn;
  
  /// Contenu de la notification
  final String content;
  
  /// Contenu en arabe
  final String contentAr;
  
  /// Contenu en anglais
  final String contentEn;
  
  /// Données supplémentaires (payload)
  final Map<String, dynamic>? data;
  
  /// Statut de la notification
  final NotificationStatus status;
  
  /// Priorité de la notification
  final NotificationPriority priority;
  
  /// Date de création
  final DateTime createdAt;
  
  /// Date d'envoi
  final DateTime? sentAt;
  
  /// Date de lecture
  final DateTime? readAt;
  
  /// Date d'action (si le travailleur a cliqué)
  final DateTime? actionAt;
  
  /// Date d'expiration
  final DateTime? expiresAt;
  
  /// Canaux de notification utilisés
  final List<NotificationChannel> channels;
  
  /// Tentatives d'envoi
  final int deliveryAttempts;
  
  /// Dernière tentative d'envoi
  final DateTime? lastDeliveryAttempt;
  
  /// Raison de l'échec (si applicable)
  final String? failureReason;
  
  /// Actions disponibles
  final List<NotificationAction> actions;
  
  /// Indicateur si la notification est silencieuse
  final bool isSilent;
  
  /// Indicateur si la notification doit être affichée dans l'historique
  final bool showInHistory;
  
  /// Identifiant de la conversation (si liée à un chat)
  final String? chatId;
  
  /// Identifiant de la demande (si liée à une demande)
  final String? requestId;
  
  /// Identifiant de la mission (si liée à une mission)
  final String? missionId;
  
  /// Identifiant de la facture (si liée à une facture)
  final String? invoiceId;
  
  /// Catégorie professionnelle
  final ProfessionalCategory category;

  /// Constructeur de la classe Notification
  const Notification({
    required this.id,
    required this.workerId,
    required this.type,
    required this.title,
    required this.titleAr,
    required this.content,
    required this.contentAr,
    required this.contentEn,
    this.data,
    this.status = NotificationStatus.pending,
    this.priority = NotificationPriority.normal,
    required this.createdAt,
    this.sentAt,
    this.readAt,
    this.actionAt,
    this.expiresAt,
    this.channels = const [],
    this.deliveryAttempts = 0,
    this.lastDeliveryAttempt,
    this.failureReason,
    this.actions = const [],
    this.isSilent = false,
    this.showInHistory = true,
    this.chatId,
    this.requestId,
    this.missionId,
    this.invoiceId,
    this.category = ProfessionalCategory.general,
  });

  /// Création d'une notification à partir d'un Map (JSON)
  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] as String,
      workerId: json['workerId'] as String,
      type: NotificationType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => NotificationType.general,
      ),
      title: json['title'] as String,
      titleAr: json['titleAr'] as String,
      titleEn: json['titleEn'] as String,
      content: json['content'] as String,
      contentAr: json['contentAr'] as String,
      contentEn: json['contentEn'] as String,
      data: json['data'] as Map<String, dynamic>?,
      status: NotificationStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => NotificationStatus.pending,
      ),
      priority: NotificationPriority.values.firstWhere(
        (e) => e.toString().split('.').last == json['priority'],
        orElse: () => NotificationPriority.normal,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      sentAt: json['sentAt'] != null 
          ? DateTime.parse(json['sentAt'] as String) 
          : null,
      readAt: json['readAt'] != null 
          ? DateTime.parse(json['readAt'] as String) 
          : null,
      actionAt: json['actionAt'] != null 
          ? DateTime.parse(json['actionAt'] as String) 
          : null,
      expiresAt: json['expiresAt'] != null 
          ? DateTime.parse(json['expiresAt'] as String) 
          : null,
      channels: json['channels'] != null
          ? (json['channels'] as List)
              .map((e) => NotificationChannel.values.firstWhere(
                (ch) => ch.toString().split('.').last == e,
                orElse: () => NotificationChannel.push,
              ))
              .toList()
          : [],
      deliveryAttempts: json['deliveryAttempts'] as int? ?? 0,
      lastDeliveryAttempt: json['lastDeliveryAttempt'] != null 
          ? DateTime.parse(json['lastDeliveryAttempt'] as String) 
          : null,
      failureReason: json['failureReason'] as String?,
      actions: json['actions'] != null
          ? (json['actions'] as List)
              .map((e) => NotificationAction.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      isSilent: json['isSilent'] as bool? ?? false,
      showInHistory: json['showInHistory'] as bool? ?? true,
      chatId: json['chatId'] as String?,
      requestId: json['requestId'] as String?,
      missionId: json['missionId'] as String?,
      invoiceId: json['invoiceId'] as String?,
      category: ProfessionalCategory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
        orElse: () => ProfessionalCategory.general,
      ),
    );
  }

  /// Conversion de la notification en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workerId': workerId,
      'type': type.toString().split('.').last,
      'title': title,
      'titleAr': titleAr,
      'titleEn': titleEn,
      'content': content,
      'contentAr': contentAr,
      'contentEn': contentEn,
      'data': data,
      'status': status.toString().split('.').last,
      'priority': priority.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'sentAt': sentAt?.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
      'actionAt': actionAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'channels': channels.map((e) => e.toString().split('.').last).toList(),
      'deliveryAttempts': deliveryAttempts,
      'lastDeliveryAttempt': lastDeliveryAttempt?.toIso8601String(),
      'failureReason': failureReason,
      'actions': actions.map((e) => e.toJson()).toList(),
      'isSilent': isSilent,
      'showInHistory': showInHistory,
      'chatId': chatId,
      'requestId': requestId,
      'missionId': missionId,
      'invoiceId': invoiceId,
      'category': category.toString().split('.').last,
    };
  }

  /// Vérification de l'égalité entre deux notifications
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Notification && other.id == id;
  }

  /// Génération du hash code
  @override
  int get hashCode => id.hashCode;

  /// Représentation en string de la notification
  @override
  String toString() {
    return 'Notification(id: $id, type: $type, title: $title)';
  }

  /// Vérification si la notification est en attente
  bool get isPending => status == NotificationStatus.pending;

  /// Vérification si la notification a été envoyée
  bool get isSent => status == NotificationStatus.sent;

  /// Vérification si la notification a été livrée
  bool get isDelivered => status == NotificationStatus.delivered;

  /// Vérification si la notification a été lue
  bool get isRead => readAt != null;

  /// Vérification si la notification a expiré
  bool get isExpired => 
      expiresAt != null && DateTime.now().isAfter(expiresAt!);

  /// Vérification si la notification a échoué
  bool get hasFailed => status == NotificationStatus.failed;

  /// Vérification si la notification est de haute priorité
  bool get isHighPriority => priority == NotificationPriority.high;

  /// Vérification si la notification est urgente
  bool get isUrgent => priority == NotificationPriority.urgent;

  /// Vérification si la notification a des actions
  bool get hasActions => actions.isNotEmpty;

  /// Vérification si la notification a des canaux
  bool get hasChannels => channels.isNotEmpty;

  /// Vérification si la notification utilise le canal push
  bool get usesPushChannel => channels.contains(NotificationChannel.push);

  /// Vérification si la notification utilise le canal SMS
  bool get usesSmsChannel => channels.contains(NotificationChannel.sms);

  /// Vérification si la notification utilise le canal email
  bool get usesEmailChannel => channels.contains(NotificationChannel.email);

  /// Vérification si la notification est liée à un chat
  bool get isChatRelated => chatId != null;

  /// Vérification si la notification est liée à une demande
  bool get isRequestRelated => requestId != null;

  /// Vérification si la notification est liée à une mission
  bool get isMissionRelated => missionId != null;

  /// Vérification si la notification est liée à une facture
  bool get isInvoiceRelated => invoiceId != null;

  /// Vérification si c'est une notification de nouvelle demande
  bool get isNewRequest => type == NotificationType.newRequest;

  /// Vérification si c'est une notification de mission
  bool get isMissionNotification => type == NotificationType.mission;

  /// Vérification si c'est une notification de paiement
  bool get isPaymentNotification => type == NotificationType.payment;

  /// Vérification si c'est une notification de support
  bool get isSupportNotification => type == NotificationType.support;

  /// Obtention du titre dans la langue spécifiée
  String getTitleByLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
        return titleAr;
      case 'en':
        return titleEn;
      case 'fr':
      default:
        return title;
    }
  }

  /// Obtention du contenu dans la langue spécifiée
  String getContentByLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
        return contentAr;
      case 'en':
        return contentEn;
      case 'fr':
      default:
        return content;
    }
  }

  /// Calcul de la durée depuis la création
  Duration get age {
    return DateTime.now().difference(createdAt);
  }

  /// Obtention de l'âge en minutes
  int get ageInMinutes => age.inMinutes;

  /// Obtention de l'âge en heures
  int get ageInHours => age.inHours;

  /// Obtention de l'âge en jours
  int get ageInDays => age.inDays;

  /// Vérification si la notification est récente (< 1h)
  bool get isRecent => ageInMinutes < 60;

  /// Vérification si la notification est ancienne (> 24h)
  bool get isOld => ageInHours > 24;

  /// Obtention du nombre de tentatives d'envoi
  int get attemptCount => deliveryAttempts;

  /// Obtention du nombre d'actions
  int get actionsCount => actions.length;

  /// Obtention du nombre de canaux
  int get channelsCount => channels.length;
}

/// Énumération des types de notification professionnelle
enum NotificationType {
  general,        // Notification générale
  newRequest,     // Nouvelle demande
  mission,        // Mission assignée/mise à jour
  chat,           // Nouveau message
  payment,        // Paiement reçu
  invoice,        // Facture générée
  support,        // Support client
  system,         // Notification système
  reminder,       // Rappel
  promotion,      // Promotion/offre
}

/// Énumération des statuts de notification
enum NotificationStatus {
  pending,        // En attente d'envoi
  sent,           // Envoyée
  delivered,      // Livrée
  read,           // Lue
  failed,         // Échec
  cancelled,      // Annulée
}

/// Énumération des priorités de notification
enum NotificationPriority {
  low,            // Faible priorité
  normal,         // Priorité normale
  high,           // Haute priorité
  urgent,         // Urgente
}

/// Énumération des canaux de notification
enum NotificationChannel {
  push,           // Notification push
  sms,            // SMS
  email,          // Email
  inApp,          // Dans l'application
}

/// Énumération des catégories professionnelles
enum ProfessionalCategory {
  general,        // Général
  requests,       // Demandes
  missions,       // Missions
  payments,       // Paiements
  support,        // Support
  system,         // Système
}

/// Classe représentant une action de notification
class NotificationAction {
  /// Identifiant de l'action
  final String id;
  
  /// Titre de l'action
  final String title;
  
  /// Titre en arabe
  final String titleAr;
  
  /// Titre en anglais
  final String titleEn;
  
  /// Type d'action
  final ActionType type;
  
  /// URL de l'action (si applicable)
  final String? actionUrl;
  
  /// Données de l'action
  final Map<String, dynamic>? actionData;
  
  /// Indicateur si l'action est destructive
  final bool isDestructive;
  
  /// Indicateur si l'action est par défaut
  final bool isDefault;

  /// Constructeur de la classe NotificationAction
  const NotificationAction({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.titleEn,
    required this.type,
    this.actionUrl,
    this.actionData,
    this.isDestructive = false,
    this.isDefault = false,
  });

  /// Création d'une action à partir d'un Map (JSON)
  factory NotificationAction.fromJson(Map<String, dynamic> json) {
    return NotificationAction(
      id: json['id'] as String,
      title: json['title'] as String,
      titleAr: json['titleAr'] as String,
      titleEn: json['titleEn'] as String,
      type: ActionType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => ActionType.open,
      ),
      actionUrl: json['actionUrl'] as String?,
      actionData: json['actionData'] as Map<String, dynamic>?,
      isDestructive: json['isDestructive'] as bool? ?? false,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  /// Conversion de l'action en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'titleAr': titleAr,
      'titleEn': titleEn,
      'type': type.toString().split('.').last,
      'actionUrl': actionUrl,
      'actionData': actionData,
      'isDestructive': isDestructive,
      'isDefault': isDefault,
    };
  }

  /// Obtention du titre dans la langue spécifiée
  String getTitleByLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
        return titleAr;
      case 'en':
        return titleEn;
      case 'fr':
      default:
        return title;
    }
  }

  /// Vérification si l'action est de type ouverture
  bool get isOpenAction => type == ActionType.open;

  /// Vérification si l'action est de type réponse
  bool get isReplyAction => type == ActionType.reply;

  /// Vérification si l'action est de type suppression
  bool get isDismissAction => type == ActionType.dismiss;

  /// Vérification si l'action est de type accepter
  bool get isAcceptAction => type == ActionType.accept;

  /// Vérification si l'action est de type refuser
  bool get isDeclineAction => type == ActionType.decline;

  /// Vérification si l'action a une URL
  bool get hasUrl => actionUrl != null && actionUrl!.isNotEmpty;

  /// Vérification si l'action a des données
  bool get hasData => actionData != null && actionData!.isNotEmpty;
}

/// Énumération des types d'action
enum ActionType {
  open,           // Ouvrir l'application/écran
  reply,          // Répondre
  dismiss,        // Fermer/ignorer
  view,           // Voir les détails
  accept,         // Accepter
  decline,        // Refuser
  custom,         // Action personnalisée
}