import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jivodsr/core/theme/app_colors.dart';

class AppTextStyles {

  const AppTextStyles._();

  // ---- Headings (Playfair Display) ----
  static TextStyle get appBarTitle => GoogleFonts.playfairDisplay(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get personName => GoogleFonts.playfairDisplay(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get cardTitle => GoogleFonts.playfairDisplay(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get bigNumber => GoogleFonts.playfairDisplay(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFeatures: const [
      FontFeature.liningFigures(),
      FontFeature.tabularFigures(),
    ],
  );

  // ---- Body (DM Sans) ----
  static TextStyle get label => GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle get caption => GoogleFonts.dmSans(
    fontSize: 12,
    color: AppColors.textMuted,
  );

  static TextStyle get secondary => GoogleFonts.dmSans(
    fontSize: 13,
    color: AppColors.textSecondary,
  );
  
}
