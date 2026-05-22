import 'package:flutter/material.dart';

class AppTheme {
  // Cores constantes para manter a identidade visual
  static const Color _primaryColor = Colors.black;
  static const Color _surfaceWhite = Colors.white;
  static const Color _borderColor = Color(0xFFD9D9D9);
  static const Color _secondaryColor = Color(0xFF8C8C8C);

  // Tema Claro
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _surfaceWhite,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        primary: _primaryColor,
        onPrimary: _surfaceWhite,
        surface: _surfaceWhite,
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _surfaceWhite,
      ),

      // Organização dos temas de componentes
      elevatedButtonTheme: _elevatedButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      floatingActionButtonTheme: _fabTheme,
      cardTheme: _cardThemeData,

      // Estilos de texto globais
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          color: _primaryColor,
        ),
        bodyMedium: TextStyle(
          color: _secondaryColor,
          fontSize: 16.0,
        ),
      ),
    );
  }

  // Estilo dos Botões
  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primaryColor,
      foregroundColor: _surfaceWhite,
      minimumSize: const Size(double.infinity, 48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
    ),
  );

  // Estilo dos Inputs (TextFormField)
  static final _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: _surfaceWhite,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: _borderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: _borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: _primaryColor, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    prefixIconColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return _primaryColor;
      }
      return _secondaryColor;
    }),
    suffixIconColor: _secondaryColor,
  );

  static final _fabTheme = FloatingActionButtonThemeData(
    backgroundColor: _primaryColor,
    foregroundColor: _surfaceWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
    ),
  );

  static final _cardThemeData = CardThemeData(
    color: _surfaceWhite,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
}
