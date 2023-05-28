import 'dart:developer';

import 'package:programmation_mobile/models/weather.dart';

class BriefWeather {
  double? generationtimeMs;
  CurrentWeather? currentWeather;

  BriefWeather(
      {
        this.generationtimeMs,
        this.currentWeather});

  BriefWeather.fromJson(Map<String, dynamic> json) {
    generationtimeMs = json['generationtime_ms'];
    currentWeather = json['current_weather'] != null
        ? new CurrentWeather.fromJson(json['current_weather'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['generationtime_ms'] = this.generationtimeMs;
    if (this.currentWeather != null) {
      data['current_weather'] = this.currentWeather!.toJson();
    }
    return data;
  }
}
