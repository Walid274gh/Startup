/// Classe représentant une facture dans l'application Khidmeti-worker (Travailleurs)
/// 
/// Cette classe contient toutes les informations nécessaires pour gérer
/// la facturation des services rendus par les travailleurs.
class Invoice {
  /// Identifiant unique de la facture
  final String id;
  
  /// Numéro de facture
  final String invoiceNumber;
  
  /// Identifiant de la mission associée
  final String missionId;
  
  /// Identifiant de la demande associée
  final String requestId;
  
  /// Identifiant du travailleur
  final String workerId;
  
  /// Identifiant du client
  final String userId;
  
  /// Statut de la facture
  final InvoiceStatus status;
  
  /// Type de facture
  final InvoiceType type;
  
  /// Date de création
  final DateTime createdAt;
  
  /// Date d'émission
  final DateTime? issuedAt;
  
  /// Date d'échéance
  final DateTime? dueDate;
  
  /// Date de paiement
  final DateTime? paidAt;
  
  /// Date d'annulation (si applicable)
  final DateTime? cancelledAt;
  
  /// Montant HT (en DA)
  final double amountExcludingTax;
  
  /// Montant de la TVA (en DA)
  final double taxAmount;
  
  /// Montant TTC (en DA)
  final double amountIncludingTax;
  
  /// Montant payé (en DA)
  final double amountPaid;
  
  /// Montant restant à payer (en DA)
  final double remainingAmount;
  
  /// Devise
  final String currency;
  
  /// Taux de TVA (en %)
  final double taxRate;
  
  /// Description des services
  final List<InvoiceItem> items;
  
  /// Notes de la facture
  final String? notes;
  
  /// Notes en arabe
  final String? notesAr;
  
  /// Notes en anglais
  final String? notesEn;
  
  /// Conditions de paiement
  final String? paymentTerms;
  
  /// Méthode de paiement
  final PaymentMethod? paymentMethod;
  
  /// Référence de transaction
  final String? transactionReference;
  
  /// Raison d'annulation
  final String? cancellationReason;
  
  /// PDF de la facture
  final String? pdfUrl;
  
  /// Indicateur si la facture est récurrente
  final bool isRecurring;
  
  /// Période de récurrence (si applicable)
  final String? recurrencePeriod;

  /// Constructeur de la classe Invoice
  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.missionId,
    required this.requestId,
    required this.workerId,
    required this.userId,
    this.status = InvoiceStatus.draft,
    this.type = InvoiceType.service,
    required this.createdAt,
    this.issuedAt,
    this.dueDate,
    this.paidAt,
    this.cancelledAt,
    required this.amountExcludingTax,
    required this.taxAmount,
    required this.amountIncludingTax,
    this.amountPaid = 0.0,
    this.remainingAmount = 0.0,
    this.currency = 'DA',
    this.taxRate = 19.0,
    this.items = const [],
    this.notes,
    this.notesAr,
    this.notesEn,
    this.paymentTerms,
    this.paymentMethod,
    this.transactionReference,
    this.cancellationReason,
    this.pdfUrl,
    this.isRecurring = false,
    this.recurrencePeriod,
  });

  /// Création d'une facture à partir d'un Map (JSON)
  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] as String,
      invoiceNumber: json['invoiceNumber'] as String,
      missionId: json['missionId'] as String,
      requestId: json['requestId'] as String,
      workerId: json['workerId'] as String,
      userId: json['userId'] as String,
      status: InvoiceStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => InvoiceStatus.draft,
      ),
      type: InvoiceType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => InvoiceType.service,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      issuedAt: json['issuedAt'] != null 
          ? DateTime.parse(json['issuedAt'] as String) 
          : null,
      dueDate: json['dueDate'] != null 
          ? DateTime.parse(json['dueDate'] as String) 
          : null,
      paidAt: json['paidAt'] != null 
          ? DateTime.parse(json['paidAt'] as String) 
          : null,
      cancelledAt: json['cancelledAt'] != null 
          ? DateTime.parse(json['cancelledAt'] as String) 
          : null,
      amountExcludingTax: (json['amountExcludingTax'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      amountIncludingTax: (json['amountIncludingTax'] as num).toDouble(),
      amountPaid: (json['amountPaid'] as num?)?.toDouble() ?? 0.0,
      remainingAmount: (json['remainingAmount'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'DA',
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 19.0,
      items: json['items'] != null
          ? (json['items'] as List)
              .map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      notes: json['notes'] as String?,
      notesAr: json['notesAr'] as String?,
      notesEn: json['notesEn'] as String?,
      paymentTerms: json['paymentTerms'] as String?,
      paymentMethod: json['paymentMethod'] != null
          ? PaymentMethod.values.firstWhere(
              (e) => e.toString().split('.').last == json['paymentMethod'],
              orElse: () => PaymentMethod.cash,
            )
          : null,
      transactionReference: json['transactionReference'] as String?,
      cancellationReason: json['cancellationReason'] as String?,
      pdfUrl: json['pdfUrl'] as String?,
      isRecurring: json['isRecurring'] as bool? ?? false,
      recurrencePeriod: json['recurrencePeriod'] as String?,
    );
  }

  /// Conversion de la facture en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceNumber': invoiceNumber,
      'missionId': missionId,
      'requestId': requestId,
      'workerId': workerId,
      'userId': userId,
      'status': status.toString().split('.').last,
      'type': type.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'issuedAt': issuedAt?.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'paidAt': paidAt?.toIso8601String(),
      'cancelledAt': cancelledAt?.toIso8601String(),
      'amountExcludingTax': amountExcludingTax,
      'taxAmount': taxAmount,
      'amountIncludingTax': amountIncludingTax,
      'amountPaid': amountPaid,
      'remainingAmount': remainingAmount,
      'currency': currency,
      'taxRate': taxRate,
      'items': items.map((e) => e.toJson()).toList(),
      'notes': notes,
      'notesAr': notesAr,
      'notesEn': notesEn,
      'paymentTerms': paymentTerms,
      'paymentMethod': paymentMethod?.toString().split('.').last,
      'transactionReference': transactionReference,
      'cancellationReason': cancellationReason,
      'pdfUrl': pdfUrl,
      'isRecurring': isRecurring,
      'recurrencePeriod': recurrencePeriod,
    };
  }

  /// Vérification de l'égalité entre deux factures
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Invoice && other.id == id;
  }

  /// Génération du hash code
  @override
  int get hashCode => id.hashCode;

  /// Représentation en string de la facture
  @override
  String toString() {
    return 'Invoice(id: $id, number: $invoiceNumber, status: $status)';
  }

  /// Vérification si la facture est en brouillon
  bool get isDraft => status == InvoiceStatus.draft;

  /// Vérification si la facture est émise
  bool get isIssued => status == InvoiceStatus.issued;

  /// Vérification si la facture est payée
  bool get isPaid => status == InvoiceStatus.paid;

  /// Vérification si la facture est en retard
  bool get isOverdue => 
      dueDate != null && 
      DateTime.now().isAfter(dueDate!) &&
      !isPaid;

  /// Vérification si la facture est annulée
  bool get isCancelled => status == InvoiceStatus.cancelled;

  /// Vérification si la facture est partiellement payée
  bool get isPartiallyPaid => 
      amountPaid > 0 && amountPaid < amountIncludingTax;

  /// Vérification si la facture est entièrement payée
  bool get isFullyPaid => amountPaid >= amountIncludingTax;

  /// Vérification si la facture a des éléments
  bool get hasItems => items.isNotEmpty;

  /// Vérification si la facture a des notes
  bool get hasNotes => notes != null && notes!.isNotEmpty;

  /// Vérification si la facture a un PDF
  bool get hasPdf => pdfUrl != null && pdfUrl!.isNotEmpty;

  /// Vérification si la facture est récurrente
  bool get isRecurringInvoice => isRecurring;

  /// Calcul de la durée depuis la création
  Duration get age {
    return DateTime.now().difference(createdAt);
  }

  /// Obtention de l'âge en jours
  int get ageInDays => age.inDays;

  /// Obtention de l'âge en heures
  int get ageInHours => age.inHours;

  /// Vérification si la facture est récente (< 24h)
  bool get isRecent => ageInHours < 24;

  /// Vérification si la facture est ancienne (> 30 jours)
  bool get isOld => ageInDays > 30;

  /// Obtention du nombre d'éléments
  int get itemsCount => items.length;

  /// Obtention du montant formaté HT
  String get formattedAmountExcludingTax => '${amountExcludingTax.toStringAsFixed(0)} $currency';

  /// Obtention du montant formaté TVA
  String get formattedTaxAmount => '${taxAmount.toStringAsFixed(0)} $currency';

  /// Obtention du montant formaté TTC
  String get formattedAmountIncludingTax => '${amountIncludingTax.toStringAsFixed(0)} $currency';

  /// Obtention du montant payé formaté
  String get formattedAmountPaid => '${amountPaid.toStringAsFixed(0)} $currency';

  /// Obtention du montant restant formaté
  String get formattedRemainingAmount => '${remainingAmount.toStringAsFixed(0)} $currency';

  /// Obtention du taux de TVA formaté
  String get formattedTaxRate => '${taxRate.toStringAsFixed(1)}%';

  /// Obtention des notes dans la langue spécifiée
  String? getNotesByLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
        return notesAr;
      case 'en':
        return notesEn;
      case 'fr':
      default:
        return notes;
    }
  }

  /// Calcul du pourcentage de paiement
  double get paymentPercentage {
    if (amountIncludingTax == 0) return 0.0;
    return (amountPaid / amountIncludingTax) * 100;
  }

  /// Obtention du pourcentage de paiement formaté
  String get formattedPaymentPercentage => '${paymentPercentage.toStringAsFixed(1)}%';

  /// Vérification si la facture est en retard de paiement
  bool get isPaymentOverdue {
    if (dueDate == null || isPaid) return false;
    return DateTime.now().isAfter(dueDate!);
  }

  /// Obtention du nombre de jours de retard
  int get overdueDays {
    if (dueDate == null || isPaid) return 0;
    return DateTime.now().difference(dueDate!).inDays;
  }
}

/// Énumération des statuts de facture
enum InvoiceStatus {
  draft,      // Brouillon
  issued,     // Émise
  sent,       // Envoyée
  paid,       // Payée
  overdue,    // En retard
  cancelled,  // Annulée
  disputed,   // Contestée
}

/// Énumération des types de facture
enum InvoiceType {
  service,    // Service
  product,    // Produit
  subscription, // Abonnement
  recurring,  // Récurrente
  credit,     // Avoir
}

/// Énumération des méthodes de paiement
enum PaymentMethod {
  cash,       // Espèces
  card,       // Carte bancaire
  transfer,   // Virement
  check,      // Chèque
  mobile,     // Paiement mobile
  online,     // Paiement en ligne
}

/// Classe représentant un élément de facture
class InvoiceItem {
  /// Identifiant unique de l'élément
  final String id;
  
  /// Description de l'élément
  final String description;
  
  /// Description en arabe
  final String descriptionAr;
  
  /// Description en anglais
  final String descriptionEn;
  
  /// Quantité
  final double quantity;
  
  /// Prix unitaire HT (en DA)
  final double unitPrice;
  
  /// Montant HT (en DA)
  final double amountExcludingTax;
  
  /// Taux de TVA (en %)
  final double taxRate;
  
  /// Montant de la TVA (en DA)
  final double taxAmount;
  
  /// Montant TTC (en DA)
  final double amountIncludingTax;
  
  /// Unité de mesure
  final String unit;
  
  /// Notes additionnelles
  final String? notes;

  /// Constructeur de la classe InvoiceItem
  const InvoiceItem({
    required this.id,
    required this.description,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.quantity,
    required this.unitPrice,
    required this.amountExcludingTax,
    required this.taxRate,
    required this.taxAmount,
    required this.amountIncludingTax,
    this.unit = 'unité',
    this.notes,
  });

  /// Création d'un élément à partir d'un Map (JSON)
  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      id: json['id'] as String,
      description: json['description'] as String,
      descriptionAr: json['descriptionAr'] as String,
      descriptionEn: json['descriptionEn'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      amountExcludingTax: (json['amountExcludingTax'] as num).toDouble(),
      taxRate: (json['taxRate'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      amountIncludingTax: (json['amountIncludingTax'] as num).toDouble(),
      unit: json['unit'] as String? ?? 'unité',
      notes: json['notes'] as String?,
    );
  }

  /// Conversion de l'élément en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'amountExcludingTax': amountExcludingTax,
      'taxRate': taxRate,
      'taxAmount': taxAmount,
      'amountIncludingTax': amountIncludingTax,
      'unit': unit,
      'notes': notes,
    };
  }

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

  /// Obtention du prix unitaire formaté
  String get formattedUnitPrice => '${unitPrice.toStringAsFixed(0)} DA';

  /// Obtention du montant HT formaté
  String get formattedAmountExcludingTax => '${amountExcludingTax.toStringAsFixed(0)} DA';

  /// Obtention du montant TVA formaté
  String get formattedTaxAmount => '${taxAmount.toStringAsFixed(0)} DA';

  /// Obtention du montant TTC formaté
  String get formattedAmountIncludingTax => '${amountIncludingTax.toStringAsFixed(0)} DA';

  /// Obtention du taux de TVA formaté
  String get formattedTaxRate => '${taxRate.toStringAsFixed(1)}%';

  /// Obtention de la quantité formatée
  String get formattedQuantity => '${quantity.toStringAsFixed(quantity.truncateToDouble() == quantity ? 0 : 2)} $unit';
}