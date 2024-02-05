// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketProduct _$BasketProductFromJson(Map<String, dynamic> json) =>
    BasketProduct(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$BasketProductToJson(BasketProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
    };
