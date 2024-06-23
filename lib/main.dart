// Import the file
import 'package:logging/logging.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:volunteer/theme.dart';
import 'firebase_options.dart';
import 'autentication.dart';

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
      theme: AppTheme.lightTheme,
      home:
          Autentication(), // Corregido: Asegúrate de que Autentication sea una clase importada correctamente
    );
  }
}
