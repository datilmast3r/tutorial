import 'package:flutter/material.dart';
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
                  'images/volunteer_logo.jpg',
                  width: 100.0,
                  height: 100.0,
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
                  ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para el inicio de sesión con Google
                    },
                    icon: Icon(Icons.login),
                    label: Text('Google'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para el inicio de sesión con Twitter
                    },
                    icon: Icon(Icons.login),
                    label: Text('Twitter'),
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
