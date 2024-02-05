// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageURL: json['imageURL'] as String,
      expiration: Utils.dateFromJsonNullable(json['expiration'] as Timestamp?),
      applicableHours: json['applicableHours'] == null
          ? null
          : TimeInterval.fromJson(
              json['applicableHours'] as Map<String, dynamic>),
      productIDs: (json['productIDs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'imageURL': instance.imageURL,
      'expiration': Utils.dateToJsonNullable(instance.expiration),
      'applicableHours': instance.applicableHours,
      'productIDs': instance.productIDs,
    };
