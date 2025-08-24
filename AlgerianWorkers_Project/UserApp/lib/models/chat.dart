/// Classe représentant une conversation de chat dans l'application Khidmeti (Utilisateurs)
/// 
/// Cette classe contient toutes les informations nécessaires pour gérer
/// la communication entre utilisateurs et travailleurs.
class Chat {
  /// Identifiant unique de la conversation
  final String id;
  
  /// Identifiant de l'utilisateur
  final String userId;
  
  /// Identifiant du travailleur
  final String workerId;
  
  /// Identifiant de la demande associée
  final String requestId;
  
  /// Statut de la conversation
  final ChatStatus status;
  
  /// Date de création de la conversation
  final DateTime createdAt;
  
  /// Date de dernière activité
  final DateTime lastActivityAt;
  
  /// Date de fermeture (si fermée)
  final DateTime? closedAt;
  
  /// Raison de fermeture
  final String? closureReason;
  
  /// Messages de la conversation
  final List<ChatMessage> messages;
  
  /// Indicateur si la conversation est archivée
  final bool isArchived;
  
  /// Indicateur si la conversation est épinglée
  final bool isPinned;
  
  /// Nombre de messages non lus
  final int unreadCount;

  /// Constructeur de la classe Chat
  const Chat({
    required this.id,
    required this.userId,
    required this.workerId,
    required this.requestId,
    this.status = ChatStatus.active,
    required this.createdAt,
    required this.lastActivityAt,
    this.closedAt,
    this.closureReason,
    this.messages = const [],
    this.isArchived = false,
    this.isPinned = false,
    this.unreadCount = 0,
  });

  /// Création d'une conversation à partir d'un Map (JSON)
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'] as String,
      userId: json['userId'] as String,
      workerId: json['workerId'] as String,
      requestId: json['requestId'] as String,
      status: ChatStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => ChatStatus.active,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastActivityAt: DateTime.parse(json['lastActivityAt'] as String),
      closedAt: json['closedAt'] != null 
          ? DateTime.parse(json['closedAt'] as String) 
          : null,
      closureReason: json['closureReason'] as String?,
      messages: json['messages'] != null
          ? (json['messages'] as List)
              .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      isArchived: json['isArchived'] as bool? ?? false,
      isPinned: json['isPinned'] as bool? ?? false,
      unreadCount: json['unreadCount'] as int? ?? 0,
    );
  }

  /// Conversion de la conversation en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'workerId': workerId,
      'requestId': requestId,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'lastActivityAt': lastActivityAt.toIso8601String(),
      'closedAt': closedAt?.toIso8601String(),
      'closureReason': closureReason,
      'messages': messages.map((e) => e.toJson()).toList(),
      'isArchived': isArchived,
      'isPinned': isPinned,
      'unreadCount': unreadCount,
    };
  }

  /// Création d'une copie de la conversation avec modifications
  Chat copyWith({
    String? id,
    String? userId,
    String? workerId,
    String? requestId,
    ChatStatus? status,
    DateTime? createdAt,
    DateTime? lastActivityAt,
    DateTime? closedAt,
    String? closureReason,
    List<ChatMessage>? messages,
    bool? isArchived,
    bool? isPinned,
    int? unreadCount,
  }) {
    return Chat(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workerId: workerId ?? this.workerId,
      requestId: requestId ?? this.requestId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      closedAt: closedAt ?? this.closedAt,
      closureReason: closureReason ?? this.closureReason,
      messages: messages ?? this.messages,
      isArchived: isArchived ?? this.isArchived,
      isPinned: isPinned ?? this.isPinned,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  /// Vérification de l'égalité entre deux conversations
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Chat && other.id == id;
  }

  /// Génération du hash code
  @override
  int get hashCode => id.hashCode;

  /// Représentation en string de la conversation
  @override
  String toString() {
    return 'Chat(id: $id, userId: $userId, workerId: $workerId)';
  }

  /// Vérification si la conversation est active
  bool get isActive => status == ChatStatus.active;

  /// Vérification si la conversation est fermée
  bool get isClosed => status == ChatStatus.closed;

  /// Vérification si la conversation est bloquée
  bool get isBlocked => status == ChatStatus.blocked;

  /// Vérification si la conversation a des messages
  bool get hasMessages => messages.isNotEmpty;

  /// Vérification si la conversation a des messages non lus
  bool get hasUnreadMessages => unreadCount > 0;

  /// Obtention du dernier message
  ChatMessage? get lastMessage => 
      messages.isNotEmpty ? messages.last : null;

  /// Obtention du premier message
  ChatMessage? get firstMessage => 
      messages.isNotEmpty ? messages.first : null;

  /// Calcul de la durée depuis la création
  Duration get age {
    return DateTime.now().difference(createdAt);
  }

  /// Obtention de l'âge en jours
  int get ageInDays => age.inDays;

  /// Obtention de l'âge en heures
  int get ageInHours => age.inHours;

  /// Vérification si la conversation est récente (< 24h)
  bool get isRecent => ageInHours < 24;

  /// Vérification si la conversation est ancienne (> 7 jours)
  bool get isOld => ageInDays > 7;

  /// Obtention du nombre total de messages
  int get totalMessages => messages.length;

  /// Obtention du nombre de messages de l'utilisateur
  int get userMessageCount => 
      messages.where((m) => m.senderId == userId).length;

  /// Obtention du nombre de messages du travailleur
  int get workerMessageCount => 
      messages.where((m) => m.senderId == workerId).length;
}

/// Énumération des statuts de conversation
enum ChatStatus {
  active,     // Conversation active
  closed,     // Conversation fermée
  blocked,    // Conversation bloquée
  archived,   // Conversation archivée
}

/// Classe représentant un message de chat
class ChatMessage {
  /// Identifiant unique du message
  final String id;
  
  /// Identifiant de l'expéditeur
  final String senderId;
  
  /// Type d'expéditeur
  final SenderType senderType;
  
  /// Contenu du message
  final String content;
  
  /// Contenu en arabe
  final String contentAr;
  
  /// Contenu en anglais
  final String contentEn;
  
  /// Type de message
  final MessageType type;
  
  /// Médias associés
  final List<MessageMedia> media;
  
  /// Date d'envoi
  final DateTime sentAt;
  
  /// Date de lecture
  final DateTime? readAt;
  
  /// Date de livraison
  final DateTime? deliveredAt;
  
  /// Statut du message
  final MessageStatus status;
  
  /// Message de réponse (si c'est une réponse)
  final String? replyToMessageId;
  
  /// Métadonnées du message
  final Map<String, dynamic>? metadata;

  /// Constructeur de la classe ChatMessage
  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderType,
    required this.content,
    required this.contentAr,
    required this.contentEn,
    this.type = MessageType.text,
    this.media = const [],
    required this.sentAt,
    this.readAt,
    this.deliveredAt,
    this.status = MessageStatus.sent,
    this.replyToMessageId,
    this.metadata,
  });

  /// Création d'un message à partir d'un Map (JSON)
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      senderType: SenderType.values.firstWhere(
        (e) => e.toString().split('.').last == json['senderType'],
        orElse: () => SenderType.user,
      ),
      content: json['content'] as String,
      contentAr: json['contentAr'] as String,
      contentEn: json['contentEn'] as String,
      type: MessageType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => MessageType.text,
      ),
      media: json['media'] != null
          ? (json['media'] as List)
              .map((e) => MessageMedia.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      sentAt: DateTime.parse(json['sentAt'] as String),
      readAt: json['readAt'] != null 
          ? DateTime.parse(json['readAt'] as String) 
          : null,
      deliveredAt: json['deliveredAt'] != null 
          ? DateTime.parse(json['deliveredAt'] as String) 
          : null,
      status: MessageStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => MessageStatus.sent,
      ),
      replyToMessageId: json['replyToMessageId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Conversion du message en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'senderType': senderType.toString().split('.').last,
      'content': content,
      'contentAr': contentAr,
      'contentEn': contentEn,
      'type': type.toString().split('.').last,
      'media': media.map((e) => e.toJson()).toList(),
      'sentAt': sentAt.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
      'status': status.toString().split('.').last,
      'replyToMessageId': replyToMessageId,
      'metadata': metadata,
    };
  }

  /// Vérification de l'égalité entre deux messages
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatMessage && other.id == id;
  }

  /// Génération du hash code
  @override
  int get hashCode => id.hashCode;

  /// Représentation en string du message
  @override
  String toString() {
    return 'ChatMessage(id: $id, senderId: $senderId, type: $type)';
  }

  /// Vérification si le message est envoyé par l'utilisateur
  bool get isFromUser => senderType == SenderType.user;

  /// Vérification si le message est envoyé par le travailleur
  bool get isFromWorker => senderType == SenderType.worker;

  /// Vérification si le message est de type texte
  bool get isText => type == MessageType.text;

  /// Vérification si le message est de type média
  bool get isMedia => type == MessageType.media;

  /// Vérification si le message est de type système
  bool get isSystem => type == MessageType.system;

  /// Vérification si le message a été lu
  bool get isRead => readAt != null;

  /// Vérification si le message a été livré
  bool get isDelivered => deliveredAt != null;

  /// Vérification si le message est en cours d'envoi
  bool get isSending => status == MessageStatus.sending;

  /// Vérification si le message a échoué
  bool get hasFailed => status == MessageStatus.failed;

  /// Vérification si le message a des médias
  bool get hasMedia => media.isNotEmpty;

  /// Vérification si c'est une réponse
  bool get isReply => replyToMessageId != null;

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

  /// Calcul de la durée depuis l'envoi
  Duration get age {
    return DateTime.now().difference(sentAt);
  }

  /// Obtention de l'âge en minutes
  int get ageInMinutes => age.inMinutes;

  /// Obtention de l'âge en heures
  int get ageInHours => age.inHours;

  /// Vérification si le message est récent (< 1h)
  bool get isRecent => ageInMinutes < 60;

  /// Vérification si le message est ancien (> 24h)
  bool get isOld => ageInHours > 24;
}

/// Énumération des types d'expéditeur
enum SenderType {
  user,       // Utilisateur
  worker,     // Travailleur
  system,     // Système
}

/// Énumération des types de message
enum MessageType {
  text,       // Texte simple
  media,      // Média (image, vidéo, document)
  system,     // Message système
  location,   // Localisation
  quote,      // Devis/estimation
}

/// Énumération des statuts de message
enum MessageStatus {
  sending,    // En cours d'envoi
  sent,       // Envoyé
  delivered,  // Livré
  read,       // Lu
  failed,     // Échec
}

/// Classe représentant un média dans un message
class MessageMedia {
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
  
  /// Aperçu (thumbnail) pour les images/vidéos
  final String? thumbnailUrl;
  
  /// Durée pour les vidéos (en secondes)
  final double? duration;
  
  /// Largeur pour les images/vidéos
  final int? width;
  
  /// Hauteur pour les images/vidéos
  final int? height;

  /// Constructeur de la classe MessageMedia
  const MessageMedia({
    required this.id,
    required this.type,
    required this.url,
    required this.fileName,
    required this.fileSize,
    required this.mimeType,
    this.thumbnailUrl,
    this.duration,
    this.width,
    this.height,
  });

  /// Création d'un média à partir d'un Map (JSON)
  factory MessageMedia.fromJson(Map<String, dynamic> json) {
    return MessageMedia(
      id: json['id'] as String,
      type: MediaType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => MediaType.image,
      ),
      url: json['url'] as String,
      fileName: json['fileName'] as String,
      fileSize: json['fileSize'] as int,
      mimeType: json['mimeType'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      duration: json['duration'] != null 
          ? (json['duration'] as num).toDouble() 
          : null,
      width: json['width'] as int?,
      height: json['height'] as int?,
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
      'thumbnailUrl': thumbnailUrl,
      'duration': duration,
      'width': width,
      'height': height,
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

  /// Obtention de la durée formatée pour les vidéos
  String? get formattedDuration {
    if (duration == null) return null;
    final minutes = (duration! / 60).floor();
    final seconds = (duration! % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Obtention des dimensions formatées
  String? get formattedDimensions {
    if (width == null || height == null) return null;
    return '${width}x$height';
  }
}