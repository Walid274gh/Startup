/// Classe représentant un service disponible dans l'application Khidmeti
/// 
/// Cette classe est partagée entre l'application utilisateur (Khidmeti) 
/// et l'application travailleur (Khidmeti-worker)
/// 
/// Chaque service possède un identifiant unique, un nom, une icône,
/// une description et des métadonnées associées.
class Service {
  /// Identifiant unique du service (ex: 'plumbing', 'electricity')
  final String id;
  
  /// Nom du service en français
  final String name;
  
  /// Nom du service en arabe
  final String nameAr;
  
  /// Nom du service en anglais
  final String nameEn;
  
  /// Icône représentative du service (emoji)
  final String icon;
  
  /// Description détaillée du service
  final String description;
  
  /// Description en arabe
  final String descriptionAr;
  
  /// Description en anglais
  final String descriptionEn;
  
  /// Catégorie principale du service
  final ServiceCategory category;
  
  /// Niveau de complexité du service (1-5)
  final int complexityLevel;
  
  /// Indicateur si le service nécessite des qualifications spéciales
  final bool requiresCertification;
  
  /// Prix moyen estimé en DA (Dinars Algériens)
  final double averagePrice;
  
  /// Indicateur si le service est actuellement disponible
  final bool isActive;
  
  /// Date de création du service dans le système
  final DateTime createdAt;
  
  /// Date de dernière modification
  final DateTime updatedAt;

  /// Constructeur de la classe Service
  const Service({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.nameEn,
    required this.icon,
    required this.description,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.category,
    required this.complexityLevel,
    required this.requiresCertification,
    required this.averagePrice,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Création d'un service à partir d'un Map (JSON)
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      nameEn: json['nameEn'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      descriptionAr: json['descriptionAr'] as String,
      descriptionEn: json['descriptionEn'] as String,
      category: ServiceCategory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
        orElse: () => ServiceCategory.other,
      ),
      complexityLevel: json['complexityLevel'] as int,
      requiresCertification: json['requiresCertification'] as bool,
      averagePrice: (json['averagePrice'] as num).toDouble(),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Conversion du service en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'icon': icon,
      'description': description,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
      'category': category.toString().split('.').last,
      'complexityLevel': complexityLevel,
      'requiresCertification': requiresCertification,
      'averagePrice': averagePrice,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Création d'une copie du service avec modifications
  Service copyWith({
    String? id,
    String? name,
    String? nameAr,
    String? nameEn,
    String? icon,
    String? description,
    String? descriptionAr,
    String? descriptionEn,
    ServiceCategory? category,
    int? complexityLevel,
    bool? requiresCertification,
    double? averagePrice,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      category: category ?? this.category,
      complexityLevel: complexityLevel ?? this.complexityLevel,
      requiresCertification: requiresCertification ?? this.requiresCertification,
      averagePrice: averagePrice ?? this.averagePrice,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Vérification de l'égalité entre deux services
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Service && other.id == id;
  }

  /// Génération du hash code
  @override
  int get hashCode => id.hashCode;

  /// Représentation en string du service
  @override
  String toString() {
    return 'Service(id: $id, name: $name, category: $category)';
  }

  /// Obtention du nom du service dans la langue spécifiée
  String getNameByLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
        return nameAr;
      case 'en':
        return nameEn;
      case 'fr':
      default:
        return name;
    }
  }

  /// Obtention de la description du service dans la langue spécifiée
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

  /// Vérification si le service est complexe (niveau 4-5)
  bool get isComplex => complexityLevel >= 4;

  /// Vérification si le service est simple (niveau 1-2)
  bool get isSimple => complexityLevel <= 2;

  /// Vérification si le service est de niveau intermédiaire (niveau 3)
  bool get isIntermediate => complexityLevel == 3;
}

/// Énumération des catégories de services
enum ServiceCategory {
  /// Services de construction et rénovation
  construction,
  
  /// Services de réparation et maintenance
  repair,
  
  /// Services de nettoyage et entretien
  cleaning,
  
  /// Services de transport et livraison
  transport,
  
  /// Services éducatifs et de garde
  education,
  
  /// Services de confort (climatisation, etc.)
  comfort,
  
  /// Autres services
  other,
}

/// Extension pour ajouter des méthodes utilitaires aux catégories
extension ServiceCategoryExtension on ServiceCategory {
  /// Obtention du nom de la catégorie en français
  String get name {
    switch (this) {
      case ServiceCategory.construction:
        return 'Construction et Rénovation';
      case ServiceCategory.repair:
        return 'Réparation et Maintenance';
      case ServiceCategory.cleaning:
        return 'Nettoyage et Entretien';
      case ServiceCategory.transport:
        return 'Transport et Livraison';
      case ServiceCategory.education:
        return 'Éducation et Garde';
      case ServiceCategory.comfort:
        return 'Confort et Bien-être';
      case ServiceCategory.other:
        return 'Autres Services';
    }
  }

  /// Obtention du nom de la catégorie en arabe
  String get nameAr {
    switch (this) {
      case ServiceCategory.construction:
        return 'البناء والتجديد';
      case ServiceCategory.repair:
        return 'الإصلاح والصيانة';
      case ServiceCategory.cleaning:
        return 'التنظيف والصيانة';
      case ServiceCategory.transport:
        return 'النقل والتوصيل';
      case ServiceCategory.education:
        return 'التعليم والرعاية';
      case ServiceCategory.comfort:
        return 'الراحة والرفاهية';
      case ServiceCategory.other:
        return 'خدمات أخرى';
    }
  }

  /// Obtention du nom de la catégorie en anglais
  String get nameEn {
    switch (this) {
      case ServiceCategory.construction:
        return 'Construction and Renovation';
      case ServiceCategory.repair:
        return 'Repair and Maintenance';
      case ServiceCategory.cleaning:
        return 'Cleaning and Maintenance';
      case ServiceCategory.transport:
        return 'Transport and Delivery';
      case ServiceCategory.education:
        return 'Education and Care';
      case ServiceCategory.comfort:
        return 'Comfort and Well-being';
      case ServiceCategory.other:
        return 'Other Services';
    }
  }

  /// Obtention de l'icône de la catégorie
  String get icon {
    switch (this) {
      case ServiceCategory.construction:
        return '🏗️';
      case ServiceCategory.repair:
        return '🔧';
      case ServiceCategory.cleaning:
        return '🧽';
      case ServiceCategory.transport:
        return '🚚';
      case ServiceCategory.education:
        return '📚';
      case ServiceCategory.comfort:
        return '🏠';
      case ServiceCategory.other:
        return '📋';
    }
  }
}