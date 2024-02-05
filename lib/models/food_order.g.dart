// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodOrder _$FoodOrderFromJson(Map<String, dynamic> json) => FoodOrder(
      id: json['id'] as String?,
      isDelivery: json['isDelivery'] as bool?,
      address: json['address'] as String?,
      restaurantId: json['restaurantId'] as String?,
      couponIDs:
          (json['couponIDs'] as List<dynamic>).map((e) => e as String).toList(),
      productBasket: (json['productBasket'] as List<dynamic>)
          .map((e) => BasketProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      sumPrice: (json['sumPrice'] as num?)?.toDouble(),
      createdAt: Utils.dateFromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$FoodOrderToJson(FoodOrder instance) => <String, dynamic>{
      'id': instance.id,
      'isDelivery': instance.isDelivery,
      'address': instance.address,
      'restaurantId': instance.restaurantId,
      'couponIDs': instance.couponIDs,
      'productBasket': FoodOrder.productBasketToJson(instance.productBasket),
      'sumPrice': instance.sumPrice,
      'createdAt': Utils.dateToJson(instance.createdAt),
    };
