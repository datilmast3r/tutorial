import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logging/logging.dart';
import 'package:volunteer/page_reload_notifier.dart'; // Importar Firebase Storage

class ProfileEditPage extends StatefulWidget {
  final VoidCallback onChangesSaved;
  ProfileEditPage({Key? key, required this.onChangesSaved}) : super(key: key);
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  int _age = 0;
  String? _imageUrl;
  XFile? _image;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _ageController;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadCurrentUserProfile();
    _nameController = TextEditingController(text: _name);
    _descriptionController = TextEditingController(text: _description);
    _ageController = TextEditingController(text: _age.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Widget _loadImage() {
    if (_imageUrl == null) {
      return Container(); // Or some placeholder widget
    }
    // Check if _imageUrl starts with 'assets/', indicating a local asset
    if (_imageUrl!.startsWith('assets/')) {
      return Image.asset(_imageUrl!);
    } else {
      return Image.network(_imageUrl!);
    }
  }

  Future<void> _pickImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = selectedImage;
    });
  }

  Future<void> _loadCurrentUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userProfile = await FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(user.uid)
          .get();
      if (userProfile.exists) {
        setState(() {
          _name = userProfile['name'] ?? '';
          _description = userProfile['description'] ?? '';
          _age = userProfile['age'] ?? 0;
          _imageUrl = userProfile['imageUrl'];

          // Actualizar los controladores con los nuevos valores
          _nameController.text = _name;
          _descriptionController.text = _description;
          _ageController.text = _age.toString();
        });
      }
    }
  }

  Future<String?> _uploadImageAndGetURL() async {
    if (_image == null) return null;
    File file = File(_image!.path);
    try {
      String filePath =
          'profile_pictures/${FirebaseAuth.instance.currentUser!.uid}/${_image!.name}';
      final ref = FirebaseStorage.instance.ref().child(filePath);
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      Logger logger = Logger('ProfileEditPage');
      logger.severe('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        User? user = FirebaseAuth.instance.currentUser;
        String? imageUrl;
        // Solo intenta subir la imagen si se ha seleccionado una nueva imagen.
        if (_image != null) {
          imageUrl = await _uploadImageAndGetURL();
        } else {
          // Si no se ha seleccionado una nueva imagen, usa la URL de la imagen existente.
          imageUrl = _imageUrl;
        }
        await FirebaseFirestore.instance
            .collection('Usuarios')
            .doc(user!.uid)
            .update({
          'name': _name,
          'description': _description,
          'age': _age,
          'imageUrl': imageUrl ?? '',
        });
        widget.onChangesSaved(); // Ejecuta el callback aquí
        Navigator.pop(context, true);
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to save profile information.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
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
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            if (_imageUrl != null) _loadImage(),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Profile Picture'),
            ),
            TextFormField(
              controller: _nameController, // Usar el TextEditingController
              decoration: InputDecoration(labelText: 'Name'),
              onSaved: (value) => _name = value ?? '',
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a name' : null,
            ),
            TextFormField(
              controller:
                  _descriptionController, // Usar el TextEditingController
              decoration: InputDecoration(labelText: 'Description'),
              onSaved: (value) => _description = value ?? '',
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a description' : null,
            ),
            TextFormField(
              controller: _ageController, // Usar el TextEditingController
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _age = int.tryParse(value!) ?? 0,
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
            ),
          ],
        ),
      ),
    );
  }
}
