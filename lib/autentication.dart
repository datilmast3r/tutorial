import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'package:volunteer/models/Usuario.dart';
import 'package:volunteer/pages/main_screen.dart';
import 'package:volunteer/pages/my_home_page.dart'; // Importa tu página de inicio
import 'package:volunteer/pages/login_page.dart'; // Importa tu página de inicio de sesión

class Autentication extends StatefulWidget {
  @override
  _AutenticationState createState() => _AutenticationState();
}

class _AutenticationState extends State<Autentication> {
  @override
  void initState() {
    super.initState();
    // Verificar si el usuario está autenticado al iniciar la pantalla
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (user == null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          FirebaseFirestore.instance
              .collection('Usuarios')
              .doc(user.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              Map<String, dynamic> userData =
                  documentSnapshot.data() as Map<String, dynamic>;
              Usuario usuario = Usuario.fromMap(userData);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => MainScreen(usuario: usuario)),
              );
            } else {
              // Handle the case when the user document does not exist
            }
          }).catchError((error) {
            // Handle any errors that occur during the document retrieval
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mientras se verifica el estado de autenticación, muestra una pantalla de carga
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
