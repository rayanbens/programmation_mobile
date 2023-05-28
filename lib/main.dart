import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmation_mobile/blocs/city_list_bloc.dart';
import 'package:programmation_mobile/blocs/city_search_bloc.dart';
import 'package:programmation_mobile/screens/city_list_screen.dart';
import 'package:programmation_mobile/screens/city_search_screen.dart';
import 'package:programmation_mobile/services/weather_service.dart';

import 'blocs/city_detail_bloc.dart';

void main() {
  final WeatherService weatherService = WeatherService();

  runApp(MyApp(weatherService: weatherService));
}

class MyApp extends StatelessWidget {
  final WeatherService weatherService;

  MyApp({required this.weatherService});

  MaterialColor materialColor = MaterialColor(
    Color(0xFF5600ff).value,
    <int, Color>{
      50: Color(0xFFF0F1FD),
      100: Color(0xFFD9DBF9),
      200: Color(0xFFB4B9F3),
      300: Color(0xFF9098EE),
      400: Color(0xFF7A83E9),
      500: Color(0xFF6979E9),
      600: Color(0xFF5C6DE5),
      700: Color(0xFF4E62E1),
      800: Color(0xFF3F57DD),
      900: Color(0xFF2C45D6),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CityListBloc>(
            create: (BuildContext context) =>
                CityListBloc()),
        BlocProvider<CitySearchBloc>(
            create: (BuildContext context) =>
                CitySearchBloc()),
        BlocProvider<CityDetailBloc>(
            create: (BuildContext context) =>
                CityDetailBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          primaryColor: Color(0xff6979e9),
          primarySwatch: materialColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // onGenerateRoute: (settings) {
        //   if (settings.name == '/list') {
        //     return MaterialPageRoute(
        //       builder: (context) => BlocProvider(
        //         create: (_) => CityListBloc(weatherService: weatherService),
        //         child: CityListScreen(),
        //       ),
        //     );
        //   }
        //   return null;
        // },
        home: CityListScreen(),
      ),
    );
  }
}
