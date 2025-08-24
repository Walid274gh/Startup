import 'package:flutter/material.dart';

/// Constantes de couleurs pour l'application Khidmeti-worker (Travailleurs)
/// 
/// Cette classe définit la palette de couleurs complète de l'application
/// avec des couleurs primaires, secondaires, d'accent et de statut.
class AppColors {
  // Couleur privée pour éviter l'instanciation
  AppColors._();

  // ===== COULEURS PRIMAIRES =====
  
  /// Couleur primaire principale de l'application
  static const Color primary = Color(0xFF059669);
  
  /// Couleur primaire plus foncée
  static const Color primaryDark = Color(0xFF047857);
  
  /// Couleur primaire plus claire
  static const Color primaryLight = Color(0xFF10B981);
  
  /// Couleur primaire très claire
  static const Color primaryLighter = Color(0xFF34D399);

  // ===== COULEURS D'ACCENT =====
  
  /// Couleur d'accent principale
  static const Color accent = Color(0xFFF59E0B);
  
  /// Couleur d'accent plus foncée
  static const Color accentDark = Color(0xFFD97706);
  
  /// Couleur d'accent plus claire
  static const Color accentLight = Color(0xFFFBBF24);
  
  /// Couleur d'accent très claire
  static const Color accentLighter = Color(0xFFFCD34D);

  // ===== COULEURS DE SUCCÈS =====
  
  /// Couleur de succès
  static const Color success = Color(0xFF10B981);
  
  /// Couleur de succès plus foncée
  static const Color successDark = Color(0xFF059669);
  
  /// Couleur de succès plus claire
  static const Color successLight = Color(0xFF34D399);

  // ===== COULEURS D'ERREUR =====
  
  /// Couleur d'erreur
  static const Color error = Color(0xFFEF4444);
  
  /// Couleur d'erreur plus foncée
  static const Color errorDark = Color(0xFFDC2626);
  
  /// Couleur d'erreur plus claire
  static const Color errorLight = Color(0xFFF87171);

  // ===== COULEURS D'AVERTISSEMENT =====
  
  /// Couleur d'avertissement
  static const Color warning = Color(0xFFF59E0B);
  
  /// Couleur d'avertissement plus foncée
  static const Color warningDark = Color(0xFFD97706);
  
  /// Couleur d'avertissement plus claire
  static const Color warningLight = Color(0xFFFBBF24);

  // ===== COULEURS D'INFO =====
  
  /// Couleur d'information
  static const Color info = Color(0xFF3B82F6);
  
  /// Couleur d'information plus foncée
  static const Color infoDark = Color(0xFF2563EB);
  
  /// Couleur d'information plus claire
  static const Color infoLight = Color(0xFF60A5FA);

  // ===== COULEURS DE TEXTE =====
  
  /// Couleur de texte principale
  static const Color textPrimary = Color(0xFF1F2937);
  
  /// Couleur de texte secondaire
  static const Color textSecondary = Color(0xFF6B7280);
  
  /// Couleur de texte tertiaire
  static const Color textTertiary = Color(0xFF9CA3AF);
  
  /// Couleur de texte inversé (sur fond sombre)
  static const Color textInverse = Color(0xFFFFFFFF);

  // ===== COULEURS DE SURFACE =====
  
  /// Couleur de fond principale
  static const Color background = Color(0xFFF9FAFB);
  
  /// Couleur de surface principale
  static const Color surface = Color(0xFFFFFFFF);
  
  /// Couleur de surface secondaire
  static const Color surfaceSecondary = Color(0xFFF3F4F6);
  
  /// Couleur de surface tertiaire
  static const Color surfaceTertiary = Color(0xFFE5E7EB);

  // ===== COULEURS DE BORDURE =====
  
  /// Couleur de bordure principale
  static const Color border = Color(0xFFE5E7EB);
  
  /// Couleur de bordure secondaire
  static const Color borderSecondary = Color(0xFFD1D5DB);
  
  /// Couleur de bordure tertiaire
  static const Color borderTertiary = Color(0xFF9CA3AF);

  // ===== COULEURS DE STATUT =====
  
  /// Couleur de statut actif
  static const Color statusActive = Color(0xFF10B981);
  
  /// Couleur de statut inactif
  static const Color statusInactive = Color(0xFF6B7280);
  
  /// Couleur de statut en attente
  static const Color statusPending = Color(0xFFF59E0B);
  
  /// Couleur de statut suspendu
  static const Color statusSuspended = Color(0xFFEF4444);

  // ===== COULEURS DE NOTIFICATION =====
  
  /// Couleur de notification d'information
  static const Color notificationInfo = Color(0xFF3B82F6);
  
  /// Couleur de notification de succès
  static const Color notificationSuccess = Color(0xFF10B981);
  
  /// Couleur de notification d'avertissement
  static const Color notificationWarning = Color(0xFFF59E0B);
  
  /// Couleur de notification d'erreur
  static const Color notificationError = Color(0xFFEF4444);

  // ===== COULEURS DE RATING =====
  
  /// Couleur d'étoile pleine
  static const Color starFilled = Color(0xFFF59E0B);
  
  /// Couleur d'étoile vide
  static const Color starEmpty = Color(0xFFE5E7EB);
  
  /// Couleur d'étoile demi-pleine
  static const Color starHalf = Color(0xFFFCD34D);

  // ===== COULEURS DE PRIORITÉ =====
  
  /// Couleur de priorité faible
  static const Color priorityLow = Color(0xFF10B981);
  
  /// Couleur de priorité normale
  static const Color priorityNormal = Color(0xFF3B82F6);
  
  /// Couleur de priorité haute
  static const Color priorityHigh = Color(0xFFF59E0B);
  
  /// Couleur de priorité urgente
  static const Color priorityUrgent = Color(0xFFEF4444);

  // ===== COULEURS DE CATÉGORIE =====
  
  /// Couleur de catégorie construction
  static const Color categoryConstruction = Color(0xFF8B5CF6);
  
  /// Couleur de catégorie réparation
  static const Color categoryRepair = Color(0xFF3B82F6);
  
  /// Couleur de catégorie nettoyage
  static const Color categoryCleaning = Color(0xFF10B981);
  
  /// Couleur de catégorie transport
  static const Color categoryTransport = Color(0xFFF59E0B);
  
  /// Couleur de catégorie éducation
  static const Color categoryEducation = Color(0xFFEC4899);
  
  /// Couleur de catégorie confort
  static const Color categoryComfort = Color(0xFF06B6D4);
  
  /// Couleur de catégorie autre
  static const Color categoryOther = Color(0xFF6B7280);

  // ===== COULEURS DE THÈME =====
  
  /// Couleur de thème clair
  static const Color themeLight = Color(0xFFFFFFFF);
  
  /// Couleur de thème sombre
  static const Color themeDark = Color(0xFF1F2937);
  
  /// Couleur de thème sombre secondaire
  static const Color themeDarkSecondary = Color(0xFF374151);

  // ===== COULEURS DE TRANSPARENCE =====
  
  /// Couleur transparente
  static const Color transparent = Colors.transparent;
  
  /// Couleur noire avec transparence
  static const Color blackTransparent = Color(0x80000000);
  
  /// Couleur blanche avec transparence
  static const Color whiteTransparent = Color(0x80FFFFFF);

  // ===== COULEURS DE DÉGRADÉ =====
  
  /// Dégradé primaire
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );
  
  /// Dégradé d'accent
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, accentDark],
  );
  
  /// Dégradé de succès
  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [success, successDark],
  );
  
  /// Dégradé d'erreur
  static const LinearGradient errorGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [error, errorDark],
  );

  // ===== MÉTHODES UTILITAIRES =====
  
  /// Obtention d'une couleur avec opacité
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
  
  /// Obtention d'une couleur plus claire
  static Color lighter(Color color, double factor) {
    return Color.lerp(color, Colors.white, factor)!;
  }
  
  /// Obtention d'une couleur plus foncée
  static Color darker(Color color, double factor) {
    return Color.lerp(color, Colors.black, factor)!;
  }
  
  /// Vérification si une couleur est claire
  static bool isLight(Color color) {
    return color.computeLuminance() > 0.5;
  }
  
  /// Vérification si une couleur est sombre
  static bool isDark(Color color) {
    return color.computeLuminance() <= 0.5;
  }
  
  /// Obtention de la couleur de texte appropriée pour un fond
  static Color getTextColorForBackground(Color backgroundColor) {
    return isLight(backgroundColor) ? textPrimary : textInverse;
  }
  
  /// Obtention de la couleur de bordure appropriée pour un fond
  static Color getBorderColorForBackground(Color backgroundColor) {
    return isLight(backgroundColor) ? border : borderTertiary;
  }
}