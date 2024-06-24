import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:volunteer/helpers/firestore_service.dart';
import 'package:logger/logger.dart';
import 'package:volunteer/models/Usuario.dart'; // Asegúrate de que este paquete esté incluido en pubspec.yaml

class MyHomePage extends StatefulWidget {
  final Usuario usuario;

  MyHomePage({Key? key, required this.usuario}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  List<SwipeItem> swipeItems = [];
  late MatchEngine matchEngine;
  bool isLoading = true;

  final logger = Logger();

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    var projects = await FirestoreService().getVolunteerProjects();
    setState(() {
      swipeItems = projects.map((project) {
        logger.i(project.toString());

        return SwipeItem(
          content: Content(
            projectId: project['id'],
            title:
                project['nombre'], // Asegúrate de que esta es la clave correcta
            description: project['descripcion'],
            imageUrl: project['imageUrl'],
          ),
          likeAction: () async {
            try {
              await FirebaseFirestore.instance.collection('Matchs').add({
                'userId': userId,
                'projectId': project['id'],
                'timestamp': FieldValue.serverTimestamp(),
              });
              logger.i(
                  "Liked: ${project['nombre']}"); // Corregido para usar logger y la clave correcta
            } catch (e) {
              logger.e(
                  "Error al guardar el like: $e"); // Usar logger.e para errores
            }
          },
          nopeAction: () {
            logger.i(
                "Nope: ${project['nombre']}"); // Corregido para usar logger y la clave correcta
          },
        );
      }).toList();
      logger.i(swipeItems.toString());

      matchEngine = MatchEngine(swipeItems: swipeItems);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Home Page'),
      ),
      body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : SwipeCards(
                  matchEngine: matchEngine,
                  itemBuilder: (BuildContext context, int index) {
                    final content = swipeItems[index].content as Content;
                    return buildSwipeCard(context, content);
                  },
                  onStackFinished: () {
                    logger.i('All cards swiped!');
                    _showNoMoreCardsDialog(
                        context); // Llama a esta nueva función
                  },
                )),
    );
  }

  Widget buildSwipeCard(BuildContext context, Content content) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    content.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black54,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          content.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          content.description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Content {
  final String projectId;
  final String title;
  final String description;
  final String imageUrl;

  Content({
    required this.projectId,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

void _showNoMoreCardsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("¡Hecho!"),
        content: Text("No hay más tarjetas para deslizar."),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
            },
          ),
        ],
      );
    },
  );
}
