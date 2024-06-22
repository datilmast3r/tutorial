import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:volunteer/autentication.dart';
// Usa un alias para evitar la confusión
import 'package:volunteer/pages/my_home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        // Permite el desplazamiento si el contenido excede la pantalla
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Image.asset('./images/volunteer_logo_fondo.png',
                    height: 120), // Logo de la aplicación
                SizedBox(height: 40),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Usuario',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    login(_usernameController.text, _passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  icon:
                      Icon(Icons.login, color: Theme.of(context).primaryColor),
                  label: Text(
                    'Iniciar sesión con Google',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Future<User?> signInWithGoogle() async {
                      try {
                        // Trigger the authentication flow
                        final GoogleSignInAccount? googleUser =
                            await GoogleSignIn().signIn();

                        // Obtain the auth details from the request
                        final GoogleSignInAuthentication? googleAuth =
                            await googleUser?.authentication;

                        // Create a new credential
                        final credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth?.accessToken,
                          idToken: googleAuth?.idToken,
                        );

                        // Once signed in, return the UserCredential
                        final userCredential = await FirebaseAuth.instance
                            .signInWithCredential(credential);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => Autentication()),
                        );
                      } catch (e) {
                        print(e);
                        return null;
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    '¿No tienes cuenta? Regístrate',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login(String username, String password) async {
    if (!emailRegex.hasMatch(username)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Formato de email inválido'),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Autentication()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error al iniciar sesión: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
