import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String getWindDirection(int windDirection) {
  if (windDirection == -1) return '--';
  final octant = (windDirection / 45).floor();
  final directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
  final neDirection = directions[(octant + 1) % 8];
  return neDirection;
}

String getWeekdayName(DateTime dateTime, {String locale = 'en'}) {
  // Format the DateTime object to get the weekday name
  initializeDateFormatting(locale); // Initialize locale-specific data
  DateFormat formatter = DateFormat.EEEE(locale);
  String weekdayName = formatter.format(dateTime);

  // Capitalize the first letter
  String capitalizedWeekdayName =
      weekdayName.substring(0, 1).toUpperCase() + weekdayName.substring(1);

  return capitalizedWeekdayName;
}

String getWeatherCondition(int? weatherCode) {
  switch (weatherCode) {
    case 0:
      return "Clear sky";
    case 1:
      return "Mainly clear";
    case 2:
      return "Partly cloudy";
    case 3:
      return "Overcast";
    case 45:
      return "Fog";
    case 48:
      return "Depositing rime fog";
    case 51:
      return "Light drizzle";
    case 53:
      return "Moderate drizzle";
    case 55:
      return "Dense drizzle";
    case 56:
      return "Light freezing drizzle";
    case 57:
      return "Dense freezing drizzle";
    case 61:
      return "Slight rain";
    case 63:
      return "Moderate rain";
    case 65:
      return "Heavy rain";
    case 66:
      return "Light freezing rain";
    case 67:
      return "Heavy freezing rain";
    case 71:
      return "Slight snowfall";
    case 73:
      return "Moderate snowfall";
    case 75:
      return "Heavy snowfall";
    case 77:
      return "Snow grains";
    case 80:
      return "Slight rain showers";
    case 81:
      return "Moderate rain showers";
    case 82:
      return "Violent rain showers";
    case 85:
      return "Slight snow showers";
    case 86:
      return "Heavy snow showers";
    case 95:
      return "Slight thunderstorm";
    case 96:
      return "Thunderstorm: Slight hail";
    case 97:
      return "Thunderstorm: Moderate hail";
    case 99:
      return "Thunderstorm: Heavy hail";
    default:
      return "Unknown";
  }
}

String getWeatherIcon(int? weatherCode, {bool isDay = true}) {
  switch (weatherCode) {
    case 0:
      return isDay ? 'assets/images/sunlight.svg' : 'assets/images/night.svg';
    case 1:
      return isDay
          ? "assets/images/sun-cloud.svg"
          : "assets/images/night-cloud.svg";
    case 2:
      return isDay
          ? "assets/images/cloudy-2.svg"
          : 'assets/images/night-cloud.svg';
    case 3:
      return "assets/images/cloudy-1.svg";
    case 45:
      return "assets/images/overcast.svg";
    case 48:
      return "assets/images/snow.svg";
    case 51:
      return "assets/images/rain-drops-1.svg";
    case 53:
      return "assets/images/rain-drops-2.svg";
    case 55:
      return "assets/images/rain-drops-3.svg";
    case 56:
      return "assets/images/rain-wind.svg";
    case 57:
      return "assets/images/sprinkle.svg";
    case 61:
      return "assets/images/sprinkle.svg";
    case 63:
      return "assets/images/rain.svg";
    case 65:
      return "assets/images/rain-3.svg";
    case 66:
      return "assets/images/rain-5.svg";
    case 67:
      return "assets/images/rain-5.svg";
    case 71:
      return "assets/images/snow.svg";
    case 73:
      return "assets/images/snow-1.svg";
    case 75:
      return "assets/images/snow-2.svg";
    case 77:
      return "assets/images/snow-3.svg";
    case 80:
      return "assets/images/rain.svg";
    case 81:
      return isDay ? 'assets/images/rain-4.svg' : "assets/images/rain-2.svg";
    case 82:
      return "assets/images/rain-5.svg";
    case 85:
      return "assets/images/snow.svg";
    case 86:
      return "assets/images/snow-1.svg";
    case 95:
      return "assets/images/snow-2.svg";
    case 96:
      return "assets/images/tornado-2.svg";
    case 97:
      return "assets/images/tornado-1.svg";
    case 99:
      return "assets/images/thunderstorm.svg";
    default:
      return isDay ? 'assets/images/sunlight.svg' : 'assets/images/night.svg';
  }
}
