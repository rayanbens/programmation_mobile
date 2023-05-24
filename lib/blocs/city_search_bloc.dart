import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmation_mobile/models/city.dart';
import 'package:programmation_mobile/services/weather_service.dart';

// Event
// Define the abstract class for city search events
abstract class CitySearchEvent {}

// This event is added when a city search is requested
class CitySearchRequested extends CitySearchEvent {
  final String cityName;

  CitySearchRequested({required this.cityName});
}

// State
// Define the abstract class for city search states
abstract class CitySearchState {}

// The initial state of the city search
class CitySearchInitial extends CitySearchState {}

// The state when the city search is being loaded
class CitySearchLoading extends CitySearchState {}

// The state when the city search has loaded successfully
class CitySearchSuccess extends CitySearchState {
  final List<City> cities;

  CitySearchSuccess({required this.cities});
}

// The state when the city search failed to load
class CitySearchFailure extends CitySearchState {}

// Bloc
// CitySearchBloc reacts to CitySearchEvent and emit CitySearchState
class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final WeatherService weatherService;

  // The initial state is CitySearchInitial
  CitySearchBloc({required this.weatherService})
      : super(CitySearchInitial());

  @override
  Stream<CitySearchState> mapEventToState(CitySearchEvent event) async* {
    // If the event is CitySearchRequested, load the city search
    if (event is CitySearchRequested) {
      yield CitySearchLoading();
      try {
        // Call the weather service to get the city search
        final cities = await weatherService.searchCities(event.cityName);
        yield CitySearchSuccess(cities: cities);
      } catch (_) {
        // If an error occurs, emit CitySearchFailure
        yield CitySearchFailure();
      }
    }
  }
}
