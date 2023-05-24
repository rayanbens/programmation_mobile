import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:programmation_mobile/models/city.dart';
import 'package:programmation_mobile/models/weather.dart';

class WeatherService {
  final String baseUrl = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m"; // Remplacer par le bon URL

  Future<List<City>> searchCities(String query) async {
    final response = await http.get(Uri.parse("$baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => City.fromJson(item)).toList();
    } else {
      throw Exception("Failed to search cities");
    }
  }

  Future<Weather> getWeather(String city) async {
    final response = await http.get(Uri.parse("$baseUrl/weather?q=$city"));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather");
    }
  }
}
