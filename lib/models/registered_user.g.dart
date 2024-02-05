// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registered_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisteredUser _$RegisteredUserFromJson(Map<String, dynamic> json) =>
    RegisteredUser(
      id: json['id'] as String?,
      firstName: json['firstName'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      addresses:
          (json['addresses'] as List<dynamic>).map((e) => e as String).toList(),
      coupons:
          (json['coupons'] as List<dynamic>).map((e) => e as String).toList(),
      orders:
          (json['orders'] as List<dynamic>).map((e) => e as String).toList(),
      openOrder: FoodOrder.fromJson(json['openOrder'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisteredUserToJson(RegisteredUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'surname': instance.surname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'addresses': instance.addresses,
      'coupons': instance.coupons,
      'orders': instance.orders,
      'openOrder': RegisteredUser.foodOrderToJson(instance.openOrder),
    };
