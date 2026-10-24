import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jivodsr/core/theme/app_colors.dart';
import 'package:jivodsr/core/theme/app_text_styles.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.light);

    return base.copyWith(
      colorScheme: const ColorScheme.light(
        primary: AppColors.activeFg,
        onPrimary: Colors.white,
        secondary: AppColors.violet,
        surface: AppColors.card,
        onSurface: AppColors.textPrimary,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.border,
        outlineVariant: AppColors.border,
        surfaceTint: Colors.transparent,
      ),
      scaffoldBackgroundColor: AppColors.background,

      // textTheme : GoogleFonts.dmSansTextTheme(base.textTheme).apply(
      //   bodyColor: AppColors.textPrimary,
      //   displayColor: AppColors.textPrimary,
      // ),

      appBarTheme: AppBarThemeData(
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.appBarTitle,
        shape: const Border(bottom: BorderSide(color: AppColors.border)),
      ),

      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.barFill,
        linearTrackColor: AppColors.barTrack,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.card,
        elevation: 0,
        indicatorColor: AppColors.activeBg,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? AppColors.activeFg : AppColors.textMuted,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return GoogleFonts.dmSans(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? AppColors.activeFg : AppColors.textMuted,
          );
        }),
      ),

    );
  }

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.activeFg,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.surfaceDark,
  );

}
