import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programmation_mobile/blocs/city_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:programmation_mobile/screens/city_list_screen.dart';
import 'package:programmation_mobile/screens/widgets/center_widget.dart';

import '../blocs/city_detail_bloc.dart';
import '../blocs/city_list_bloc.dart';
import 'city_detail_screen.dart';

class CitySearchScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

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
                  'Ajouter une ville',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                // Spacer(),
                // TextButton(
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => CityListScreen()));
                //     },
                //     child: Text('Liste des villes'))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: IconButton(
                  onPressed: () {
                    if (controller.text.isEmpty) return;
                    FocusScope.of(context).unfocus();
                    BlocProvider.of<CitySearchBloc>(context, listen: false).add(
                      CitySearchRequested(cityName: controller.text),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                  ),
                ),
                hintText: 'Saisissez le nom d\'une ville',
              ),
              onSubmitted: (value) {
                if (value.isEmpty) return;

                BlocProvider.of<CitySearchBloc>(context, listen: false).add(
                  CitySearchRequested(cityName: value),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<CitySearchBloc, CitySearchState>(
                builder: (context, state) {
                  if (state is CitySearchLoading) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: const CircularProgressIndicator()),
                      ],
                    );
                  } else if (state is CitySearchSuccess) {
                    return ListView.separated(
                      itemCount: state.cities.length,
                      itemBuilder: (context, index) {
                        final city = state.cities[index];
                        return ListTile(
                          title: Text('${city.name}, ${city.country}'),
                          // Replace with SVG icon
                          onTap: () {
                            controller.text = '';
                            // Dispatch the CityListAdd event
                            BlocProvider.of<CityListBloc>(context)
                                .add(CityListAdd(city: city));
                            BlocProvider.of<CityDetailBloc>(context,
                                    listen: false)
                                .add(
                              CityDetailLoad(city: city),
                            );
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    CityDetailScreen(city: city)));
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    );
                  } else if (state is CitySearchInitial) {
                    return CenterWidget(
                        child: const Text('Rechercher la ville'));
                  } else {
                    return CenterWidget(child: Text('Erreur lors du chargement des villes'));
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
