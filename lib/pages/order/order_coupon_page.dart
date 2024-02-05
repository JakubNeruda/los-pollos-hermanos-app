import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/basket_product.dart';
import 'package:los_pollos_hermanos/models/coupon.dart';
import 'package:los_pollos_hermanos/models/food_order.dart';
import 'package:los_pollos_hermanos/pages/order/order_category_page.dart';
import 'package:los_pollos_hermanos/services/generic_service.dart';
import 'package:los_pollos_hermanos/services/logged_user_service.dart';
import 'package:los_pollos_hermanos/widgets/coupon/coupon_item.dart';

class OrderCouponPage extends StatefulWidget {
  final _userChangeStream = GetIt.I.get<LoggedUserService>();
  final _couponService = GetIt.I.get<GenericService<Coupon>>();
  OrderCouponPage({super.key});

  @override
  State<OrderCouponPage> createState() => _OrderCouponPageState();
}

class _OrderCouponPageState extends State<OrderCouponPage> {
  final Map<String, Coupon> coupons = {};

  @override
  Widget build(BuildContext context) {
    FoodOrder order = widget._userChangeStream.currentUser!.openOrder;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Coupons"),
        actions: [
          ElevatedButton(
              onPressed: () {
                for (Coupon c in coupons.values) {
                  order.productBasket.add(BasketProduct(
                      name: c.name, price: c.price, amount: 1));
                }
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => OrderCategoryPage()));
              },
              child: const Text("Confirm")),
          const SizedBox(width: 10),
        ],
      ),
      body: _buildUserCoupons(order),
    );
  }

  Widget _buildUserCoupons(FoodOrder order) {
    if (widget._userChangeStream.currentUser!.coupons.isEmpty) {
      return const Center(
          child: Text(
        "No coupons",
        style: TextStyle(fontSize: 20),
      ));
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 8 / 7,
      ),
      itemBuilder: (BuildContext context, int index) {
        final id = widget._userChangeStream.currentUser!.coupons[index];
        return _couponBuilder(id, order);
      },
      itemCount: widget._userChangeStream.currentUser!.coupons.length,
    );
  }

  Widget _couponBuilder(String id, FoodOrder order) {
    return FutureBuilder<Coupon?>(
      future: widget._couponService.getItem(id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final coupon = snapshot.data!;
        return CouponItem(
          coupon: coupon,
          color: coupons.containsKey(id) ? Colors.amberAccent : null,
          onTap: () => setState(
            () {
              if (coupons.containsKey(id)) {
                coupons.remove(id);
              } else {
                coupons[id] = coupon;
              }
            },
          ),
        );
      },
    );
  }
}
