import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmation_mobile/blocs/city_search_bloc.dart';
import 'package:flutter/material.dart';

class CitySearchScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une ville'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Nom de la ville',
              ),
              onSubmitted: (value) {
                BlocProvider.of<CitySearchBloc>(context, listen: false).add(
                  CitySearchRequested(cityName: value),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
