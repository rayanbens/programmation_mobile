import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:programmation_mobile/models/city.dart';
import '../models/weather.dart';
import '../models/weather_brief.dart';


class WeatherService {
  static const _baseUrlGeocoding = 'geocoding-api.open-meteo.com';
  static const detailedParams =
      '&hourly=relativehumidity_2m,apparent_temperature,weathercode&'
      'daily=weathercode,apparent_temperature_max,apparent_temperature_min,precipitation_probability_max'
      '&current_weather=true&timezone=auto';
  final String briefWeatherParams =
      "&current_weather=true&forecast_days=1&timezone=auto";

  Future<List<City>> citySearch(String query) async {
    final locationRequest = Uri.https(
      _baseUrlGeocoding,
      '/v1/search',
      {'name': query, 'count': '10'},
    );

    final locationResponse = await http.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      throw Exception("City request is failed");
    }

    final locationJson = jsonDecode(locationResponse.body) as Map;

    log('MK: location json: ${locationJson} and ${locationRequest}');

    if (!locationJson.containsKey('results'))
      throw Exception("Unable to search cities");

    final results = locationJson['results'] as List;

    if (results.isEmpty) throw Exception("Cities not found");

    List<City> cities = [];

    for (var res in results) {
      cities.add(City.fromJson(res as Map<String, dynamic>));
    }

    return cities;
  }

  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    final weatherRequest = Uri.parse('https://api.open-meteo.com/v1/forecast'
        '?latitude=$latitude&longitude=$longitude$detailedParams');

    final weatherResponse = await http.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw Exception("Weather request is failed");
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    return Weather.fromJson(bodyJson);
  }

  Future<BriefWeather> getBriefWeather({
    required double latitude,
    required double longitude,
  }) async {
    final response =
        await http.get(Uri.parse('https://api.open-meteo.com/v1/forecast'
            '?latitude=$latitude&longitude=$longitude$briefWeatherParams'));

    if (response.statusCode == 200) {
      return BriefWeather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather");
    }
  }
}
