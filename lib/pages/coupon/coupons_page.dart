import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/coupon.dart';
import 'package:los_pollos_hermanos/models/food_order.dart';
import 'package:los_pollos_hermanos/models/registered_user.dart';
import 'package:los_pollos_hermanos/services/generic_service.dart';
import 'package:los_pollos_hermanos/services/logged_user_service.dart';
import 'package:los_pollos_hermanos/util/utils.dart';
import 'package:los_pollos_hermanos/widgets/coupon/coupon_item.dart';

class CouponsPage extends StatelessWidget {
  final FoodOrder? order;
  final userChangeStream = GetIt.instance.get<LoggedUserService>();
  final couponsService = GetIt.instance.get<GenericService<Coupon>>();

  CouponsPage({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).viewPadding.top),
        Expanded(
          child: Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: userChangeStream.currentUser == null
                ? const Center(
                    child: Text(
                    "Log in to see coupons",
                    style: TextStyle(fontSize: 30),
                  ))
                : StreamBuilder<RegisteredUser?>(
                    stream: userChangeStream.currentUserChanges,
                    builder: (context, snapshot) {
                      if (userChangeStream.currentUser == null ||
                          userChangeStream.currentUser!.coupons.isEmpty) {
                        return const Center(
                          child: Text(
                            "No coupons available",
                            style: TextStyle(fontSize: 30),
                          ),
                        );
                      }
                      return GridView.count(
                        padding: EdgeInsets.zero,
                        childAspectRatio: 2 / 2,
                        crossAxisCount: 2,
                        children: getCouponItems(),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  List<Widget> getCouponItems() {
    List<Widget> output = [];
    for (var couponId in userChangeStream.currentUser!.coupons) {
      var couponItem = FutureBuilder(
        future: couponsService.getItem(couponId),
        builder: (context, snapshot) {
          return Utils.checkAsyncSnapshotAndData(snapshot)
              ? CouponItem(coupon: snapshot.data!)
              : Container();
        },
      );
      output.add(couponItem);
    }
    return output;
  }
}
