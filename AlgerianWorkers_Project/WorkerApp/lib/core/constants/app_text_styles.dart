import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Constantes de styles de texte pour l'application Khidmeti-worker (Travailleurs)
class AppTextStyles {
  AppTextStyles._();

  // ===== STYLES DE TITRES =====
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32.0, fontWeight: FontWeight.bold, height: 1.2, letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28.0, fontWeight: FontWeight.bold, height: 1.3, letterSpacing: -0.3,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24.0, fontWeight: FontWeight.w600, height: 1.4, letterSpacing: -0.2,
    color: AppColors.textPrimary,
  );

  // ===== STYLES DE TITRES DE SECTIONS =====
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22.0, fontWeight: FontWeight.w600, height: 1.4, letterSpacing: -0.1,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.w600, height: 1.4, letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.w600, height: 1.4, letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );

  // ===== STYLES DE CORPS DE TEXTE =====
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.normal, height: 1.6, letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.normal, height: 1.5, letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.normal, height: 1.4, letterSpacing: 0.0,
    color: AppColors.textSecondary,
  );

  // ===== STYLES DE LABELS =====
  static const TextStyle labelLarge = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.w500, height: 1.4, letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w500, height: 1.4, letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.w500, height: 1.3, letterSpacing: 0.0,
    color: AppColors.textSecondary,
  );

  // ===== STYLES DE BOUTONS =====
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.w600, height: 1.4, letterSpacing: 0.0,
    color: AppColors.textInverse,
  );
  
  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w600, height: 1.4, letterSpacing: 0.0,
    color: AppColors.textInverse,
  );
  
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.w600, height: 1.3, letterSpacing: 0.0,
    color: AppColors.textInverse,
  );

  // ===== STYLES DE CAPTIONS =====
  static const TextStyle captionLarge = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.normal, height: 1.3, letterSpacing: 0.0,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle captionSmall = TextStyle(
    fontSize: 10.0, fontWeight: FontWeight.normal, height: 1.2, letterSpacing: 0.0,
    color: AppColors.textTertiary,
  );

  // ===== STYLES DE LIENS =====
  static const TextStyle linkLarge = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.w500, height: 1.4, letterSpacing: 0.0,
    color: AppColors.primary, decoration: TextDecoration.underline,
  );
  
  static const TextStyle linkMedium = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w500, height: 1.4, letterSpacing: 0.0,
    color: AppColors.primary, decoration: TextDecoration.underline,
  );
  
  static const TextStyle linkSmall = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.w500, height: 1.3, letterSpacing: 0.0,
    color: AppColors.primary, decoration: TextDecoration.underline,
  );

  // ===== STYLES DE STATUT =====
  static const TextStyle statusActive = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w500, height: 1.4, letterSpacing: 0.0,
    color: AppColors.statusActive,
  );
  
  static const TextStyle statusInactive = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w500, height: 1.4, letterSpacing: 0.0,
    color: AppColors.statusInactive,
  );
  
  static const TextStyle statusPending = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w500, height: 1.4, letterSpacing: 0.0,
    color: AppColors.statusPending,
  );
  
  static const TextStyle statusSuspended = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w500, height: 1.4, letterSpacing: 0.0,
    color: AppColors.statusSuspended,
  );

  // ===== STYLES DE PRIORITÉ =====
  static const TextStyle priorityLow = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.w500, height: 1.3, letterSpacing: 0.0,
    color: AppColors.priorityLow,
  );
  
  static const TextStyle priorityNormal = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.w500, height: 1.3, letterSpacing: 0.0,
    color: AppColors.priorityNormal,
  );
  
  static const TextStyle priorityHigh = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.w500, height: 1.3, letterSpacing: 0.0,
    color: AppColors.priorityHigh,
  );
  
  static const TextStyle priorityUrgent = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.w600, height: 1.3, letterSpacing: 0.0,
    color: AppColors.priorityUrgent,
  );

  // ===== STYLES DE NOTIFICATION =====
  static const TextStyle notificationInfo = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w500, height: 1.4, letterSpacing: 0.0,
    color: AppColors.notificationInfo,
  );
  
  static const TextStyle notificationSuccess = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w500, height: 1.4, letterSpacing: 0.0,
    color: AppColors.notificationSuccess,
  );
  
  static const TextStyle notificationWarning = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w500, height: 1.4, letterSpacing: 0.0,
    color: AppColors.notificationWarning,
  );
  
  static const TextStyle notificationError = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w500, height: 1.4, letterSpacing: 0.0,
    color: AppColors.notificationError,
  );

  // ===== STYLES DE RATING =====
  static const TextStyle ratingScore = TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.bold, height: 1.4, letterSpacing: 0.0,
    color: AppColors.starFilled,
  );
  
  static const TextStyle ratingComment = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.normal, height: 1.4, letterSpacing: 0.0,
    color: AppColors.textSecondary, fontStyle: FontStyle.italic,
  );

  // ===== STYLES DE PRIX =====
  static const TextStyle priceLarge = TextStyle(
    fontSize: 24.0, fontWeight: FontWeight.bold, height: 1.4, letterSpacing: -0.2,
    color: AppColors.accent,
  );
  
  static const TextStyle priceMedium = TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.w600, height: 1.4, letterSpacing: 0.0,
    color: AppColors.accent,
  );
  
  static const TextStyle priceSmall = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w600, height: 1.4, letterSpacing: 0.0,
    color: AppColors.accent,
  );

  // ===== STYLES DE TIMESTAMP =====
  static const TextStyle timestampLarge = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.normal, height: 1.4, letterSpacing: 0.0,
    color: AppColors.textTertiary,
  );
  
  static const TextStyle timestampSmall = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.normal, height: 1.3, letterSpacing: 0.0,
    color: AppColors.textTertiary,
  );

  // ===== STYLES DE CODE =====
  static const TextStyle codeInline = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.normal, height: 1.4, letterSpacing: 0.0,
    color: AppColors.textPrimary, fontFamily: 'monospace',
    backgroundColor: AppColors.surfaceSecondary,
  );
  
  static const TextStyle codeBlock = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.normal, height: 1.5, letterSpacing: 0.0,
    color: AppColors.textPrimary, fontFamily: 'monospace',
    backgroundColor: AppColors.surfaceSecondary,
  );

  // ===== STYLES DE CITATION =====
  static const TextStyle quote = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.normal, height: 1.6, letterSpacing: 0.0,
    color: AppColors.textSecondary, fontStyle: FontStyle.italic,
  );

  // ===== MÉTHODES UTILITAIRES =====
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }
  
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }
  
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
  
  static TextStyle withOpacity(TextStyle style, double opacity) {
    return style.copyWith(color: style.color?.withOpacity(opacity));
  }
}