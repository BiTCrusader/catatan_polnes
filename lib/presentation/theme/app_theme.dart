import 'package:flutter/material.dart';
import 'tokens.dart';

abstract final class AppTheme {
  static const _seed = Color(0xFF143D6B);

  static ThemeData terang() => _bangun(Brightness.light);
  static ThemeData gelap() => _bangun(Brightness.dark);

  static ThemeData _bangun(Brightness kecerahan) {
    final skema = ColorScheme.fromSeed(seedColor: _seed, brightness: kecerahan);

    return ThemeData(
      useMaterial3: true,
      colorScheme: skema,
      scaffoldBackgroundColor: skema.surface,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 2,
        backgroundColor: skema.surface,
        foregroundColor: skema.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: skema.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: BorderSide(color: skema.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: skema.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),
    );
  }
}
