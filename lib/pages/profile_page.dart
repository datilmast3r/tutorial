import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/models/Usuario.dart';
import 'package:volunteer/pages/login_page.dart';
import 'package:volunteer/pages/profile_edit_page.dart';

class ProfilePage extends StatefulWidget {
  final Usuario usuario;
  final VoidCallback onChangesSaved;
  ProfilePage({Key? key, required this.usuario, required this.onChangesSaved})
      : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  String userDescription = '';
  int userAge = 0;
  String profileImageUrl = 'assets/profile_image.png'; // Valor por defecto

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userData = await FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(user.uid)
          .get();
      setState(() {
        username = userData['name'];
        userDescription = userData['description'];
        userAge = userData['age'];
        profileImageUrl = userData['imageUrl'] ?? 'assets/profile_image.png';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
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
              backgroundImage: NetworkImage(
                  profileImageUrl), // Modificado para mostrar la imagen de perfil del usuario
            ),
            SizedBox(height: 20),
            Text(
              username, // Modificado para mostrar el nombre del usuario
              style: TextStyle(fontSize: 20),
            ),
            Text(
              userDescription, // Modificado para mostrar la descripción del usuario
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Edad: $userAge', // Modificado para mostrar la edad del usuario
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileEditPage(
                            onChangesSaved: widget.onChangesSaved,
                          )),
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
