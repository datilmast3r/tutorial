import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de sesión'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                // Lógica para el inicio de sesión
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
    );
  }
}
