import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmation_mobile/models/city.dart';
import 'package:programmation_mobile/services/weather_service.dart';

// Event
abstract class CityListEvent {}

class CityListLoad extends CityListEvent {
  final String query;

  CityListLoad({required this.query});
}

// State
abstract class CityListState {}

class CityListInitial extends CityListState {}

class CityListLoading extends CityListState {}

class CityListSuccess extends CityListState {
  final List<City> cities;

  CityListSuccess({required this.cities});
}

class CityListFailure extends CityListState {}

class CityListBloc extends Bloc<CityListEvent, CityListState> {
  final WeatherService weatherService;

  CityListBloc({required this.weatherService})
      : super(CityListInitial()) {
    on<CityListLoad>(_onCityListLoad);
  }

  Future<void> _onCityListLoad(CityListLoad event, Emitter<CityListState> emit) async {
    emit(CityListLoading());
    try {
      final cities = await weatherService.searchCities(event.query);
      emit(CityListSuccess(cities: cities));
    } catch (_) {
      emit(CityListFailure());
    }
  }
}

