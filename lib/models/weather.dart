// The Weather class represents weather information with various attributes
class Weather {
  final String description;
  final double temperature;
  final double humidity;
  final double windSpeed;

  // The constructor for Weather requires description, temperature, humidity, and windSpeed
  Weather({
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
  });

  // This factory constructor allows creating a Weather instance from a JSON object
  factory Weather.fromJson(Map<String, dynamic> json) {
    // Each attribute is expected to be in a specific location in the JSON object
    return Weather(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }
}
