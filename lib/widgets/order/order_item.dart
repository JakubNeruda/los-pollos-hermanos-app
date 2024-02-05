import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:los_pollos_hermanos/models/food_order.dart';
import 'package:los_pollos_hermanos/pages/order/order_summary_page.dart';

class OrderItem extends StatelessWidget {
  final FoodOrder order;

  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Card(
        color: Colors.white,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 50),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderSummaryPage(order: order)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                child: Row(
                  children: [
                    Text(
                      "Total: ${order.calculatePriceOfProducts()}kč",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      DateFormat("MM.dd. kk:mm").format(order.createdAt),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
