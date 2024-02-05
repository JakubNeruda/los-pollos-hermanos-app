// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpeningHours _$OpeningHoursFromJson(Map<String, dynamic> json) => OpeningHours(
      monday: json['monday'] == null
          ? null
          : TimeInterval.fromJson(json['monday'] as Map<String, dynamic>),
      tuesday: json['tuesday'] == null
          ? null
          : TimeInterval.fromJson(json['tuesday'] as Map<String, dynamic>),
      wednesday: json['wednesday'] == null
          ? null
          : TimeInterval.fromJson(json['wednesday'] as Map<String, dynamic>),
      thursday: json['thursday'] == null
          ? null
          : TimeInterval.fromJson(json['thursday'] as Map<String, dynamic>),
      friday: json['friday'] == null
          ? null
          : TimeInterval.fromJson(json['friday'] as Map<String, dynamic>),
      saturday: json['saturday'] == null
          ? null
          : TimeInterval.fromJson(json['saturday'] as Map<String, dynamic>),
      sunday: json['sunday'] == null
          ? null
          : TimeInterval.fromJson(json['sunday'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OpeningHoursToJson(OpeningHours instance) =>
    <String, dynamic>{
      'monday': instance.monday?.toJson(),
      'tuesday': instance.tuesday?.toJson(),
      'wednesday': instance.wednesday?.toJson(),
      'thursday': instance.thursday?.toJson(),
      'friday': instance.friday?.toJson(),
      'saturday': instance.saturday?.toJson(),
      'sunday': instance.sunday?.toJson(),
    };
