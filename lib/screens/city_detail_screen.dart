// Dans city_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:programmation_mobile/blocs/city_detail_bloc.dart';
import 'package:programmation_mobile/models/city.dart';
import 'package:programmation_mobile/screens/widgets/center_widget.dart';

import '../constants.dart';
import '../helpers.dart';
import '../models/weather.dart';

class CityDetailScreen extends StatefulWidget {
  final City city;

  CityDetailScreen({required this.city});

  @override
  State<CityDetailScreen> createState() => _CityDetailScreenState();
}

class _CityDetailScreenState extends State<CityDetailScreen> {
  int selectedDay = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.city.name} Details'),
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_circle_left,
                    size: 38,
                  ),
                  padding: EdgeInsets.zero,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${widget.city.name}, ${widget.city.country}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<CityDetailBloc, CityDetailState>(
                  builder: (context, state) {
                    if (state is CityDetailLoading) {
                      return CenterWidget(
                          child: const CircularProgressIndicator());
                    } else if (state is CityDetailSuccess) {
                      final weather = state.weather;
                      return Column(
                        children: [
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 26.0, vertical: 18),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${getWeatherCondition(weather.currentWeather?.weathercode)}',
                                            style: TextStyle(
                                                color: fontLightColor,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            '${weather.currentWeather?.temperature?.round()}º',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 32),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: SvgPicture.asset(
                                          getWeatherIcon(
                                              weather
                                                  .currentWeather?.weathercode,
                                              isDay: weather
                                                      .currentWeather?.isDay ==
                                                  1),
                                          height: 60,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Aujourd'hui, le temps est ",
                                      style: TextStyle(
                                        // Replace with your desired primary color
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "${getWeatherCondition(weather.currentWeather?.weathercode)}.",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                      text: "Il y aura une minimale de ",
                                      style: TextStyle(
                                        // Replace with your desired primary color
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "${weather.daily?.days?.first.apparentTemperatureMin}°C ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: primaryColor,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "et un maximum de de ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            // color: primaryColor,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "${weather.daily?.days?.first.apparentTemperatureMax}°C ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ...List.generate(weather.hourly?.days?.length ?? 0,
                              (index) {
                            List<HourlyUnit> day =
                                weather.hourly?.days?[index] ?? [];
                            if (index == 0) {
                              day = day
                                  .where((element) =>
                                      (element.time?.hour ?? 0) >
                                      DateTime.now().hour)
                                  .toList();
                            }
                            if (day.isEmpty) return SizedBox();
                            return WeatherDayItem(
                              day:
                                  "${getWeekdayName(day.first.time ?? DateTime.now(), locale: 'fr')}",
                              minTemperature:
                                  '${weather.daily?.days![index].apparentTemperatureMax?.round() ?? '--'}',
                              maxTemperature:
                                  '${weather.daily?.days![index].apparentTemperatureMin?.round() ?? '--'}',
                              isSelected: index == selectedDay,
                              hours: day,
                              // Select the first day initially
                              onClick: () {
                                setState(() {
                                  selectedDay = index;
                                });
                              },
                            );
                          }),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                'Plus d\'infos',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: fontLightColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: DailyWeatherItem(
                                    title: 'Chances de pluie',
                                    subTitle:
                                        '${weather.daily?.days?.first.precipitationProbabilityMax ?? '--'}%',
                                    icon: 'assets/images/rain-drops-3.svg'),
                              ),
                              Expanded(
                                child: DailyWeatherItem(
                                    title: 'Taux d\'humidité',
                                    subTitle:
                                        '${weather.currentWeather?.temperature?.round()}º',
                                    icon: 'assets/images/rain.svg'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: DailyWeatherItem(
                                    title: 'Vent',
                                    subTitle:
                                        '${getWindDirection(weather.currentWeather?.winddirection?.round() ?? -1)} ${weather.currentWeather?.windspeed?.round()} km/h',
                                    icon: 'assets/images/windy-1.svg'),
                              ),
                              Expanded(
                                child: DailyWeatherItem(
                                    title: 'Température ressentie',
                                    subTitle:
                                        '${weather.currentWeather?.temperature?.round()}ºC',
                                    icon: 'assets/images/direction-1.svg'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      );
                    } else {
                      return CenterWidget(
                          child: const Text(
                              'Erreur lors du chargement des détails météo'));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<DateTime> filterList(List<DateTime> dateTimeList) {
  DateTime currentTime = DateTime.now();
  List<DateTime> filteredList =
      dateTimeList.where((dateTime) => dateTime.isAfter(currentTime)).toList();
  return filteredList;
}

// class WeatherScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 5,
//       itemBuilder: (context, index) {
//         return WeatherDayItem(
//           hours: [],
//           day: "Day ${index + 1}",
//           minTemperature: 20,
//           maxTemperature: 30,
//           isSelected: index == 0, // Select the first day initially
//         );
//       },
//     );
//   }
// }

class WeatherDayItem extends StatefulWidget {
  final String day;
  final String minTemperature;
  final String maxTemperature;
  final bool isSelected;
  final dynamic onClick;
  final List<HourlyUnit> hours;

  const WeatherDayItem({
    required this.day,
    required this.minTemperature,
    required this.maxTemperature,
    required this.isSelected,
    this.onClick,
    required this.hours,
  });

  @override
  _WeatherDayItemState createState() => _WeatherDayItemState();
}

class _WeatherDayItemState extends State<WeatherDayItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(children: [
                Text(
                  widget.day,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: fontLightColor),
                ),
                Spacer(),
                Text(
                  "${widget.minTemperature}°",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "${widget.maxTemperature}°",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: fontLightColor),
                ),
              ]),
            ),
            if (widget.isSelected)
              Container(
                // color: Colors.white,
                margin: EdgeInsets.only(right: 0),
                padding: EdgeInsets.only(right: 6, top: 6, bottom: 6),
                child: Container(
                  height: 110,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(widget.hours.length, (i) {
                      HourlyUnit unit = widget.hours[i];
                      return HourlyWeatherItem(
                        hour: '${unit.time?.hour ?? ''}',
                        temperature:
                            '${unit.apparentTemperature?.round() ?? '--'}',
                        icon: getWeatherIcon(unit.weathercode,
                            isDay: (unit.time?.hour ?? 0) >= 6 &&
                                (unit.time?.hour ?? 0) <= 18),
                        elevated: i == 0 ? true : false,
                      );
                    }),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HourlyWeatherItem extends StatelessWidget {
  final String hour;
  final String temperature;
  final String icon;
  final bool elevated;

  const HourlyWeatherItem({
    required this.hour,
    required this.temperature,
    required this.icon,
    this.elevated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color:
          elevated ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
      elevation: elevated ? null : 0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: Column(
          children: [
            Text('${hour}h',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
            SizedBox(height: 8),
            SvgPicture.asset(
              '$icon',
              color: Colors.black,
              height: 34,
              // color: primaryColor,
            ),
            SizedBox(height: 8),
            Text("$temperature°",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: primaryColor)),
          ],
        ),
      ),
    );
  }
}

class DailyWeatherItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String icon;

  // final bool elevated;

  const DailyWeatherItem({
    required this.title,
    required this.subTitle,
    required this.icon,
    // this.elevated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      // color:
      // elevated ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
      // elevation: elevated ? null : 0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: Column(
          children: [
            Text('${title}',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
            SizedBox(height: 12),
            SvgPicture.asset(
              '$icon',
              color: Colors.black,
              height: 54,
              // color: primaryColor,
            ),
            SizedBox(height: 12),
            Text("$subTitle",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: primaryColor)),
          ],
        ),
      ),
    );
  }
}
