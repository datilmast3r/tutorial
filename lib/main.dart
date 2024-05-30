// Import the file
import 'login_page.dart';
import 'package:flutter/material.dart';

// Set color scheme for the app
final ColorScheme colorScheme = ColorScheme.light(
  primary: Colors.deepPurple,
  secondary: Colors.deepPurpleAccent,
  // Add more color properties as needed
);

// Set theme data for the app
final ThemeData themeData = ThemeData(
  colorScheme: colorScheme,
  // Add more theme properties as needed
);

// Set the theme for the app
ThemeData getAppTheme() {
  return themeData;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volunteer',
      home: LoginPage(), // LoginPage es ahora la página inicial
    );
  }
}
