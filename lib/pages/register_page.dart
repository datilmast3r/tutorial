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
            'profilePicture': null,
          });
          // Navigate to the next page or show success message
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Autentication()),
          );
        } catch (e) {
          // Handle errors more specifically here
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(e.toString()), // Show the error message
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
        // Handle password mismatch
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
      appBar: AppBar(title: Text('Registro')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          // Added to enable scrolling when keyboard is visible
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (value) => _name = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Por favor ingrese su nombre' : null,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                onSaved: (value) => _email = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Por favor ingrese su email' : null,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                onSaved: (value) => _age = value!,
                validator: (value) {
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
                  return null; // Si pasa todas las validaciones, retorna null (sin error)
                },
                decoration: InputDecoration(labelText: 'Edad'),
              ),
              TextFormField(
                onSaved: (value) => _password = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Por favor ingrese su contraseña' : null,
                obscureText: true, // Hide password
                decoration: InputDecoration(labelText: 'Contraseña'),
              ),
              TextFormField(
                onSaved: (value) => _confirmPassword = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Por favor confirme su contraseña' : null,
                obscureText: true, // Hide password
                decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
              ),
              ElevatedButton(
                onPressed: _register,
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
