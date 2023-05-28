import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class Location {
  const Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _LocationFromJson(json);

  final int id;
  final String name;
  final double latitude;
  final double longitude;
}

Location _LocationFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Location',
  json,
      ($checkedConvert) {
    final val = Location(
      id: $checkedConvert('id', (v) => v as int),
      name: $checkedConvert('name', (v) => v as String),
      latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
      longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
    );
    return val;
  },
);
