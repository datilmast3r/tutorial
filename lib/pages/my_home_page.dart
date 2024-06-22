import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:volunteer/helpers/firestore_service.dart';
import 'package:logger/logger.dart'; // Import the logger package

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SwipeItem> swipeItems = [];
  late MatchEngine matchEngine;
  bool isLoading = true;

  final logger = Logger(); // Define the logger variable

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    var projects = await FirestoreService().getVolunteerProjects();
    logger.i(projects.toString());
    setState(() {
      swipeItems = projects.map((project) {
        return SwipeItem(
          content: Content(
            title: project['nombre'],
            description: project['descripcion'],
            imageUrl: project['imageUrl'],
          ),
          likeAction: () {
            print("Liked: ${project['title']}");
          },
          nopeAction: () {
            print("Nope: ${project['title']}");
          },
          superlikeAction: () {
            print("Superliked: ${project['title']}");
          },
        );
      }).toList();
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
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 4.0,
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
                  );
                },
                onStackFinished: () {
                  print('All cards swiped!');
                },
              ),
      ),
    );
  }
}

class Content {
  final String title;
  final String description;
  final String imageUrl;

  Content({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
