import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:volunteer/autentication.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _age = '';
  String _password = '';
  String _confirmPassword = '';

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_password == _confirmPassword) {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email,
            password: _password,
          );
          await FirebaseFirestore.instance
              .collection('Usuarios')
              .doc(userCredential.user!.uid)
              .set({
            'name': _name,
            'email': _email,
            'age': _age,
            'description': null,
            'imageUrl': null,
            'role': 1,
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Autentication()),
          );
        } catch (e) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Las contraseñas no coinciden.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Image.asset('./images/volunteer_logo_fondo.png', height: 120),
                  SizedBox(height: 40),
                  _buildTextField(
                      'Nombre',
                      (value) => _name = value!,
                      (value) => value!.isEmpty
                          ? 'Por favor ingrese su nombre'
                          : null),
                  SizedBox(height: 20),
                  _buildTextField(
                      'Email',
                      (value) => _email = value!,
                      (value) =>
                          value!.isEmpty ? 'Por favor ingrese su email' : null),
                  SizedBox(height: 20),
                  _buildTextField('Edad', (value) => _age = value!, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su edad';
                    }
                    final n = int.tryParse(value);
                    if (n == null) {
                      return 'Por favor ingrese un número válido';
                    }
                    if (n <= 0) {
                      return 'Por favor ingrese un número mayor que 0';
                    }
                    return null;
                  }),
                  SizedBox(height: 20),
                  _buildPasswordField(
                      'Contraseña', (value) => _password = value!),
                  SizedBox(height: 20),
                  _buildPasswordField('Confirmar Contraseña',
                      (value) => _confirmPassword = value!),
                  SizedBox(height: 30),
                  _buildRegisterButton(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved,
      String? Function(String?)? validator) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, Function(String?) onSaved) {
    return TextFormField(
      onSaved: onSaved,
      validator: (value) =>
          value!.isEmpty ? 'Por favor ingrese su contraseña' : null,
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: _register,
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      child: Text(
        'Registrarse',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
