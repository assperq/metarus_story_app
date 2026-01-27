import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  // Цветовая схема
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF1A2B5F), // Темно-синий, основной (металл, надежность)
    onPrimary: Colors.white,
    secondary: Color(
      0xFFC62828,
    ), // Ярко-красный, акцентный (опасность, внимание, энергия)
    onSecondary: Colors.white,
    onSurfaceVariant: Color(0xFF333333), // Темно-серый для основного текста
    surface: Color.fromARGB(255, 182, 178, 178), // Белый для карточек и панелей
    onSurface: Color(0xFF333333),
    error: Colors.red,
  ),
  // Типографика: четкая, разборчивая, без излишеств
  textTheme:
      TextTheme(
        displayLarge: const TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1A2B5F),
        ),
        titleLarge: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A2B55),
        ),
        titleMedium: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
          color: Color(0xFF333333),
        ),
        bodyLarge: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Color(0xFF333333),
        ),
        labelLarge: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelSmall: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
          color: Colors.blue[700],
        ),
        bodyMedium: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Color.fromARGB(255, 22, 22, 22),
        ),
      ).apply(
        fontFamily: 'Roboto', // или другой четкий, стандартный шрифт
      ),

  // Стили компонентов
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF1A2B5F),
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF1A2B5F),
      side: const BorderSide(color: Color(0xFF1A2B5F)),
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  ),

  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 2.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Color(0xFF1A2B5F), width: 2.0),
    ),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1A2B5F),
    foregroundColor: Colors.white,
    elevation: 2,
    centerTitle: true,
  ),

  segmentedButtonTheme: SegmentedButtonThemeData(
    style: ButtonStyle(
      // Цвет текста и иконок
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white; // Выбранный сегмент
        }
        return const Color(0xFF1A2B5F); // Невыбранный сегмент
      }),

      // Цвет фона
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF1A2B5F); // Выбранный сегмент
        }
        return Colors.white; // Невыбранный сегмент
      }),

      // Обводка
      side: WidgetStateProperty.resolveWith<BorderSide?>((
        Set<WidgetState> states,
      ) {
        return const BorderSide(
          color: Color(0xFF1A2B5F), // Цвет обводки
          width: 1.5,
        );
      }),

      // Форма и скругления
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),

      // Текстовый стиль
      textStyle: WidgetStateProperty.resolveWith<TextStyle?>((
        Set<WidgetState> states,
      ) {
        return const TextStyle(fontWeight: FontWeight.w600, fontSize: 14);
      }),

      padding: WidgetStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      minimumSize: WidgetStateProperty.all<Size>(
        const Size(0, 50), // Минимальная высота как у ElevatedButton
      ),

      elevation: WidgetStateProperty.resolveWith<double?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return 2.0; // Выбранный сегмент с тенью
        }
        return 0.0; // Невыбранный без тени
      }),
      animationDuration: const Duration(milliseconds: 200),
      visualDensity: VisualDensity.standard,
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.hovered) &&
            !states.contains(WidgetState.selected)) {
          return const Color(0xFF1A2B5F).withValues(alpha: 0.08);
        }
        return null;
      }),
    ),
  ),

  chipTheme: ChipThemeData(
    // Общие настройки
    backgroundColor: Colors.grey[100],
    deleteIconColor: Colors.grey[600],
    disabledColor: Colors.grey[300],
    selectedColor: const Color(0xFF1A2B5F),
    secondarySelectedColor: const Color(0xFF1A2B5F),
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    pressElevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(color: Colors.grey[300]!, width: 1.0),
    ),

    // Текстовый стиль
    labelStyle: const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    secondaryLabelStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),

    // Отступы
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    checkmarkColor: Colors.white,
    brightness: Brightness.light,
  ),
);
