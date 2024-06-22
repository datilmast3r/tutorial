// Import the file
import 'package:logging/logging.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'autentication.dart';

// Set color scheme for the app
final ColorScheme colorScheme = ColorScheme.light(
  primary: Colors.deepPurple,
  secondary: Colors.deepPurpleAccent,
  // Add more color properties as needed
);

// Set theme data for the app

// Set the theme for the app

late Size mq;
void main() async {
  Logger.root.level = Level.ALL; // Captura todos los logs
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Necesario para la configuración específica de la plataforma
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Volunteer',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 19),
        backgroundColor: Colors.white,
      )),
      home:
          Autentication(), // Corregido: Asegúrate de que Autentication sea una clase importada correctamente
    );
  }
}
