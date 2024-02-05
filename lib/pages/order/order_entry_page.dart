import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/registered_user.dart';
import 'package:los_pollos_hermanos/pages/order/order_address_page.dart';
import 'package:los_pollos_hermanos/pages/order/order_restaurant_page.dart';
import 'package:los_pollos_hermanos/services/logged_user_service.dart';

import '../../models/food_order.dart';

class OrderEntryPage extends StatelessWidget {
  final userChangeStream = GetIt.instance.get<LoggedUserService>();
  OrderEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: StreamBuilder<RegisteredUser?>(
          stream: userChangeStream.currentUserChanges,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildContent(context),
            );
          }),
    );
  }

  List<Widget> buildContent(BuildContext context) {
    List<Widget> list = [];
    list.add(Flexible(
      flex: 3,
      child: Image.asset("assets/logo.png"),
    ));
    if (userChangeStream.currentUser == null) {
      list.add(Expanded(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Please sign in to place an order",
                      style: TextStyle(fontSize: 30),
                    ),
                  )))));
      return list;
    }
    list.add(_orderButton(false, context));
    list.add(_orderButton(true, context));
    return list;
  }

  Widget _orderButton(bool pickup, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
        child: ElevatedButton(
          onPressed: () {
            cleanOpenOrder(DateTime.now());
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                      builder: (_) =>
                          pickup ? OrderRestaurantPage() : OrderAddressPage()),
                )
                .then((_) => cleanOpenOrder(null));
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.amberAccent),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          child: Text(
            pickup ? "Pickup" : "Delivery",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void cleanOpenOrder(DateTime? datetime) {
    if (userChangeStream.currentUser!.openOrder !=
        FoodOrder.getEmptyOrder(null)) {
      userChangeStream.openOrderChange(FoodOrder.getEmptyOrder(datetime));
    }
  }
}
