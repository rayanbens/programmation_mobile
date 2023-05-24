import 'package:flutter/material.dart';

class CityListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des villes'),
      ),
      body: ListView(
        children: <Widget>[
          // TODO: faudra ajouter ici le code pour afficher la liste des villes
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: pareil, ici le code pour naviguer vers l'écran de recherche de la ville
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
