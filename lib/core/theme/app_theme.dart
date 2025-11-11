import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static final light = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accent),
  );
}
