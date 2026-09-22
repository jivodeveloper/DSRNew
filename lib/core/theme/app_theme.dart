import 'package:flutter/material.dart';
import 'package:jivodsr/core/theme/app_colors.dart';

class AppTheme {

  const AppTheme._();
     
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    scaffoldBackgroundColor: AppColors.surfaceLight,
  );
     
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
    scaffoldBackgroundColor: AppColors.surfaceDark,
  );
    
}