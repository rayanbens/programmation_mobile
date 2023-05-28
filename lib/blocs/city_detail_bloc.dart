import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmation_mobile/services/weather_service.dart';
import 'package:programmation_mobile/models/city.dart';

import '../models/weather.dart';

abstract class CityDetailEvent {}

class CityDetailLoad extends CityDetailEvent {
  final City city;

  CityDetailLoad({required this.city});
}

// State
abstract class CityDetailState {}

class CityDetailInitial extends CityDetailState {}

class CityDetailLoading extends CityDetailState {}

class CityDetailSuccess extends CityDetailState {
  final Weather weather;

  CityDetailSuccess({required this.weather});
}

class CityDetailFailure extends CityDetailState {
}

// Bloc
class CityDetailBloc extends Bloc<CityDetailEvent, CityDetailState> {
  final WeatherService weatherService = WeatherService();

  CityDetailBloc() : super(CityDetailInitial()) {
    on<CityDetailLoad>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      CityDetailEvent event, Emitter<CityDetailState> emit) async {
    if (event is CityDetailLoad) {
      emit(CityDetailLoading());
      try {
        final weather = await weatherService.getWeather(
            latitude: event.city.latitude, longitude: event.city.longitude);
        emit(CityDetailSuccess(weather: weather));
      } catch (e) {
        log('Error while loading weather $e');
        emit(CityDetailFailure());
      }
    }
  }
}
