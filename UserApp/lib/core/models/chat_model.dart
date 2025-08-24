import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType {
  text,           // Message texte
  image,          // Image
  video,          // Vidéo
  audio,          // Audio
  document,       // Document
  location,       // Localisation
  quote,          // Devis
  payment,        // Paiement
  system          // Message système
}

enum MessageStatus {
  sent,           // Envoyé
  delivered,      // Livré
  read,           // Lu
  failed          // Échec
}

class ChatMessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String senderType; // 'client' ou 'worker'
  final String senderName;
  final String? senderAvatar;
  final MessageType type;
  final String content;
  final Map<String, dynamic>? metadata; // Données supplémentaires selon le type
  final DateTime timestamp;
  final MessageStatus status;
  final bool isEdited;
  final DateTime? editedAt;
  final List<String> readBy; // IDs des utilisateurs qui ont lu le message
  final String? replyToId; // ID du message auquel on répond
  final Map<String, dynamic>? replyData; // Données du message de réponse
  final bool isDeleted;
  final DateTime? deletedAt;
  final String? deletedBy;

  ChatMessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.senderType,
    required this.senderName,
    this.senderAvatar,
    required this.type,
    required this.content,
    this.metadata,
    required this.timestamp,
    required this.status,
    required this.isEdited,
    this.editedAt,
    required this.readBy,
    this.replyToId,
    this.replyData,
    required this.isDeleted,
    this.deletedAt,
    this.deletedBy,
  });

  // Factory constructor pour créer un message depuis Firestore
  factory ChatMessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatMessageModel(
      id: doc.id,
      chatId: data['chatId'] ?? '',
      senderId: data['senderId'] ?? '',
      senderType: data['senderType'] ?? 'client',
      senderName: data['senderName'] ?? '',
      senderAvatar: data['senderAvatar'],
      type: MessageType.values.firstWhere(
        (e) => e.toString().split('.').last == data['type'],
        orElse: () => MessageType.text
      ),
      content: data['content'] ?? '',
      metadata: data['metadata'] != null 
        ? Map<String, dynamic>.from(data['metadata']) 
        : null,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      status: MessageStatus.values.firstWhere(
        (e) => e.toString().split('.').last == data['status'],
        orElse: () => MessageStatus.sent
      ),
      isEdited: data['isEdited'] ?? false,
      editedAt: data['editedAt'] != null 
        ? (data['editedAt'] as Timestamp).toDate() 
        : null,
      readBy: List<String>.from(data['readBy'] ?? []),
      replyToId: data['replyToId'],
      replyData: data['replyData'] != null 
        ? Map<String, dynamic>.from(data['replyData']) 
        : null,
      isDeleted: data['isDeleted'] ?? false,
      deletedAt: data['deletedAt'] != null 
        ? (data['deletedAt'] as Timestamp).toDate() 
        : null,
      deletedBy: data['deletedBy'],
    );
  }

  // Méthode pour convertir le modèle en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'chatId': chatId,
      'senderId': senderId,
      'senderType': senderType,
      'senderName': senderName,
      'senderAvatar': senderAvatar,
      'type': type.toString().split('.').last,
      'content': content,
      'metadata': metadata,
      'timestamp': Timestamp.fromDate(timestamp),
      'status': status.toString().split('.').last,
      'isEdited': isEdited,
      'editedAt': editedAt != null ? Timestamp.fromDate(editedAt!) : null,
      'readBy': readBy,
      'replyToId': replyToId,
      'replyData': replyData,
      'isDeleted': isDeleted,
      'deletedAt': deletedAt != null ? Timestamp.fromDate(deletedAt!) : null,
      'deletedBy': deletedBy,
      'lastUpdated': FieldValue.serverTimestamp(), // Timestamp de synchronisation
    };
  }

  // Méthode pour créer une copie modifiée du modèle
  ChatMessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? senderType,
    String? senderName,
    String? senderAvatar,
    MessageType? type,
    String? content,
    Map<String, dynamic>? metadata,
    DateTime? timestamp,
    MessageStatus? status,
    bool? isEdited,
    DateTime? editedAt,
    List<String>? readBy,
    String? replyToId,
    Map<String, dynamic>? replyData,
    bool? isDeleted,
    DateTime? deletedAt,
    String? deletedBy,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      senderType: senderType ?? this.senderType,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      type: type ?? this.type,
      content: content ?? this.content,
      metadata: metadata ?? this.metadata,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      isEdited: isEdited ?? this.isEdited,
      editedAt: editedAt ?? this.editedAt,
      readBy: readBy ?? this.readBy,
      replyToId: replyToId ?? this.replyToId,
      replyData: replyData ?? this.replyData,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      deletedBy: deletedBy ?? this.deletedBy,
    );
  }

  // Méthodes utilitaires
  bool get isFromClient => senderType == 'client';
  bool get isFromWorker => senderType == 'worker';
  bool get canBeEdited => !isDeleted && type == MessageType.text;
  bool get canBeDeleted => !isDeleted;
  bool get isRead => readBy.isNotEmpty;
  bool get isRepliedTo => replyToId != null && replyToId!.isNotEmpty;

  // Vérification de validité
  bool get isValid => 
    content.isNotEmpty && 
    senderId.isNotEmpty && 
    chatId.isNotEmpty &&
    !isDeleted;

  // Méthode pour obtenir le type de message en français
  String get typeInFrench {
    switch (type) {
      case MessageType.text:
        return 'Texte';
      case MessageType.image:
        return 'Image';
      case MessageType.video:
        return 'Vidéo';
      case MessageType.audio:
        return 'Audio';
      case MessageType.document:
        return 'Document';
      case MessageType.location:
        return 'Localisation';
      case MessageType.quote:
        return 'Devis';
      case MessageType.payment:
        return 'Paiement';
      case MessageType.system:
        return 'Système';
    }
  }

  // Méthode pour obtenir le statut en français
  String get statusInFrench {
    switch (status) {
      case MessageStatus.sent:
        return 'Envoyé';
      case MessageStatus.delivered:
        return 'Livré';
      case MessageStatus.read:
        return 'Lu';
      case MessageStatus.failed:
        return 'Échec';
    }
  }

  // Méthode pour formater l'horodatage
  String get formattedTime {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(timestamp.year, timestamp.month, timestamp.day);
    
    if (messageDate == today) {
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Hier';
    } else {
      return '${timestamp.day.toString().padLeft(2, '0')}/${timestamp.month.toString().padLeft(2, '0')}';
    }
  }
}

class ChatRoomModel {
  final String id;
  final String clientId;
  final String workerId;
  final String? serviceRequestId; // ID de la demande de service associée
  final DateTime createdAt;
  final DateTime lastMessageAt;
  final String lastMessage;
  final String lastMessageSenderId;
  final bool isActive;
  final Map<String, dynamic> metadata; // Données supplémentaires
  final List<String> participants; // IDs des participants
  final Map<String, dynamic> settings; // Paramètres du chat
  final bool isArchived;
  final DateTime? archivedAt;
  final String? archivedBy;

  ChatRoomModel({
    required this.id,
    required this.clientId,
    required this.workerId,
    this.serviceRequestId,
    required this.createdAt,
    required this.lastMessageAt,
    required this.lastMessage,
    required this.lastMessageSenderId,
    required this.isActive,
    required this.metadata,
    required this.participants,
    required this.settings,
    required this.isArchived,
    this.archivedAt,
    this.archivedBy,
  });

  // Factory constructor pour créer une salle de chat depuis Firestore
  factory ChatRoomModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatRoomModel(
      id: doc.id,
      clientId: data['clientId'] ?? '',
      workerId: data['workerId'] ?? '',
      serviceRequestId: data['serviceRequestId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastMessageAt: (data['lastMessageAt'] as Timestamp).toDate(),
      lastMessage: data['lastMessage'] ?? '',
      lastMessageSenderId: data['lastMessageSenderId'] ?? '',
      isActive: data['isActive'] ?? true,
      metadata: Map<String, dynamic>.from(data['metadata'] ?? {}),
      participants: List<String>.from(data['participants'] ?? []),
      settings: Map<String, dynamic>.from(data['settings'] ?? {}),
      isArchived: data['isArchived'] ?? false,
      archivedAt: data['archivedAt'] != null 
        ? (data['archivedAt'] as Timestamp).toDate() 
        : null,
      archivedBy: data['archivedBy'],
    );
  }

  // Méthode pour convertir le modèle en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'clientId': clientId,
      'workerId': workerId,
      'serviceRequestId': serviceRequestId,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastMessageAt': Timestamp.fromDate(lastMessageAt),
      'lastMessage': lastMessage,
      'lastMessageSenderId': lastMessageSenderId,
      'isActive': isActive,
      'metadata': metadata,
      'participants': participants,
      'settings': settings,
      'isArchived': isArchived,
      'archivedAt': archivedAt != null ? Timestamp.fromDate(archivedAt!) : null,
      'archivedBy': archivedBy,
      'lastUpdated': FieldValue.serverTimestamp(), // Timestamp de synchronisation
    };
  }

  // Méthode pour créer une copie modifiée du modèle
  ChatRoomModel copyWith({
    String? id,
    String? clientId,
    String? workerId,
    String? serviceRequestId,
    DateTime? createdAt,
    DateTime? lastMessageAt,
    String? lastMessage,
    String? lastMessageSenderId,
    bool? isActive,
    Map<String, dynamic>? metadata,
    List<String>? participants,
    Map<String, dynamic>? settings,
    bool? isArchived,
    DateTime? archivedAt,
    String? archivedBy,
  }) {
    return ChatRoomModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      workerId: workerId ?? this.workerId,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      createdAt: createdAt ?? this.createdAt,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
      isActive: isActive ?? this.isActive,
      metadata: metadata ?? this.metadata,
      participants: participants ?? this.participants,
      settings: settings ?? this.settings,
      isArchived: isArchived ?? this.isArchived,
      archivedAt: archivedAt ?? this.archivedAt,
      archivedBy: archivedBy ?? this.archivedBy,
    );
  }

  // Méthodes utilitaires
  bool get hasServiceRequest => serviceRequestId != null && serviceRequestId!.isNotEmpty;
  bool get canSendMessages => isActive && !isArchived;
  bool get isRecent => DateTime.now().difference(lastMessageAt).inDays < 7;

  // Vérification de validité
  bool get isValid => 
    clientId.isNotEmpty && 
    workerId.isNotEmpty &&
    participants.length == 2;

  // Méthode pour obtenir le nom de l'autre participant
  String getOtherParticipantName(String currentUserId) {
    if (currentUserId == clientId) {
      return metadata['workerName'] ?? 'Travailleur';
    } else {
      return metadata['clientName'] ?? 'Client';
    }
  }

  // Méthode pour obtenir l'avatar de l'autre participant
  String? getOtherParticipantAvatar(String currentUserId) {
    if (currentUserId == clientId) {
      return metadata['workerAvatar'];
    } else {
      return metadata['clientAvatar'];
    }
  }
}