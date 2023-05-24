import 'package:flutter/material.dart';

class CitySearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rechercher une ville'),
      ),
      body: Center(
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Nom de la ville',
          ),
          // TODO: ici le code pour rechercher la ville
        ),
      ),
    );
  }
}
