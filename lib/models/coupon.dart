import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:los_pollos_hermanos/models/time_interval.dart';
import 'package:los_pollos_hermanos/util/utils.dart';

part 'coupon.g.dart';

@JsonSerializable()
class Coupon {
  final String? id;
  final String name;
  final String description;
  final double price;
  final String imageURL;
  @JsonKey(
      fromJson: Utils.dateFromJsonNullable, toJson: Utils.dateToJsonNullable)
  final DateTime? expiration;
  final TimeInterval? applicableHours;
  final List<String> productIDs;

  const Coupon(
      {this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageURL,
      this.expiration,
      this.applicableHours,
      required this.productIDs});

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
