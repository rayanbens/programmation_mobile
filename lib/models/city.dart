import 'package:programmation_mobile/models/weather_brief.dart';

class City {
  City({
    required this.id,
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.weather,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      weather: json['weather'] != null
          ? BriefWeather.fromJson(json['weather'])
          : null,
    );
  }

  final int id;
  final String name;
  final String country;
  final double latitude;
  final double longitude;
  BriefWeather? weather;
}
