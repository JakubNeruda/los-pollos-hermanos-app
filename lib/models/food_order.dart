import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:los_pollos_hermanos/models/basket_product.dart';
import 'package:los_pollos_hermanos/util/utils.dart';

part 'food_order.g.dart';

@JsonSerializable()
class FoodOrder {
  final String? id;
  final bool? isDelivery;
  final String? address;
  final String? restaurantId;
  final List<String> couponIDs;
  @JsonKey(toJson: productBasketToJson)
  final List<BasketProduct> productBasket;
  final double? sumPrice;
  @JsonKey(fromJson: Utils.dateFromJson, toJson: Utils.dateToJson)
  final DateTime createdAt;

  const FoodOrder({
    this.id,
    required this.isDelivery,
    this.address,
    this.restaurantId,
    required this.couponIDs,
    required this.productBasket,
    this.sumPrice,
    required this.createdAt,
  });

  FoodOrder copyWith({
    String? id,
    bool? isDelivery,
    String? address,
    String? restaurantId,
    List<String>? couponIDs,
    List<BasketProduct>? productBasket,
    double? sumPrice,
    DateTime? createdAt,
  }) {
    return FoodOrder(
      id: id ?? this.id,
      isDelivery: isDelivery ?? this.isDelivery,
      address: address ?? this.address,
      restaurantId: restaurantId ?? this.restaurantId,
      couponIDs: couponIDs ?? this.couponIDs,
      productBasket: productBasket ?? this.productBasket,
      sumPrice: sumPrice ?? this.sumPrice,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory FoodOrder.fromJson(Map<String, dynamic> json) =>
      _$FoodOrderFromJson(json);

  Map<String, dynamic> toJson() => _$FoodOrderToJson(this);

  double calculatePriceOfProducts() {
    double result = 0;
    for (BasketProduct p in productBasket) {
      result += p.price * p.amount;
    }
    return result;
  }

  static Iterable<Map<String, dynamic>> productBasketToJson(
          List<BasketProduct> productBasket) =>
      productBasket.map((e) => e.toJson());

  static FoodOrder getEmptyOrder(DateTime? datetime) {
    return FoodOrder(
        isDelivery: null,
        couponIDs: [],
        productBasket: [],
        createdAt: datetime ?? DateTime.fromMicrosecondsSinceEpoch(0));
  }
}
