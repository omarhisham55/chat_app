import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme() => ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightThemePrimaryColor,
      ),
      textTheme: const TextTheme(
        displayMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: AppColors.whiteBackgroundColor,
        ),
        titleSmall: TextStyle(
          color: AppColors.whiteBackgroundColor,
        ),
        headlineLarge: TextStyle(
          color: Colors.black,
        ),
        headlineMedium: TextStyle(
          color: Colors.black,
        ),
      ),
    );
