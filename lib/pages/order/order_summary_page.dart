import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:los_pollos_hermanos/models/basket_product.dart';
import 'package:los_pollos_hermanos/models/food_order.dart';

class OrderSummaryPage extends StatelessWidget {
  final FoodOrder order;

  const OrderSummaryPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
                "Created at: ${DateFormat("MM.dd. kk:mm").format(order.createdAt)}"),
            Text("Total: ${order.calculatePriceOfProducts()} Kč"),
            const Center(child: Text("Items")),
            Flexible(
              child: ListView.builder(
                itemCount: order.productBasket.length,
                itemBuilder: (context, index) =>
                    buildProductTile(order.productBasket[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductTile(BasketProduct item) {
    return Row(
      children: [
        Text(item.name),
        const Spacer(),
        Text("${item.amount} (${item.price}kč)"),
      ],
    );
  }
}
