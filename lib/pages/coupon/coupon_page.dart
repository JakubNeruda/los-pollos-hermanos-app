import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../models/coupon.dart';

class CouponPage extends StatelessWidget {
  final Coupon coupon;

  const CouponPage({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    final expiration = coupon.expiration;
    final expirationString = expiration != null
        ? 'Expiration: ${DateFormat("dd.MM.yyyy").format(coupon.expiration!)}'
        : 'No expiration date';
    final ah = coupon.applicableHours;
    final applicableString = ah != null
        ? 'Applicable from ${ah.start.format(context)} to ${ah.end.format(context)}'
        : "Applicable throughout opening hours";
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(
                    image: CachedNetworkImageProvider(
                      coupon.imageURL,
                      maxHeight:
                          (MediaQuery.of(context).size.height / 3.5).round(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    coupon.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "${coupon.price.toStringAsFixed(2)} Kč",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      coupon.description,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  QrImageView(
                    data: coupon.id ?? "0",
                    version: QrVersions.auto,
                    size: MediaQuery.of(context).size.height / 4,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: ElevatedButton(
              onPressed: () => (), // show qr code on pressed
              child: const Text("Delivery"),
            ),
          ),
          Text(applicableString),
          Text(expirationString),
        ],
      ),
    );
  }
}
