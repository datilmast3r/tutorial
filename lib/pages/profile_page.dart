import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/pages/login_page.dart';
import 'package:volunteer/pages/profile_edit_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case 'logout':
                  // Aquí va tu lógica para desconectar al usuario, por ejemplo:
                  FirebaseAuth.instance.signOut();
                  // Redirige al usuario a la pestaña de login
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Desconectar'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_image.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Nombre de usuario',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Descripción del usuario',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Edad: 25',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileEditPage()),
                );
              },
              child: Text('Editar perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
