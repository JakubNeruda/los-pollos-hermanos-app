import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/food_order.dart';
import 'package:los_pollos_hermanos/services/generic_service.dart';
import 'package:los_pollos_hermanos/services/logged_user_service.dart';

import '../../util/utils.dart';

class BasketPage extends StatefulWidget {
  final _userChangeStream = GetIt.instance.get<LoggedUserService>();

  final orderService = GetIt.instance.get<GenericService<FoodOrder>>();

  BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    FoodOrder order = widget._userChangeStream.currentUser!.openOrder;
    widget._userChangeStream.openOrderChange(order.copyWith(
      sumPrice: order.calculatePriceOfProducts(),
    ));
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    return StreamBuilder(
      stream: widget._userChangeStream.currentUserChanges,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Product (Price)",
                      style: style,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Amount", style: style),
                  ],
                ),
                const SizedBox(height: 10),
                buildProductListview(order),
                Text(
                  "Total: ${order.calculatePriceOfProducts()} Kč",
                  style: style,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: order.couponIDs.isEmpty &&
                          order.productBasket.isEmpty
                      ? null
                      : () {
                          final docRef = widget.orderService.createReference();
                          final newOrder = order.copyWith(
                            id: docRef.id,
                            createdAt: DateTime.now(),
                          );
                          widget.orderService.add(newOrder, newOrder.id);
                          widget._userChangeStream.addOrder(newOrder);
                          Utils.showPillNotification(
                              context, 'Order has been placed!');
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        },
                  child: const Text("Place order"),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildProductListview(FoodOrder order) {
    Widget productList = ListView.builder(
      shrinkWrap: true,
      itemCount: order.productBasket.length,
      itemBuilder: (context, index) => Row(
        children: [
          Text(
              "${order.productBasket[index].name} (${order.productBasket[index].price}kč)"),
          const Spacer(),
          IconButton(
              onPressed: () {
                var newBasket = order.productBasket;
                if (order.productBasket[index].amount > 1) {
                  newBasket[index] = order.productBasket[index]
                      .copyWith(amount: order.productBasket[index].amount - 1);
                } else {
                  newBasket.removeAt(index);
                }
                if (order.productBasket.isEmpty) {
                  Navigator.of(context).pop();
                }
                widget._userChangeStream
                    .openOrderChange(order.copyWith(productBasket: newBasket));
              },
              icon: const Icon(Icons.remove)),
          Text(order.productBasket[index].amount.toString()),
          IconButton(
              onPressed: () {
                var newBasket = order.productBasket;
                newBasket[index] = order.productBasket[index]
                    .copyWith(amount: order.productBasket[index].amount + 1);
                widget._userChangeStream
                    .openOrderChange(order.copyWith(productBasket: newBasket));
              },
              icon: const Icon(Icons.add)),
        ],
      ),
    );
    return productList;
  }
}
