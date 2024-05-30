import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  'images/volunteer_logo.png',
                  width: 150.0, // Aumenta el tamaño del logo
                  height: 150.0, // Aumenta el tamaño del logo
                  fit: BoxFit.cover,
                ),
              ),
              Text('Inicio de sesión'),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Usuario',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  login('Usuario', 'Contraseña');
                },
                child: Text('Iniciar sesión'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Lógica para registrar un nuevo usuario
                },
                child: Text('¿No tienes usuario? Regístrate aquí'),
              ),
              SizedBox(height: 16),
              Text('O inicia sesión con:'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Implement Google Sign-In
                      void loginWithGoogle() {}
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset('images/logos/logo-google.svg',
                          height: 24, width: 24),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // añadir alerta emergente que diga funcion aun no disponible
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Función no disponible'),
                            content: Text(
                                'Lo sentimos, esta función aún no está disponible.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset('images/logos/logo-apple.svg',
                          height: 24, width: 24),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Database> getDatabase() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = join(directory.path, 'my_database.db');
  return openDatabase(path, version: 1, onCreate: (db, version) {
    // Create the users table if it doesn't exist
    return db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY,
        username TEXT,
        password TEXT
      )
    ''');
  });
}

Future<bool> login(String username, String password) async {
  final db = await getDatabase();

  // Encriptar la contraseña
  var bytes = utf8.encode(password); // data being hashed
  var digest = sha256.convert(bytes);

  final result = await db.query('users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, digest.toString()]);
  return result.isNotEmpty;
}
