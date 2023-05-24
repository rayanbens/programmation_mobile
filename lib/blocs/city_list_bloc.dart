import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmation_mobile/models/city.dart';
import 'package:programmation_mobile/services/weather_service.dart';

// Event
// Define the abstract class for city list events
abstract class CityListEvent {}

// This event is added when the city list needs to be loaded
class CityListLoad extends CityListEvent {
  final String query;

  CityListLoad({required this.query});
}

// State
// Define the abstract class for city list states
abstract class CityListState {}

// The initial state of the city list
class CityListInitial extends CityListState {}

// The state when the city list is being loaded
class CityListLoading extends CityListState {}

// The state when the city list has loaded successfully
class CityListSuccess extends CityListState {
  final List<City> cities;

  CityListSuccess({required this.cities});
}

// The state when the city list failed to load
class CityListFailure extends CityListState {}

// Bloc
// CityListBloc reacts to CityListEvent and emit CityListState
class CityListBloc extends Bloc<CityListEvent, CityListState> {
  final WeatherService weatherService;

  // The initial state is CityListInitial
  CityListBloc({required this.weatherService})
      : super(CityListInitial());

  @override
  Stream<CityListState> mapEventToState(CityListEvent event) async* {
    // If the event is CityListLoad, load the city list
    if (event is CityListLoad) {
      yield CityListLoading();
      try {
        // Call the weather service to get the city list
        final cities = await weatherService.searchCities(event.query);
        yield CityListSuccess(cities: cities);
      } catch (_) {
        // If an error occurs, emit CityListFailure
        yield CityListFailure();
      }
    }
  }
}
