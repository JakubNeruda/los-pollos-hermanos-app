import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/food_order.dart';
import 'package:los_pollos_hermanos/models/registered_user.dart';
import 'package:los_pollos_hermanos/pages/order/order_coupon_page.dart';
import 'package:los_pollos_hermanos/services/logged_user_service.dart';
import 'package:los_pollos_hermanos/widgets/other/add_address_dialog.dart';

import '../../util/utils.dart';

class OrderAddressPage extends StatefulWidget {
  final _userChangeStream = GetIt.instance.get<LoggedUserService>();

  OrderAddressPage({super.key});

  @override
  State<OrderAddressPage> createState() => _OrderAddressPageState();
}

class _OrderAddressPageState extends State<OrderAddressPage> {
  String? selectedAddress;

  @override
  Widget build(BuildContext context) {
    RegisteredUser currentUser = widget._userChangeStream.currentUser!;
    FoodOrder order = currentUser.openOrder;
    return WillPopScope(
      onWillPop: () => Utils.showOrderExitConfirmationDialog(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Select address"),
          actions: [
            ElevatedButton(
                onPressed: selectedAddress == null
                    ? null
                    : () {
                        widget._userChangeStream.openOrderChange(order.copyWith(
                            address: selectedAddress, isDelivery: true, sumPrice: 0));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => OrderCouponPage()));
                      },
                child: const Text("Confirm")),
            const SizedBox(width: 10),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: StreamBuilder(
                stream: widget._userChangeStream.currentUserChanges,
                builder: (context, snapshot) {
                  currentUser = widget._userChangeStream.currentUser!;
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: currentUser.addresses.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              title: Text(currentUser.addresses[index]),
                              selected:
                                  currentUser.addresses[index] == selectedAddress,
                              selectedColor: Colors.black,
                              selectedTileColor: Colors.amberAccent,
                              tileColor: Colors.white,
                              onTap: () {
                                setState(() {
                                  selectedAddress =
                                      currentUser.addresses[index] ==
                                              selectedAddress
                                          ? null
                                          : currentUser.addresses[index];
                                });
                              },
                            ),
                      ));
                },
              ),
            ),
            ElevatedButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddAddressDialog(user: currentUser);
                    }),
                child: const Text(
                  "Add address",
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    );
  }
}
