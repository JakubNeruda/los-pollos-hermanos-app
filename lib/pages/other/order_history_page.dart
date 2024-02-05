import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/food_order.dart';
import 'package:los_pollos_hermanos/services/generic_service.dart';
import 'package:los_pollos_hermanos/services/logged_user_service.dart';
import 'package:los_pollos_hermanos/util/utils.dart';
import 'package:los_pollos_hermanos/widgets/order/order_item.dart';

class OrdersPage extends StatelessWidget {
  final userChangeStream = GetIt.instance.get<LoggedUserService>();
  final ordersService = GetIt.instance.get<GenericService<FoodOrder>>();
  OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: StreamBuilder(
        stream: userChangeStream.currentUserChanges,
        builder: (context, snapshot) {
          if (userChangeStream.currentUser == null ||
              userChangeStream.currentUser!.orders.isEmpty) {
            return const Center(
              child: Text(
                'No orders in history.',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          return ListView(
            padding: EdgeInsets.zero,
            children: getOrderItems(),
          );
        },
      ),
    );
  }

  List<Widget> getOrderItems() {
    List<Widget> output = [];
    for (var orderId in userChangeStream.currentUser!.orders) {
      var orderItem = FutureBuilder(
        future: ordersService.getItem(orderId),
        builder: (context, snapshot) {
          return Utils.checkAsyncSnapshotAndData(snapshot)
              ? OrderItem(order: snapshot.data!)
              : Container();
        },
      );
      output.add(orderItem);
    }
    return output;
  }
}
