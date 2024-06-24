import 'package:flutter/material.dart';

class MyHomePageEmpresa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proyectos'),
      ),
      body: ListView(
        children: [
          // TODO: Add your project list items here
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to the form page
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
