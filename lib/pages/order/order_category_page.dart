import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/category.dart';
import 'package:los_pollos_hermanos/models/food_order.dart';
import 'package:los_pollos_hermanos/pages/order/basket_page.dart';
import 'package:los_pollos_hermanos/services/generic_service.dart';
import 'package:los_pollos_hermanos/widgets/menu/menu_item.dart';

import '../../services/logged_user_service.dart';

class OrderCategoryPage extends StatefulWidget {
  final _userChangeStream = GetIt.instance.get<LoggedUserService>();

  OrderCategoryPage({super.key});

  @override
  State<OrderCategoryPage> createState() => _OrderCategoryPageState();
}

class _OrderCategoryPageState extends State<OrderCategoryPage> {
  final _categoryService = GetIt.instance.get<GenericService<Category>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Products"),
        actions: [
          ElevatedButton(
              onPressed: () {
                FoodOrder order =
                    widget._userChangeStream.currentUser!.openOrder;
                widget._userChangeStream.openOrderChange(order.copyWith(
                  sumPrice:
                      (order.sumPrice ?? 0) + order.calculatePriceOfProducts(),
                ));
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => BasketPage()));
              },
              child: const Text("To cart")),
          const SizedBox(width: 10),
        ],
      ),
      body: StreamBuilder<List<Category>>(
        stream: _categoryService.listStream,
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
                'No Products.',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 8 / 7,
            ),
            itemBuilder: (BuildContext context, int index) =>
                MenuItem(item: items[index]),
            itemCount: items.length,
          );
        },
      ),
    );
  }
}
