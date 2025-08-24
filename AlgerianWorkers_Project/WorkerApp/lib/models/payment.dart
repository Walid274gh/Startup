/// Classe représentant un paiement dans l'application Khidmeti-worker (Travailleurs)
/// 
/// Cette classe contient toutes les informations nécessaires pour gérer
/// les paiements reçus par les travailleurs pour leurs services.
class Payment {
  /// Identifiant unique du paiement
  final String id;
  
  /// Identifiant de la mission associée
  final String missionId;
  
  /// Identifiant de la facture associée
  final String invoiceId;
  
  /// Identifiant du travailleur
  final String workerId;
  
  /// Identifiant du client
  final String userId;
  
  /// Montant du paiement (en DA)
  final double amount;
  
  /// Devise
  final String currency;
  
  /// Statut du paiement
  final PaymentStatus status;
  
  /// Type de paiement
  final PaymentType type;
  
  /// Méthode de paiement
  final PaymentMethod method;
  
  /// Date de création
  final DateTime createdAt;
  
  /// Date de traitement
  final DateTime? processedAt;
  
  /// Date de confirmation
  final DateTime? confirmedAt;
  
  /// Date d'échec (si applicable)
  final DateTime? failedAt;
  
  /// Date de remboursement (si applicable)
  final DateTime? refundedAt;
  
  /// Référence de transaction
  final String transactionReference;
  
  /// Référence externe (banque, etc.)
  final String? externalReference;
  
  /// Frais de transaction (en DA)
  final double transactionFees;
  
  /// Montant net reçu par le travailleur (en DA)
  final double netAmount;
  
  /// Commission de la plateforme (en DA)
  final double platformCommission;
  
  /// Description du paiement
  final String description;
  
  /// Description en arabe
  final String descriptionAr;
  
  /// Description en anglais
  final String descriptionEn;
  
  /// Métadonnées du paiement
  final Map<String, dynamic>? metadata;
  
  /// Raison de l'échec (si applicable)
  final String? failureReason;
  
  /// Raison du remboursement (si applicable)
  final String? refundReason;
  
  /// Indicateur si le paiement est récurrent
  final bool isRecurring;
  
  /// Période de récurrence (si applicable)
  final String? recurrencePeriod;
  
  /// Tentatives de paiement
  final int paymentAttempts;
  
  /// Dernière tentative
  final DateTime? lastAttemptAt;

  /// Constructeur de la classe Payment
  const Payment({
    required this.id,
    required this.missionId,
    required this.invoiceId,
    required this.workerId,
    required this.userId,
    required this.amount,
    this.currency = 'DA',
    this.status = PaymentStatus.pending,
    this.type = PaymentType.service,
    required this.method,
    required this.createdAt,
    this.processedAt,
    this.confirmedAt,
    this.failedAt,
    this.refundedAt,
    required this.transactionReference,
    this.externalReference,
    this.transactionFees = 0.0,
    this.netAmount = 0.0,
    this.platformCommission = 0.0,
    required this.description,
    required this.descriptionAr,
    required this.descriptionEn,
    this.metadata,
    this.failureReason,
    this.refundReason,
    this.isRecurring = false,
    this.recurrencePeriod,
    this.paymentAttempts = 1,
    this.lastAttemptAt,
  });

  /// Création d'un paiement à partir d'un Map (JSON)
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] as String,
      missionId: json['missionId'] as String,
      invoiceId: json['invoiceId'] as String,
      workerId: json['workerId'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'DA',
      status: PaymentStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => PaymentStatus.pending,
      ),
      type: PaymentType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => PaymentType.service,
      ),
      method: PaymentMethod.values.firstWhere(
        (e) => e.toString().split('.').last == json['method'],
        orElse: () => PaymentMethod.cash,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      processedAt: json['processedAt'] != null 
          ? DateTime.parse(json['processedAt'] as String) 
          : null,
      confirmedAt: json['confirmedAt'] != null 
          ? DateTime.parse(json['confirmedAt'] as String) 
          : null,
      failedAt: json['failedAt'] != null 
          ? DateTime.parse(json['failedAt'] as String) 
          : null,
      refundedAt: json['refundedAt'] != null 
          ? DateTime.parse(json['refundedAt'] as String) 
          : null,
      transactionReference: json['transactionReference'] as String,
      externalReference: json['externalReference'] as String?,
      transactionFees: (json['transactionFees'] as num?)?.toDouble() ?? 0.0,
      netAmount: (json['netAmount'] as num?)?.toDouble() ?? 0.0,
      platformCommission: (json['platformCommission'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String,
      descriptionAr: json['descriptionAr'] as String,
      descriptionEn: json['descriptionEn'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      failureReason: json['failureReason'] as String?,
      refundReason: json['refundReason'] as String?,
      isRecurring: json['isRecurring'] as bool? ?? false,
      recurrencePeriod: json['recurrencePeriod'] as String?,
      paymentAttempts: json['paymentAttempts'] as int? ?? 1,
      lastAttemptAt: json['lastAttemptAt'] != null 
          ? DateTime.parse(json['lastAttemptAt'] as String) 
          : null,
    );
  }

  /// Conversion du paiement en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'missionId': missionId,
      'invoiceId': invoiceId,
      'workerId': workerId,
      'userId': userId,
      'amount': amount,
      'currency': currency,
      'status': status.toString().split('.').last,
      'type': type.toString().split('.').last,
      'method': method.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'processedAt': processedAt?.toIso8601String(),
      'confirmedAt': confirmedAt?.toIso8601String(),
      'failedAt': failedAt?.toIso8601String(),
      'refundedAt': refundedAt?.toIso8601String(),
      'transactionReference': transactionReference,
      'externalReference': externalReference,
      'transactionFees': transactionFees,
      'netAmount': netAmount,
      'platformCommission': platformCommission,
      'description': description,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
      'metadata': metadata,
      'failureReason': failureReason,
      'refundReason': refundReason,
      'isRecurring': isRecurring,
      'recurrencePeriod': recurrencePeriod,
      'paymentAttempts': paymentAttempts,
      'lastAttemptAt': lastAttemptAt?.toIso8601String(),
    };
  }

  /// Vérification de l'égalité entre deux paiements
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Payment && other.id == id;
  }

  /// Génération du hash code
  @override
  int get hashCode => id.hashCode;

  /// Représentation en string du paiement
  @override
  String toString() {
    return 'Payment(id: $id, amount: $amount, status: $status)';
  }

  /// Vérification si le paiement est en attente
  bool get isPending => status == PaymentStatus.pending;

  /// Vérification si le paiement est en cours de traitement
  bool get isProcessing => status == PaymentStatus.processing;

  /// Vérification si le paiement est confirmé
  bool get isConfirmed => status == PaymentStatus.confirmed;

  /// Vérification si le paiement a échoué
  bool get hasFailed => status == PaymentStatus.failed;

  /// Vérification si le paiement a été remboursé
  bool get hasBeenRefunded => status == PaymentStatus.refunded;

  /// Vérification si le paiement est annulé
  bool get isCancelled => status == PaymentStatus.cancelled;

  /// Vérification si le paiement est en attente de confirmation
  bool get isPendingConfirmation => status == PaymentStatus.pendingConfirmation;

  /// Vérification si le paiement a été traité
  bool get hasBeenProcessed => processedAt != null;

  /// Vérification si le paiement a été confirmé
  bool get hasBeenConfirmed => confirmedAt != null;

  /// Vérification si le paiement a échoué
  bool get hasFailed => failedAt != null;

  /// Vérification si le paiement a été remboursé
  bool get hasBeenRefunded => refundedAt != null;

  /// Vérification si c'est un paiement récurrent
  bool get isRecurringPayment => isRecurring;

  /// Vérification si c'est un paiement de service
  bool get isServicePayment => type == PaymentType.service;

  /// Vérification si c'est un paiement d'abonnement
  bool get isSubscriptionPayment => type == PaymentType.subscription;

  /// Vérification si c'est un paiement en espèces
  bool get isCashPayment => method == PaymentMethod.cash;

  /// Vérification si c'est un paiement par carte
  bool get isCardPayment => method == PaymentMethod.card;

  /// Vérification si c'est un paiement mobile
  bool get isMobilePayment => method == PaymentMethod.mobile;

  /// Vérification si c'est un paiement en ligne
  bool get isOnlinePayment => method == PaymentMethod.online;

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

  /// Obtention de l'âge en minutes
  int get ageInMinutes => age.inMinutes;

  /// Obtention de l'âge en heures
  int get ageInHours => age.inHours;

  /// Obtention de l'âge en jours
  int get ageInDays => age.inDays;

  /// Vérification si le paiement est récent (< 1h)
  bool get isRecent => ageInMinutes < 60;

  /// Vérification si le paiement est ancien (> 24h)
  bool get isOld => ageInHours > 24;

  /// Obtention du montant formaté
  String get formattedAmount => '${amount.toStringAsFixed(0)} $currency';

  /// Obtention du montant net formaté
  String get formattedNetAmount => '${netAmount.toStringAsFixed(0)} $currency';

  /// Obtention des frais de transaction formatés
  String get formattedTransactionFees => '${transactionFees.toStringAsFixed(0)} $currency';

  /// Obtention de la commission formatée
  String get formattedPlatformCommission => '${platformCommission.toStringAsFixed(0)} $currency';

  /// Calcul du pourcentage de commission
  double get commissionPercentage {
    if (amount == 0) return 0.0;
    return (platformCommission / amount) * 100;
  }

  /// Obtention du pourcentage de commission formaté
  String get formattedCommissionPercentage => '${commissionPercentage.toStringAsFixed(1)}%';

  /// Calcul du pourcentage de frais
  double get feesPercentage {
    if (amount == 0) return 0.0;
    return (transactionFees / amount) * 100;
  }

  /// Obtention du pourcentage de frais formaté
  String get formattedFeesPercentage => '${feesPercentage.toStringAsFixed(1)}%';

  /// Vérification si le paiement a des frais
  bool get hasFees => transactionFees > 0;

  /// Vérification si le paiement a une commission
  bool get hasCommission => platformCommission > 0;

  /// Obtention du statut en texte
  String get statusText {
    switch (status) {
      case PaymentStatus.pending:
        return 'En attente';
      case PaymentStatus.processing:
        return 'En cours de traitement';
      case PaymentStatus.confirmed:
        return 'Confirmé';
      case PaymentStatus.failed:
        return 'Échoué';
      case PaymentStatus.refunded:
        return 'Remboursé';
      case PaymentStatus.cancelled:
        return 'Annulé';
      case PaymentStatus.pendingConfirmation:
        return 'En attente de confirmation';
    }
  }

  /// Obtention du type en texte
  String get typeText {
    switch (type) {
      case PaymentType.service:
        return 'Service';
      case PaymentType.subscription:
        return 'Abonnement';
      case PaymentType.tip:
        return 'Pourboire';
      case PaymentType.bonus:
        return 'Bonus';
      case PaymentType.refund:
        return 'Remboursement';
    }
  }

  /// Obtention de la méthode en texte
  String get methodText {
    switch (method) {
      case PaymentMethod.cash:
        return 'Espèces';
      case PaymentMethod.card:
        return 'Carte bancaire';
      case PaymentMethod.transfer:
        return 'Virement';
      case PaymentMethod.check:
        return 'Chèque';
      case PaymentMethod.mobile:
        return 'Paiement mobile';
      case PaymentMethod.online:
        return 'Paiement en ligne';
    }
  }

  /// Vérification si le paiement peut être remboursé
  bool get canBeRefunded => 
      isConfirmed && !hasBeenRefunded && !isCancelled;

  /// Vérification si le paiement peut être annulé
  bool get canBeCancelled => 
      isPending || isProcessing || isPendingConfirmation;

  /// Calcul du montant total des frais
  double get totalFees => transactionFees + platformCommission;

  /// Obtention du montant total des frais formaté
  String get formattedTotalFees => '${totalFees.toStringAsFixed(0)} $currency';
}

/// Énumération des statuts de paiement
enum PaymentStatus {
  pending,              // En attente
  processing,           // En cours de traitement
  confirmed,            // Confirmé
  failed,               // Échoué
  refunded,             // Remboursé
  cancelled,            // Annulé
  pendingConfirmation,  // En attente de confirmation
}

/// Énumération des types de paiement
enum PaymentType {
  service,      // Service
  subscription, // Abonnement
  tip,          // Pourboire
  bonus,        // Bonus
  refund,       // Remboursement
}

/// Énumération des méthodes de paiement
enum PaymentMethod {
  cash,         // Espèces
  card,         // Carte bancaire
  transfer,     // Virement
  check,        // Chèque
  mobile,       // Paiement mobile
  online,       // Paiement en ligne
}