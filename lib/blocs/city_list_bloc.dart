import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmation_mobile/models/city.dart';
import 'package:programmation_mobile/services/weather_service.dart';

// Event
abstract class CityListEvent {}

// Event
class CityListAdd extends CityListEvent {
  final City city;

  CityListAdd({required this.city});
}

class CityListLoad extends CityListEvent {
  CityListLoad();
}

// State
abstract class CityListState {}

class CityListInitial extends CityListState {}

class CityListLoading extends CityListState {}

class CityListSuccess extends CityListState {
  final List<City> cities;
  )
  CityListSuccess({required this.cities});
}

class CityListFailure extends CityListState {}

class CityListBloc extends Bloc<CityListEvent, CityListState> {
  final WeatherService weatherService = WeatherService();

  CityListBloc() : super(CityListInitial()) {
    on<CityListLoad>(_onCityListLoad);
    on<CityListAdd>(_onCityListAdd);
  }

  Future<void> _onCityListAdd(
      CityListAdd event, Emitter<CityListState> emit) async {
    try {
      if (state is CityListSuccess) {
        final updatedCities =
            List<City>.from((state as CityListSuccess).cities);
        bool flag = false;
        for (City city in updatedCities) {
          if (city.name == event.city.name) {
            flag = true;
          }
        }
        if (!flag) {
          updatedCities.add(event.city);
        }
        emit(CityListSuccess(cities: updatedCities));
      } else if (state is CityListInitial) {
        final updatedCities = [event.city];
        emit(CityListSuccess(cities: updatedCities));
      } else {
        log('MK CityListState not found');
      }
    } catch (_) {
      emit(CityListFailure());
    }
  }

  Future<void> _onCityListLoad(
      CityListLoad event, Emitter<CityListState> emit) async {
    log('MK: in city list load');

    try {
      if (state is CityListSuccess) {
        final updatedCities =
            List<City>.from((state as CityListSuccess).cities);
        if (updatedCities.isNotEmpty && updatedCities.first.weather == null)
          emit(CityListLoading());
        for (City city in updatedCities) {
          city.weather = await weatherService.getBriefWeather(
              latitude: city.latitude, longitude: city.longitude);
          // log('MK: in city list load for in loop for city: ' +
          //     city.name +
          //     ' ${city.weather?.currentWeather?.temperature}');
          emit(CityListSuccess(cities: updatedCities));
        }
        emit(CityListSuccess(cities: updatedCities));
      } else if (state is CityListInitial) {
        List<City> updatedCities = [];
        emit(CityListSuccess(cities: updatedCities));
      } else {
        final updatedCities =
            List<City>.from((state as CityListSuccess).cities);
        log('MK CityListState not found state: ${state}');
        emit(CityListFailure());
      }
    } catch (e) {
      log('MK cities error is: ${e}');
      emit(CityListFailure());
    }
  }
}
