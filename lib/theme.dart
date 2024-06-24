import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    // Define light theme settings
    return ThemeData(
      primaryColor: const Color.fromARGB(255, 243, 33, 198),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.orange, // Reemplazo para accentColor
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 184, 251),
      appBarTheme: AppBarTheme(
        color: const Color.fromARGB(255, 243, 33, 198),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20), // Actualizado de textTheme.headline6
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue, // Button text color
        ),
      ),
      // Define other theme settings as needed
    );
  }

  static ThemeData get darkTheme {
    // Define dark theme settings
    return ThemeData(
      primaryColor: Colors.grey[900],
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.lightBlue[800], // Reemplazo para accentColor
        brightness: Brightness
            .dark, // Asegura que el tema oscuro se aplique correctamente
      ),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        color: Colors.grey[850],
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20), // Actualizado de textTheme.headline6
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white, // Button text color
        ),
      ),
      // Define other theme settings as needed
    );
  }
}
