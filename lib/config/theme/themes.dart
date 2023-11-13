import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme() => ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightThemePrimaryColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.lightThemePrimaryColor,
        ),
      ),
      textTheme: TextTheme(
        displayMedium: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: const TextStyle(
          color: AppColors.whiteBackgroundColor,
        ),
        titleMedium: TextStyle(
          color: AppColors.shadedColor,
        ),
        titleSmall: const TextStyle(
          color: AppColors.whiteBackgroundColor,
        ),
        headlineLarge: const TextStyle(
          color: Colors.black,
        ),
        headlineMedium: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
