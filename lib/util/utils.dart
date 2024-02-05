import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/coupon.dart';
import 'package:los_pollos_hermanos/models/registered_user.dart';
import 'package:los_pollos_hermanos/services/generic_service.dart';
import 'package:los_pollos_hermanos/services/logged_user_service.dart';

final class Utils {
  static bool isNullOrEmpty(String? string) {
    return string == null || string.isEmpty;
  }

  static checkSnapshotAndData(DocumentSnapshot snapshot) =>
      snapshot.exists && snapshot.data() != null;

  static checkAsyncSnapshotAndData(AsyncSnapshot snapshot) =>
      !snapshot.hasError && snapshot.hasData;

  static DateTime dateFromJson(Timestamp timestamp) => timestamp.toDate();
  static Timestamp dateToJson(DateTime dateTime) =>
      Timestamp.fromDate(dateTime);

  static DateTime? dateFromJsonNullable(Timestamp? timestamp) =>
      timestamp?.toDate();
  static Timestamp? dateToJsonNullable(DateTime? dateTime) =>
      dateTime != null ? Timestamp.fromDate(dateTime) : null;

  static showErrorDialog(BuildContext context, String error) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(error),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  static Future cleanupRoutine() async {
    final currentUser = GetIt.instance.get<LoggedUserService>().currentUser;
    final userService = GetIt.instance.get<GenericService<RegisteredUser>>();
    final couponService = GetIt.instance.get<GenericService<Coupon>>();
    if (currentUser == null) return;
    List<String> coupons = [];
    for (var couponId in currentUser.coupons) {
      Coupon? coupon = await couponService.getItem(couponId);
      if (coupon == null ||
          coupon.id == null ||
          (coupon.expiration != null &&
              coupon.expiration!.compareTo(DateTime.now()) < 1)) continue;
      coupons.add(coupon.id!);
    }
    var updatedUser = RegisteredUser(
      firstName: currentUser.firstName,
      surname: currentUser.surname,
      email: currentUser.email,
      phoneNumber: currentUser.phoneNumber,
      addresses: currentUser.addresses,
      coupons: coupons,
      orders: currentUser.orders,
      openOrder: currentUser.openOrder,
    );
    userService.update(currentUser.id, updatedUser);
  }

  static Future<bool> showOrderExitConfirmationDialog(
      BuildContext context) async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Warning'),
        content: Text('Are you sure you want to cancel your order?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context)
                .pop(false), // Dismiss the dialog but don't pop the page.
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context)
                .pop(true), // Dismiss the dialog and pop the page.
            child: Text('Yes'),
          ),
        ],
      ),
    );

    return shouldPop ??
        false; // If the dialog is dismissed by tapping outside, don't pop the page.
  }

  static showPillNotification(BuildContext context, String text) {
    final snackBar = SnackBar(
      backgroundColor: Colors.grey,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
