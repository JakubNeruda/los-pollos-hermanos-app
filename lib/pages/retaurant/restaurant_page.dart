import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/restaurant.dart';
import 'package:los_pollos_hermanos/services/generic_service.dart';
import 'package:los_pollos_hermanos/widgets/restaurant/restaurant_item.dart';

class RestaurantPage extends StatelessWidget {
  final _restaurantService = GetIt.instance.get<GenericService<Restaurant>>();

  RestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).viewPadding.top),
        Expanded(
          child: Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: StreamBuilder<List<Restaurant>>(
              stream: _restaurantService.listStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final items = snapshot.data!;
                if (items.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Restaurants.',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) =>
                      RestaurantItem(restaurant: items[index]),
                  itemCount: items.length,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
