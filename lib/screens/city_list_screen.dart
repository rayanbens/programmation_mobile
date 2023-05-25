// Dans city_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmation_mobile/blocs/city_list_bloc.dart';
import 'package:programmation_mobile/screens/city_detail_screen.dart';

import 'city_search_screen.dart';

class CityListScreen extends StatelessWidget {
  CityListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Villes'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CitySearchScreen())
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CityListBloc, CityListState>(
        builder: (context, state) {
          if (state is CityListLoading) {
            return const CircularProgressIndicator();
          } else if (state is CityListSuccess) {
            return ListView.builder(
              itemCount: state.cities.length,
              itemBuilder: (context, index) {
                final city = state.cities[index];
                return ListTile(
                  title: Text(city.name),
                  trailing: Text('WeatherIcon'), // Replace with SVG icon
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CityDetailScreen(city: city))
                    );
                  },
                );
              },
            );
          } else {
            return const Text('Error loading cities');
          }
        },
      ),
    );
  }
}
