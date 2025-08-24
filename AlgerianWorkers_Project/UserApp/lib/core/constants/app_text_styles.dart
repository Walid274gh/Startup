import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Constantes de styles de texte pour l'application Khidmeti (Utilisateurs)
/// 
/// Cette classe définit tous les styles de texte de l'application
/// avec une hiérarchie claire et une accessibilité optimale.
class AppTextStyles {
  // Constructeur privé pour éviter l'instanciation
  AppTextStyles._();

  // ===== STYLES DE TITRES =====
  
  /// Style de titre principal (H1)
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );
  
  /// Style de titre secondaire (H2)
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    height: 1.3,
    letterSpacing: -0.3,
    color: AppColors.textPrimary,
  );
  
  /// Style de titre tertiaire (H3)
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: -0.2,
    color: AppColors.textPrimary,
  );

  // ===== STYLES DE TITRES DE SECTIONS =====
  
  /// Style de titre de section principal
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: -0.1,
    color: AppColors.textPrimary,
  );
  
  /// Style de titre de section secondaire
  static const TextStyle titleMedium = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );
  
  /// Style de titre de section tertiaire
  static const TextStyle titleSmall = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );

  // ===== STYLES DE CORPS DE TEXTE =====
  
  /// Style de corps de texte principal
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
    height: 1.6,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );
  
  /// Style de corps de texte standard
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );
  
  /// Style de corps de texte petit
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.textSecondary,
  );

  // ===== STYLES DE LABELS =====
  
  /// Style de label principal
  static const TextStyle labelLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );
  
  /// Style de label standard
  static const TextStyle labelMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );
  
  /// Style de label petit
  static const TextStyle labelSmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.0,
    color: AppColors.textSecondary,
  );

  // ===== STYLES DE BOUTONS =====
  
  /// Style de bouton principal
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.textInverse,
  );
  
  /// Style de bouton standard
  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.textInverse,
  );
  
  /// Style de bouton petit
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.0,
    color: AppColors.textInverse,
  );

  // ===== STYLES DE CAPTIONS =====
  
  /// Style de caption principal
  static const TextStyle captionLarge = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    height: 1.3,
    letterSpacing: 0.0,
    color: AppColors.textSecondary,
  );
  
  /// Style de caption petit
  static const TextStyle captionSmall = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.normal,
    height: 1.2,
    letterSpacing: 0.0,
    color: AppColors.textTertiary,
  );

  // ===== STYLES DE LIENS =====
  
  /// Style de lien principal
  static const TextStyle linkLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );
  
  /// Style de lien standard
  static const TextStyle linkMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );
  
  /// Style de lien petit
  static const TextStyle linkSmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.0,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );

  // ===== STYLES DE STATUT =====
  
  /// Style de statut actif
  static const TextStyle statusActive = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.statusActive,
  );
  
  /// Style de statut inactif
  static const TextStyle statusInactive = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.statusInactive,
  );
  
  /// Style de statut en attente
  static const TextStyle statusPending = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.statusPending,
  );
  
  /// Style de statut suspendu
  static const TextStyle statusSuspended = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.statusSuspended,
  );

  // ===== STYLES DE PRIORITÉ =====
  
  /// Style de priorité faible
  static const TextStyle priorityLow = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.0,
    color: AppColors.priorityLow,
  );
  
  /// Style de priorité normale
  static const TextStyle priorityNormal = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.0,
    color: AppColors.priorityNormal,
  );
  
  /// Style de priorité haute
  static const TextStyle priorityHigh = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.0,
    color: AppColors.priorityHigh,
  );
  
  /// Style de priorité urgente
  static const TextStyle priorityUrgent = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.0,
    color: AppColors.priorityUrgent,
  );

  // ===== STYLES DE NOTIFICATION =====
  
  /// Style de notification d'information
  static const TextStyle notificationInfo = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.notificationInfo,
  );
  
  /// Style de notification de succès
  static const TextStyle notificationSuccess = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.notificationSuccess,
  );
  
  /// Style de notification d'avertissement
  static const TextStyle notificationWarning = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.notificationWarning,
  );
  
  /// Style de notification d'erreur
  static const TextStyle notificationError = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.notificationError,
  );

  // ===== STYLES DE RATING =====
  
  /// Style de note de rating
  static const TextStyle ratingScore = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.starFilled,
  );
  
  /// Style de commentaire de rating
  static const TextStyle ratingComment = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.textSecondary,
    fontStyle: FontStyle.italic,
  );

  // ===== STYLES DE PRIX =====
  
  /// Style de prix principal
  static const TextStyle priceLarge = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    height: 1.4,
    letterSpacing: -0.2,
    color: AppColors.accent,
  );
  
  /// Style de prix standard
  static const TextStyle priceMedium = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.accent,
  );
  
  /// Style de prix petit
  static const TextStyle priceSmall = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.accent,
  );

  // ===== STYLES DE TIMESTAMP =====
  
  /// Style de timestamp principal
  static const TextStyle timestampLarge = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.textTertiary,
  );
  
  /// Style de timestamp petit
  static const TextStyle timestampSmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    height: 1.3,
    letterSpacing: 0.0,
    color: AppColors.textTertiary,
  );

  // ===== STYLES DE CODE =====
  
  /// Style de code inline
  static const TextStyle codeInline = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
    fontFamily: 'monospace',
    backgroundColor: AppColors.surfaceSecondary,
  );
  
  /// Style de bloc de code
  static const TextStyle codeBlock = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
    fontFamily: 'monospace',
    backgroundColor: AppColors.surfaceSecondary,
  );

  // ===== STYLES DE CITATION =====
  
  /// Style de citation
  static const TextStyle quote = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    height: 1.6,
    letterSpacing: 0.0,
    color: AppColors.textSecondary,
    fontStyle: FontStyle.italic,
  );

  // ===== MÉTHODES UTILITAIRES =====
  
  /// Obtention d'un style avec une couleur personnalisée
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }
  
  /// Obtention d'un style avec une taille personnalisée
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }
  
  /// Obtention d'un style avec un poids personnalisé
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
  
  /// Obtention d'un style avec une hauteur de ligne personnalisée
  static TextStyle withHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }
  
  /// Obtention d'un style avec un espacement de lettres personnalisé
  static TextStyle withLetterSpacing(TextStyle style, double spacing) {
    return style.copyWith(letterSpacing: spacing);
  }
  
  /// Obtention d'un style avec une décoration personnalisée
  static TextStyle withDecoration(TextStyle style, TextDecoration decoration) {
    return style.copyWith(decoration: decoration);
  }
  
  /// Obtention d'un style avec une opacité personnalisée
  static TextStyle withOpacity(TextStyle style, double opacity) {
    return style.copyWith(color: style.color?.withOpacity(opacity));
  }
  
  /// Obtention d'un style avec une ombre personnalisée
  static TextStyle withShadow(TextStyle style, List<Shadow> shadows) {
    return style.copyWith(shadows: shadows);
  }
  
  /// Obtention d'un style avec un style de police personnalisé
  static TextStyle withFontStyle(TextStyle style, FontStyle fontStyle) {
    return style.copyWith(fontStyle: fontStyle);
  }
  
  /// Obtention d'un style avec une famille de police personnalisée
  static TextStyle withFontFamily(TextStyle style, String fontFamily) {
    return style.copyWith(fontFamily: fontFamily);
  }
}