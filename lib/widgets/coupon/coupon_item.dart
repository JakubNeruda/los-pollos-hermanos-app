import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:los_pollos_hermanos/models/coupon.dart';
import 'package:los_pollos_hermanos/pages/coupon/coupon_page.dart';
import 'package:los_pollos_hermanos/util/image_util.dart';

class CouponItem extends StatelessWidget {
  final Coupon coupon;
  final Color? color;
  final VoidCallback? onTap;

  const CouponItem({super.key, required this.coupon, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: InkWell(
        onTap: onTap ??
            () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CouponPage(coupon: coupon),
                )),
        child: buildColumn(),
      ),
    );
  }

  Widget buildColumn() {
    List<Widget> output = [
      const SizedBox(height: 10),
      Expanded(
        child: Ink(
          color: Colors.white,
          child: buildImage(coupon.imageURL),
        ),
      ),
      Text(coupon.name, textAlign: TextAlign.center),
      Text(
        "${coupon.price.toStringAsFixed(2)} Kč",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ];
    if (coupon.expiration != null) {
      output.add(const Divider());
      output.add(
        Text(
          "expiration: ${DateFormat("dd.MM.yyyy").format(coupon.expiration!)}",
          textAlign: TextAlign.center,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: output,
    );
  }
}
