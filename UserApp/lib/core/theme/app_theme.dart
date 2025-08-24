import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';

class AppTheme {
  // Thème clair
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppConstants.primaryColor,
        secondary: AppConstants.secondaryColor,
        tertiary: AppConstants.accentColor,
        surface: AppConstants.surfaceColor,
        background: AppConstants.backgroundColor,
        error: AppConstants.errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onTertiary: Colors.white,
        onSurface: Colors.black87,
        onBackground: Colors.black87,
        onError: Colors.white,
      ),
      
      // Configuration des couleurs personnalisées
      extensions: [
        CustomColors.light,
      ],
      
      // Configuration des composants
      appBarTheme: _buildAppBarTheme(),
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(),
      cardTheme: _buildCardTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(),
      textButtonTheme: _buildTextButtonTheme(),
      inputDecorationTheme: _buildInputDecorationTheme(),
      textTheme: _buildTextTheme(),
      iconTheme: _buildIconTheme(),
      dividerTheme: _buildDividerTheme(),
      chipTheme: _buildChipTheme(),
      floatingActionButtonTheme: _buildFloatingActionButtonTheme(),
      snackBarTheme: _buildSnackBarTheme(),
      dialogTheme: _buildDialogTheme(),
      bottomSheetTheme: _buildBottomSheetTheme(),
      tabBarTheme: _buildTabBarTheme(),
      switchTheme: _buildSwitchTheme(),
      checkboxTheme: _buildCheckboxTheme(),
      radioTheme: _buildRadioTheme(),
      sliderTheme: _buildSliderTheme(),
      progressIndicatorTheme: _buildProgressIndicatorTheme(),
      listTileTheme: _buildListTileTheme(),
      expansionTileTheme: _buildExpansionTileTheme(),
      dataTableTheme: _buildDataTableTheme(),
      tooltipTheme: _buildTooltipTheme(),
      pageTransitionsTheme: _buildPageTransitionsTheme(),
    );
  }

  // Thème sombre
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppConstants.primaryColor,
        secondary: AppConstants.secondaryColor,
        tertiary: AppConstants.accentColor,
        surface: Color(0xFF1E1E1E),
        background: Color(0xFF121212),
        error: AppConstants.errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onTertiary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.white,
      ),
      
      // Configuration des couleurs personnalisées
      extensions: [
        CustomColors.dark,
      ],
      
      // Configuration des composants
      appBarTheme: _buildAppBarTheme(isDark: true),
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(isDark: true),
      cardTheme: _buildCardTheme(isDark: true),
      elevatedButtonTheme: _buildElevatedButtonTheme(isDark: true),
      outlinedButtonTheme: _buildOutlinedButtonTheme(isDark: true),
      textButtonTheme: _buildTextButtonTheme(isDark: true),
      inputDecorationTheme: _buildInputDecorationTheme(isDark: true),
      textTheme: _buildTextTheme(isDark: true),
      iconTheme: _buildIconTheme(isDark: true),
      dividerTheme: _buildDividerTheme(isDark: true),
      chipTheme: _buildChipTheme(isDark: true),
      floatingActionButtonTheme: _buildFloatingActionButtonTheme(isDark: true),
      snackBarTheme: _buildSnackBarTheme(isDark: true),
      dialogTheme: _buildDialogTheme(isDark: true),
      bottomSheetTheme: _buildBottomSheetTheme(isDark: true),
      tabBarTheme: _buildTabBarTheme(isDark: true),
      switchTheme: _buildSwitchTheme(isDark: true),
      checkboxTheme: _buildCheckboxTheme(isDark: true),
      radioTheme: _buildRadioTheme(isDark: true),
      sliderTheme: _buildSliderTheme(isDark: true),
      progressIndicatorTheme: _buildProgressIndicatorTheme(isDark: true),
      listTileTheme: _buildListTileTheme(isDark: true),
      expansionTileTheme: _buildExpansionTileTheme(isDark: true),
      dataTableTheme: _buildDataTableTheme(isDark: true),
      tooltipTheme: _buildTooltipTheme(isDark: true),
      pageTransitionsTheme: _buildPageTransitionsTheme(),
    );
  }

  // Configuration de la barre d'application
  static AppBarTheme _buildAppBarTheme({bool isDark = false}) {
    return AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: isDark ? Colors.white : Colors.black87,
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : Colors.black87,
        fontFamily: 'Poppins',
      ),
      centerTitle: true,
      systemOverlayStyle: null,
    );
  }

  // Configuration de la barre de navigation inférieure
  static BottomNavigationBarTheme _buildBottomNavigationBarTheme({bool isDark = false}) {
    return BottomNavigationBarTheme(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      selectedItemColor: AppConstants.primaryColor,
      unselectedItemColor: isDark ? Colors.grey[400] : Colors.grey[600],
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );
  }

  // Configuration des cartes
  static CardTheme _buildCardTheme({bool isDark = false}) {
    return CardTheme(
      elevation: isDark ? 2 : 4,
      shadowColor: isDark ? Colors.black : Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
      ),
      color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
      margin: EdgeInsets.all(AppConstants.defaultMargin / 2),
    );
  }

  // Configuration des boutons élevés
  static ElevatedButtonTheme _buildElevatedButtonTheme({bool isDark = false}) {
    return ElevatedButtonTheme(
      data: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: AppConstants.defaultElevation,
          shadowColor: AppConstants.primaryColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  // Configuration des boutons avec contour
  static OutlinedButtonTheme _buildOutlinedButtonTheme({bool isDark = false}) {
    return OutlinedButtonTheme(
      data: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: AppConstants.primaryColor,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  // Configuration des boutons texte
  static TextButtonTheme _buildTextButtonTheme({bool isDark = false}) {
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConstants.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  // Configuration des champs de saisie
  static InputDecorationTheme _buildInputDecorationTheme({bool isDark = false}) {
    return InputDecorationTheme(
      filled: true,
      fillColor: isDark ? const Color(0xFF2A2A2A) : Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        borderSide: BorderSide(
          color: isDark ? Colors.grey[600] : Colors.grey[300],
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        borderSide: BorderSide(
          color: AppConstants.primaryColor,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        borderSide: BorderSide(
          color: AppConstants.errorColor,
          width: 2,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      labelStyle: TextStyle(
        fontSize: 16.sp,
        color: isDark ? Colors.grey[400] : Colors.grey[600],
        fontFamily: 'Poppins',
      ),
      hintStyle: TextStyle(
        fontSize: 16.sp,
        color: isDark ? Colors.grey[500] : Colors.grey[400],
        fontFamily: 'Poppins',
      ),
    );
  }

  // Configuration du texte
  static TextTheme _buildTextTheme({bool isDark = false}) {
    final baseTextColor = isDark ? Colors.white : Colors.black87;
    
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      headlineLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      titleSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: baseTextColor,
        fontFamily: 'Poppins',
      ),
    );
  }

  // Configuration des icônes
  static IconTheme _buildIconTheme({bool isDark = false}) {
    return IconTheme(
      data: IconThemeData(
        color: isDark ? Colors.white : Colors.black87,
        size: 24.sp,
      ),
    );
  }

  // Configuration des séparateurs
  static DividerTheme _buildDividerTheme({bool isDark = false}) {
    return DividerTheme(
      data: DividerThemeData(
        color: isDark ? Colors.grey[700] : Colors.grey[300],
        thickness: 1,
        space: AppConstants.defaultMargin,
      ),
    );
  }

  // Configuration des puces
  static ChipTheme _buildChipTheme({bool isDark = false}) {
    return ChipTheme(
      data: ChipThemeData(
        backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.grey[100],
        selectedColor: AppConstants.primaryColor.withOpacity(0.2),
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      ),
    );
  }

  // Configuration du bouton d'action flottant
  static FloatingActionButtonTheme _buildFloatingActionButtonTheme({bool isDark = false}) {
    return FloatingActionButtonTheme(
      data: FloatingActionButtonThemeData(
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        elevation: AppConstants.defaultElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
      ),
    );
  }

  // Configuration des barres de snack
  static SnackBarTheme _buildSnackBarTheme({bool isDark = false}) {
    return SnackBarTheme(
      data: SnackBarThemeData(
        backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        contentTextStyle: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Poppins',
          color: isDark ? Colors.white : Colors.black87,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        elevation: AppConstants.defaultElevation,
      ),
    );
  }

  // Configuration des dialogues
  static DialogTheme _buildDialogTheme({bool isDark = false}) {
    return DialogTheme(
      backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
      elevation: AppConstants.defaultElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
      ),
      titleTextStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
        color: isDark ? Colors.white : Colors.black87,
      ),
      contentTextStyle: TextStyle(
        fontSize: 14.sp,
        fontFamily: 'Poppins',
        color: isDark ? Colors.white : Colors.black87,
      ),
    );
  }

  // Configuration des feuilles inférieures
  static BottomSheetTheme _buildBottomSheetTheme({bool isDark = false}) {
    return BottomSheetTheme(
      data: BottomSheetThemeData(
        backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        elevation: AppConstants.defaultElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.defaultRadius),
          ),
        ),
      ),
    );
  }

  // Configuration des barres d'onglets
  static TabBarTheme _buildTabBarTheme({bool isDark = false}) {
    return TabBarTheme(
      labelColor: AppConstants.primaryColor,
      unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: AppConstants.primaryColor,
          width: 3,
        ),
      ),
    );
  }

  // Configuration des commutateurs
  static SwitchTheme _buildSwitchTheme({bool isDark = false}) {
    return SwitchTheme(
      data: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppConstants.primaryColor;
          }
          return isDark ? Colors.grey[400] : Colors.grey[300];
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppConstants.primaryColor.withOpacity(0.5);
          }
          return isDark ? Colors.grey[600] : Colors.grey[400];
        }),
      ),
    );
  }

  // Configuration des cases à cocher
  static CheckboxTheme _buildCheckboxTheme({bool isDark = false}) {
    return CheckboxTheme(
      data: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppConstants.primaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: Colors.white,
        side: BorderSide(
          color: isDark ? Colors.grey[400] : Colors.grey[600],
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  // Configuration des boutons radio
  static RadioTheme _buildRadioTheme({bool isDark = false}) {
    return RadioTheme(
      data: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppConstants.primaryColor;
          }
          return isDark ? Colors.grey[400] : Colors.grey[600];
        }),
      ),
    );
  }

  // Configuration des curseurs
  static SliderTheme _buildSliderTheme({bool isDark = false}) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: AppConstants.primaryColor,
        inactiveTrackColor: isDark ? Colors.grey[600] : Colors.grey[300],
        thumbColor: AppConstants.primaryColor,
        overlayColor: AppConstants.primaryColor.withOpacity(0.2),
        valueIndicatorColor: AppConstants.primaryColor,
        valueIndicatorTextStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          color: Colors.white,
        ),
      ),
    );
  }

  // Configuration des indicateurs de progression
  static ProgressIndicatorTheme _buildProgressIndicatorTheme({bool isDark = false}) {
    return ProgressIndicatorTheme(
      data: ProgressIndicatorThemeData(
        color: AppConstants.primaryColor,
        linearTrackColor: isDark ? Colors.grey[600] : Colors.grey[300],
        circularTrackColor: isDark ? Colors.grey[600] : Colors.grey[300],
      ),
    );
  }

  // Configuration des tuiles de liste
  static ListTileTheme _buildListTileTheme({bool isDark = false}) {
    return ListTileTheme(
      data: ListTileThemeData(
        tileColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        selectedTileColor: AppConstants.primaryColor.withOpacity(0.1),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: AppConstants.defaultPadding / 2,
        ),
        titleTextStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          color: isDark ? Colors.white : Colors.black87,
        ),
        subtitleTextStyle: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Poppins',
          color: isDark ? Colors.grey[400] : Colors.grey[600],
        ),
        leadingAndTrailingTextStyle: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Poppins',
          color: isDark ? Colors.grey[400] : Colors.grey[600],
        ),
      ),
    );
  }

  // Configuration des tuiles d'expansion
  static ExpansionTileTheme _buildExpansionTileTheme({bool isDark = false}) {
    return ExpansionTileTheme(
      data: ExpansionTileThemeData(
        backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        collapsedBackgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        textColor: isDark ? Colors.white : Colors.black87,
        collapsedTextColor: isDark ? Colors.grey[400] : Colors.grey[600],
        iconColor: AppConstants.primaryColor,
        collapsedIconColor: isDark ? Colors.grey[400] : Colors.grey[600],
      ),
    );
  }

  // Configuration des tableaux de données
  static DataTableTheme _buildDataTableTheme({bool isDark = false}) {
    return DataTableTheme(
      data: DataTableThemeData(
        backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        headingTextStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          color: isDark ? Colors.white : Colors.black87,
        ),
        dataTextStyle: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Poppins',
          color: isDark ? Colors.white : Colors.black87,
        ),
        dividerThickness: 1,
        dataRowColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppConstants.primaryColor.withOpacity(0.1);
          }
          return Colors.transparent;
        }),
      ),
    );
  }

  // Configuration des infobulles
  static TooltipTheme _buildTooltipTheme({bool isDark = false}) {
    return TooltipTheme(
      data: TooltipThemeData(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : Colors.black87,
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        textStyle: TextStyle(
          fontSize: 12.sp,
          fontFamily: 'Poppins',
          color: Colors.white,
        ),
        waitDuration: const Duration(milliseconds: 500),
        showDuration: const Duration(seconds: 3),
      ),
    );
  }

  // Configuration des transitions de page
  static PageTransitionsTheme _buildPageTransitionsTheme() {
    return const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      },
    );
  }
}

// Couleurs personnalisées
class CustomColors extends ThemeExtension<CustomColors> {
  final Color glassmorphism;
  final Color glassmorphismBorder;
  final Color gradientStart;
  final Color gradientEnd;
  final Color successLight;
  final Color warningLight;
  final Color errorLight;
  final Color infoLight;

  const CustomColors({
    required this.glassmorphism,
    required this.glassmorphismBorder,
    required this.gradientStart,
    required this.gradientEnd,
    required this.successLight,
    required this.warningLight,
    required this.errorLight,
    required this.infoLight,
  });

  // Couleurs claires
  static const light = CustomColors(
    glassmorphism: Color(0x80FFFFFF),
    glassmorphismBorder: Color(0x40FFFFFF),
    gradientStart: Color(0xFFFCCBF0),
    gradientEnd: Color(0xFF6700A3),
    successLight: Color(0xFFD4EDDA),
    warningLight: Color(0xFFFFF3CD),
    errorLight: Color(0xFFF8D7DA),
    infoLight: Color(0xFFD1ECF1),
  );

  // Couleurs sombres
  static const dark = CustomColors(
    glassmorphism: Color(0x80000000),
    glassmorphismBorder: Color(0x40FFFFFF),
    gradientStart: Color(0xFF6700A3),
    gradientEnd: Color(0xFFFCCBF0),
    successLight: Color(0xFF155724),
    warningLight: Color(0xFF856404),
    errorLight: Color(0xFF721C24),
    infoLight: Color(0xFF0C5460),
  );

  @override
  CustomColors copyWith({
    Color? glassmorphism,
    Color? glassmorphismBorder,
    Color? gradientStart,
    Color? gradientEnd,
    Color? successLight,
    Color? warningLight,
    Color? errorLight,
    Color? infoLight,
  }) {
    return CustomColors(
      glassmorphism: glassmorphism ?? this.glassmorphism,
      glassmorphismBorder: glassmorphismBorder ?? this.glassmorphismBorder,
      gradientStart: gradientStart ?? this.gradientStart,
      gradientEnd: gradientEnd ?? this.gradientEnd,
      successLight: successLight ?? this.successLight,
      warningLight: warningLight ?? this.warningLight,
      errorLight: errorLight ?? this.errorLight,
      infoLight: infoLight ?? this.infoLight,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      glassmorphism: Color.lerp(glassmorphism, other.glassmorphism, t)!,
      glassmorphismBorder: Color.lerp(glassmorphismBorder, other.glassmorphismBorder, t)!,
      gradientStart: Color.lerp(gradientStart, other.gradientStart, t)!,
      gradientEnd: Color.lerp(gradientEnd, other.gradientEnd, t)!,
      successLight: Color.lerp(successLight, other.successLight, t)!,
      warningLight: Color.lerp(warningLight, other.warningLight, t)!,
      errorLight: Color.lerp(errorLight, other.errorLight, t)!,
      infoLight: Color.lerp(infoLight, other.infoLight, t)!,
    );
  }
}