import 'package:flutter/material.dart';

class AppTheme {
  // Professional Color Palette
  static const Color primaryBlue = Color(0xFF1E40AF);
  static const Color primaryBlueLight = Color(0xFF3B82F6);
  static const Color secondaryBlue = Color(0xFF0EA5E9);
  
  static const Color successGreen = Color(0xFF059669);
  static const Color successGreenLight = Color(0xFF10B981);
  
  static const Color warningOrange = Color(0xFFEA580C);
  static const Color warningOrangeLight = Color(0xFFF97316);
  
  static const Color errorRed = Color(0xFFDC2626);
  static const Color errorRedLight = Color(0xFFEF4444);
  
  // Neutral Colors
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceGray50 = Color(0xFFF8FAFC);
  static const Color surfaceGray100 = Color(0xFFF1F5F9);
  static const Color surfaceGray200 = Color(0xFFE2E8F0);
  static const Color surfaceGray300 = Color(0xFFCBD5E1);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);
  
  // Professional Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryBlueLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient successGradient = LinearGradient(
    colors: [successGreen, successGreenLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        brightness: Brightness.light,
        primary: primaryBlue,
        secondary: secondaryBlue,
        surface: surfaceWhite,
        error: errorRed,
      ),
      
      // Typography
      textTheme: const TextTheme(
        // Headlines
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: -0.25,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        
        // Titles
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        
        // Body
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textTertiary,
          height: 1.4,
        ),
        
        // Labels
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textSecondary,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: textTertiary,
        ),
      ),
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: surfaceWhite,
        foregroundColor: textPrimary,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        centerTitle: false,
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        color: surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: surfaceGray200, width: 1),
        ),
        margin: const EdgeInsets.all(0),
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: surfaceWhite,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: surfaceWhite,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue,
          side: const BorderSide(color: surfaceGray300),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: surfaceGray300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: surfaceGray300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(color: textSecondary),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceWhite,
        selectedItemColor: primaryBlue,
        unselectedItemColor: textMuted,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: surfaceGray100,
        selectedColor: primaryBlue.withValues(alpha: 0.1),
        labelStyle: const TextStyle(color: textSecondary),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: surfaceGray200,
        thickness: 1,
        space: 1,
      ),
    );
  }
}

// Professional Status Colors
class StatusColors {
  static const Color occupied = Color(0xFF059669);
  static const Color vacant = Color(0xFFEA580C);
  static const Color maintenance = Color(0xFFDC2626);
  static const Color forSale = Color(0xFF0EA5E9);
  
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'occupied':
        return occupied;
      case 'vacant':
        return vacant;
      case 'maintenance':
        return maintenance;
      case 'forsale':
      case 'for sale':
        return forSale;
      default:
        return AppTheme.textMuted;
    }
  }
}

// Professional Shadows
class AppShadows {
  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x0A000000),
    blurRadius: 10,
    offset: Offset(0, 4),
  );
  
  static const BoxShadow elevatedShadow = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 20,
    offset: Offset(0, 8),
  );
  
  static const List<BoxShadow> softShadow = [
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];
}