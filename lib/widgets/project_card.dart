import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;

  const ProjectCard(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(title),
            subtitle: Text(description),
          ),
          // Puedes agregar más widgets aquí según sea necesario
        ],
      ),
    );
  }
}
