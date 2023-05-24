// The City class represents a city with a name attribute
class City {
  final String name;

  // The constructor for City requires a name
  City({required this.name});

  // This factory constructor allows creating a City instance from a JSON object
  factory City.fromJson(Map<String, dynamic> json) {
    // The name is expected to be a string in the JSON object
    return City(
      name: json['name'],
    );
  }
}
