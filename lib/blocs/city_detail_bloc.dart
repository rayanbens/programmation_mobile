import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmation_mobile/services/weather_service.dart';
import 'package:programmation_mobile/models/city.dart';
import 'package:programmation_mobile/models/weather.dart';

// Event
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

class CityDetailFailure extends CityDetailState {}

// Bloc
class CityDetailBloc extends Bloc<CityDetailEvent, CityDetailState> {
  final WeatherService weatherService;

  CityDetailBloc({required this.weatherService})
      : super(CityDetailInitial());

  @override
  Stream<CityDetailState> mapEventToState(CityDetailEvent event) async* {
    if (event is CityDetailLoad) {
      yield CityDetailLoading();
      try {
        final weather = await weatherService.getWeather(event.city.name);
        yield CityDetailSuccess(weather: weather);
      } catch (_) {
        yield CityDetailFailure();
      }
    }
  }
}
