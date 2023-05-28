
import 'package:intl/intl.dart';

class Weather {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  CurrentWeather? currentWeather;
  HourlyUnits? hourlyUnits;
  Hourly? hourly;
  DailyUnits? dailyUnits;
  Daily? daily;

  Weather(
      {this.latitude,
      this.longitude,
      this.generationtimeMs,
      this.utcOffsetSeconds,
      this.timezone,
      this.timezoneAbbreviation,
      this.elevation,
      this.currentWeather,
      this.hourlyUnits,
      this.hourly,
      this.dailyUnits,
      this.daily});

  Weather.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    generationtimeMs = json['generationtime_ms'];
    utcOffsetSeconds = json['utc_offset_seconds'];
    timezone = json['timezone'];
    timezoneAbbreviation = json['timezone_abbreviation'];
    elevation = json['elevation'];
    currentWeather = json['current_weather'] != null
        ? new CurrentWeather.fromJson(json['current_weather'])
        : null;
    hourlyUnits = json['hourly_units'] != null
        ? new HourlyUnits.fromJson(json['hourly_units'])
        : null;
    hourly =
        json['hourly'] != null ? new Hourly.fromJson(json['hourly']) : null;
    dailyUnits = json['daily_units'] != null
        ? new DailyUnits.fromJson(json['daily_units'])
        : null;
    daily = json['daily'] != null ? new Daily.fromJson(json['daily']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['generationtime_ms'] = this.generationtimeMs;
    data['utc_offset_seconds'] = this.utcOffsetSeconds;
    data['timezone'] = this.timezone;
    data['timezone_abbreviation'] = this.timezoneAbbreviation;
    data['elevation'] = this.elevation;
    if (this.currentWeather != null) {
      data['current_weather'] = this.currentWeather!.toJson();
    }
    if (this.hourlyUnits != null) {
      data['hourly_units'] = this.hourlyUnits!.toJson();
    }
    if (this.hourly != null) {
      data['hourly'] = this.hourly!.toJson();
    }
    if (this.dailyUnits != null) {
      data['daily_units'] = this.dailyUnits!.toJson();
    }
    if (this.daily != null) {
      data['daily'] = this.daily!.toJson();
    }
    return data;
  }
}

class CurrentWeather {
  double? temperature;
  double? windspeed;
  double? winddirection;
  int? weathercode;
  int? isDay;
  String? time;

  CurrentWeather(
      {this.temperature,
      this.windspeed,
      this.winddirection,
      this.weathercode,
      this.isDay,
      this.time});

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    temperature = json['temperature'];
    windspeed = json['windspeed'];
    winddirection = json['winddirection'];
    weathercode = json['weathercode'];
    isDay = json['is_day'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temperature'] = this.temperature;
    data['windspeed'] = this.windspeed;
    data['winddirection'] = this.winddirection;
    data['weathercode'] = this.weathercode;
    data['is_day'] = this.isDay;
    data['time'] = this.time;
    return data;
  }
}

class HourlyUnits {
  String? time;
  String? relativehumidity2m;
  String? apparentTemperature;
  String? weathercode;

  HourlyUnits(
      {this.time,
      this.relativehumidity2m,
      this.apparentTemperature,
      this.weathercode});

  HourlyUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    relativehumidity2m = json['relativehumidity_2m'];
    apparentTemperature = json['apparent_temperature'];
    weathercode = json['weathercode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['relativehumidity_2m'] = this.relativehumidity2m;
    data['apparent_temperature'] = this.apparentTemperature;
    data['weathercode'] = this.weathercode;
    return data;
  }
}

class Hourly {
  List<String>? time;
  List<int>? relativehumidity2m;
  List<double>? apparentTemperature;
  List<int>? weathercode;
  List<List<HourlyUnit>>? days;

  Hourly(
      {this.time,
      this.relativehumidity2m,
      this.apparentTemperature,
      this.weathercode,
      this.days});

  Hourly.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
    relativehumidity2m = json['relativehumidity_2m'].cast<int>();
    apparentTemperature = json['apparent_temperature'].cast<double>();
    weathercode = json['weathercode'].cast<int>();

    this.days = [];
    List<HourlyUnit> day = [];

    if (time != null &&
        relativehumidity2m != null &&
        apparentTemperature != null &&
        weathercode != null) {
      for (int i = 0; i < time!.length; i++) {
        String timeStr = time![i];
        DateTime dateTime = DateFormat("yyyy-MM-dd'T'HH:mm").parse(timeStr);
        if (day.isEmpty) {
          day.add(HourlyUnit(
              time: dateTime,
              relativehumidity: relativehumidity2m![i],
              apparentTemperature: apparentTemperature![i],
              weathercode: weathercode![i]));
        } else if (dateTime.day == day.last.time?.day) {
          day.add(HourlyUnit(
              time: dateTime,
              relativehumidity: relativehumidity2m![i],
              apparentTemperature: apparentTemperature![i],
              weathercode: weathercode![i]));
        } else {
          this.days?.add(day);
          day = [];
          day.add(HourlyUnit(
              time: dateTime,
              relativehumidity: relativehumidity2m![i],
              apparentTemperature: apparentTemperature![i],
              weathercode: weathercode![i]));
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['relativehumidity_2m'] = this.relativehumidity2m;
    data['apparent_temperature'] = this.apparentTemperature;
    data['weathercode'] = this.weathercode;
    return data;
  }
}

class HourlyUnit {
  DateTime? time;
  int? relativehumidity;
  double? apparentTemperature;
  int? weathercode;

  HourlyUnit(
      {this.time,
      this.relativehumidity,
      this.apparentTemperature,
      this.weathercode});
}

class DailyUnits {
  String? time;
  String? weathercode;
  String? apparentTemperatureMax;
  String? apparentTemperatureMin;
  String? precipitationProbabilityMax;

  DailyUnits(
      {this.time,
      this.weathercode,
      this.apparentTemperatureMax,
      this.apparentTemperatureMin,
      this.precipitationProbabilityMax});

  DailyUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    weathercode = json['weathercode'];
    apparentTemperatureMax = json['apparent_temperature_max'];
    apparentTemperatureMin = json['apparent_temperature_min'];
    precipitationProbabilityMax = json['precipitation_probability_max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['weathercode'] = this.weathercode;
    data['apparent_temperature_max'] = this.apparentTemperatureMax;
    data['apparent_temperature_min'] = this.apparentTemperatureMin;
    data['precipitation_probability_max'] = this.precipitationProbabilityMax;
    return data;
  }
}

class Daily {
  List<String>? time;
  List<int>? weathercode;
  List<double>? apparentTemperatureMax;
  List<double>? apparentTemperatureMin;
  List<int>? precipitationProbabilityMax;
  List<DailyUnit>? days;

  Daily(
      {this.time,
      this.weathercode,
      this.apparentTemperatureMax,
      this.apparentTemperatureMin,
      this.precipitationProbabilityMax,
      this.days});

  Daily.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
    weathercode = json['weathercode'].cast<int>();
    apparentTemperatureMax = json['apparent_temperature_max'].cast<double>();
    apparentTemperatureMin = json['apparent_temperature_min'].cast<double>();
    precipitationProbabilityMax =
        json['precipitation_probability_max'].cast<int>();
    this.days = [];
    if (time != null &&
        weathercode != null &&
        apparentTemperatureMax != null &&
        apparentTemperatureMin != null &&
        precipitationProbabilityMax != null) {
      for (int i = 0; i < time!.length; i++) {
        String timeStr = time![i];
        DateTime dateTime = DateFormat("yyyy-MM-dd").parse(timeStr);
        this.days!.add(DailyUnit(
              time: dateTime,
              apparentTemperatureMax: apparentTemperatureMax![i],
              apparentTemperatureMin: apparentTemperatureMin![i],
              weathercode: weathercode![i],
              precipitationProbabilityMax: precipitationProbabilityMax![i],
            ));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['weathercode'] = this.weathercode;
    data['apparent_temperature_max'] = this.apparentTemperatureMax;
    data['apparent_temperature_min'] = this.apparentTemperatureMin;
    data['precipitation_probability_max'] = this.precipitationProbabilityMax;
    return data;
  }
}

class DailyUnit {
  DateTime? time;
  int? weathercode;
  double? apparentTemperatureMax;
  double? apparentTemperatureMin;
  int? precipitationProbabilityMax;

  DailyUnit(
      {this.time,
      this.weathercode,
      this.apparentTemperatureMax,
      this.apparentTemperatureMin,
      this.precipitationProbabilityMax});
}
