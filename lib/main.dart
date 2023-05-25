import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmation_mobile/blocs/city_list_bloc.dart';
import 'package:programmation_mobile/blocs/city_search_bloc.dart';
import 'package:programmation_mobile/screens/city_list_screen.dart';
import 'package:programmation_mobile/screens/city_search_screen.dart';
import 'package:programmation_mobile/services/weather_service.dart';

void main() {
  final WeatherService weatherService = WeatherService();

  runApp(MyApp(weatherService: weatherService));
}

class MyApp extends StatelessWidget {
  final WeatherService weatherService;

  MyApp({required this.weatherService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/search') {
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => CitySearchBloc(weatherService: weatherService),
              child: CitySearchScreen(),
            ),
          );
        }
        return null;
      },

      home: BlocProvider(
        create: (context) => CityListBloc(weatherService: weatherService),
        child: CityListScreen(),
      ),
    );
  }
}
