// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      telephone: json['telephone'] as String?,
      email: json['email'] as String,
      openingHours:
          OpeningHours.fromJson(json['openingHours'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'telephone': instance.telephone,
      'email': instance.email,
      'openingHours': instance.openingHours.toJson(),
    };
