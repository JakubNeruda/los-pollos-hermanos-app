import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/food_order.dart';
import 'package:los_pollos_hermanos/models/restaurant.dart';
import 'package:los_pollos_hermanos/pages/order/order_coupon_page.dart';
import 'package:los_pollos_hermanos/services/generic_service.dart';
import 'package:los_pollos_hermanos/util/utils.dart';
import 'package:los_pollos_hermanos/widgets/restaurant/restaurant_item.dart';

import '../../services/logged_user_service.dart';

class OrderRestaurantPage extends StatefulWidget {
  final _userChangeStream = GetIt.instance.get<LoggedUserService>();
  OrderRestaurantPage({super.key});

  @override
  State<OrderRestaurantPage> createState() => _OrderRestaurantPageState();
}

class _OrderRestaurantPageState extends State<OrderRestaurantPage> {
  final _restaurantService = GetIt.instance.get<GenericService<Restaurant>>();
  String? selectedRestaurantId;

  @override
  Widget build(BuildContext context) {
    FoodOrder order = widget._userChangeStream.currentUser!.openOrder;
    return WillPopScope(
      onWillPop: () => Utils.showOrderExitConfirmationDialog(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Select restaurant"),
          actions: [
            ElevatedButton(
                onPressed: selectedRestaurantId == null
                    ? null
                    : () {
                        widget._userChangeStream.openOrderChange(
                            order.copyWith(restaurantId: selectedRestaurantId, sumPrice: 0));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => OrderCouponPage()));
                      },
                child: const Text("Confirm")),
            const SizedBox(width: 10),
          ],
        ),
        body: StreamBuilder<List<Restaurant>>(
          stream: _restaurantService.listStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final List<Restaurant> items = snapshot.data!;
            if (items.isEmpty) {
              return const Center(
                child: Text(
                  'No Restaurants.',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () => setState(() => selectedRestaurantId =
                    items[index].isOpened() &&
                            selectedRestaurantId != items[index].id
                        ? items[index].id
                        : null),
                child: RestaurantItem(
                  restaurant: items[index],
                  color: items[index].isOpened()
                      ? selectedRestaurantId == items[index].id
                          ? Colors.amberAccent
                          : null
                      : Colors.grey,
                ),
              ),
              itemCount: items.length,
            );
          },
        ),
      ),
    );
  }
}
