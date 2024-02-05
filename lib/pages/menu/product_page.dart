import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/basket_product.dart';
import 'package:los_pollos_hermanos/models/food_order.dart';
import 'package:los_pollos_hermanos/models/product.dart';

import '../../services/logged_user_service.dart';
import '../../util/utils.dart';

class ProductPage extends StatelessWidget {
  final _userChangeStream = GetIt.instance.get<LoggedUserService>();
  final Product product;

  ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    FoodOrder order = _userChangeStream.currentUser!.openOrder;
    final addButton = (order.restaurantId != null || order.address != null)
        ? <Widget>[
            const Expanded(child: SizedBox()),
            ElevatedButton(
              onPressed: () {
                if (order.productBasket
                    .any((element) => element.name == product.name)) {
                  List<BasketProduct> actualBasket = [];
                  for (var p in order.productBasket) {
                    if (p.name == product.name) {
                      p = p.copyWith(amount: p.amount + 1);
                    }
                    actualBasket.add(p);
                  }
                  order = order.copyWith(productBasket: actualBasket);
                } else {
                  order.productBasket.add(BasketProduct(
                      name: product.name, price: product.price, amount: 1));
                }
                _userChangeStream.openOrderChange(order);
                Utils.showPillNotification(context, 'Added to cart');
                Navigator.pop(context);
              },
              child: const Text("Add to cart"),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 10),
          ]
        : [];

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: CachedNetworkImageProvider(
                product.imageURL,
                maxHeight: (MediaQuery.of(context).size.height / 2).round(),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              product.name,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Price: ${product.price.toStringAsFixed(2)} Kč",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.description,
                textAlign: TextAlign.center,
              ),
            ),
            Text("Allergens: ${product.allergens.join(", ")}"),
            ...addButton,
          ],
        ),
      ),
    );
  }
}
