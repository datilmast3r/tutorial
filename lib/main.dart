import 'package:english_words/english_words.dart';
import 'custom_navigation_bar.dart'; // Import the file
import 'login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorites.dart';
import 'my_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryGlobal,
      ),
      title: 'Volunteer',
      home: LoginPage(), // LoginPage es ahora la página inicial
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}
