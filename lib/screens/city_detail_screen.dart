// Dans city_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmation_mobile/blocs/city_detail_bloc.dart';
import 'package:programmation_mobile/models/city.dart';

class CityDetailScreen extends StatelessWidget {
  final City city;

  CityDetailScreen({required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${city.name} Details'),
      ),
      body: BlocBuilder<CityDetailBloc, CityDetailState>(
        builder: (context, state) {
          if (state is CityDetailLoading) {
            return const CircularProgressIndicator();
          } else if (state is CityDetailSuccess) {
            final weather = state.weather;
            return ListView(
              children: <Widget>[
                ListTile(
                  title: const Text('Weather Description'),
                  subtitle: Text(weather.description),
                ),
                ListTile(
                  title: const Text('Temperature'),
                  subtitle: Text('${weather.temperature}'),
                ),
                ListTile(
                  title: const Text('Humidity'),
                  subtitle: Text('${weather.humidity}'),
                ),
                ListTile(
                  title: const Text('Wind Speed'),
                  subtitle: Text('${weather.windSpeed}'),
                ),
              ],
            );
          } else {
            return const Text('Error loading weather details');
          }
        },
      ),
    );
  }
}
