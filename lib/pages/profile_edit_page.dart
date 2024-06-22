import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  int _age = 0;
  XFile? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = selectedImage;
    });
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        User? user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'name': _name,
          'description': _description,
          'age': _age,
          // Aquí deberías agregar la lógica para subir la imagen a un servicio de almacenamiento y guardar la URL en Firestore
        });
        Navigator.pop(context);
      } catch (e) {
        print(
            e); // En un caso real, deberías mostrar un mensaje de error al usuario
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            if (_image != null) Image.file(File(_image!.path)),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Profile Picture'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onSaved: (value) => _name = value!,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a name' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              onSaved: (value) => _description = value!,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a description' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _age = int.parse(value!),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your age' : null,
            ),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.grey, backgroundColor: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
