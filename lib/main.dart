import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmation_mobile/blocs/city_list_bloc.dart';
import 'package:programmation_mobile/services/weather_service.dart';
import 'package:programmation_mobile/screens/city_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WeatherService weatherService = WeatherService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<CityListBloc>(
        create: (context) => CityListBloc(weatherService: weatherService),
        child: CityListScreen(),
      ),
    );
  }
}


