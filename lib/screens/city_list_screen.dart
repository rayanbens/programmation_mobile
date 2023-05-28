// Dans city_list_screen.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:programmation_mobile/blocs/city_list_bloc.dart';
import 'package:programmation_mobile/models/city.dart';
import 'package:programmation_mobile/screens/city_detail_screen.dart';
import 'package:programmation_mobile/screens/widgets/center_widget.dart';

import '../blocs/city_detail_bloc.dart';
import '../constants.dart';
import '../helpers.dart';
import 'city_search_screen.dart';

class CityListScreen extends StatefulWidget {
  CityListScreen({Key? key}) : super(key: key);

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  final TextEditingController controller = TextEditingController();

  fetchData() {
    // Access the CityListBloc instance
    final cityListBloc = BlocProvider.of<CityListBloc>(context);

    // Dispatch the CityListLoad event to trigger the API request
    cityListBloc.add(CityListLoad());
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchData();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Mes Villes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CitySearchScreen()));
                    fetchData();
                  },
                  icon: Icon(
                    Icons.add,
                    size: 35,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<CityListBloc, CityListState>(
                builder: (context, state) {
                  // log('MK: city sear')
                  if (state is CityListLoading) {
                    return CenterWidget(child: CircularProgressIndicator());
                  } else if (state is CityListSuccess) {
                    if (state.cities.length == 0) {
                      return CenterWidget(
                          child: Text(
                        'Aucun résultat',
                      ));
                    }
                    return ListView.builder(
                      itemCount: state.cities.length,
                      itemBuilder: (context, index) {
                        final city = state.cities[index];
                        return CityListItem(city: city);
                      },
                    );
                  } else {
                    return CenterWidget(
                        child:
                            const Text('Erreur lors du chargement des villes'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CityListItem extends StatelessWidget {
  const CityListItem({
    super.key,
    required this.city,
  });

  final City city;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<CityDetailBloc>(context, listen: false).add(
          CityDetailLoad(city: city),
        );
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CityDetailScreen(city: city)));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 28),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${city.name}, ${city.country}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        '${city.weather?.currentWeather?.temperature?.round() ?? '--'}º',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 38),
                      ),
                      Text(
                        '${getWeatherCondition(city.weather?.currentWeather?.weathercode)}',
                        style: TextStyle(color: fontLightColor, fontSize: 18),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    getWeatherIcon(city.weather?.currentWeather?.weathercode,
                        isDay: (city.weather?.currentWeather?.isDay ?? 1) == 1),
                    // color:,
                    height: 66,
                    color: primaryColor,
                  ),
                ],
              ),
              SizedBox(
                height: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
