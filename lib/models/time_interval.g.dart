// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_interval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeInterval _$TimeIntervalFromJson(Map<String, dynamic> json) => TimeInterval(
      start: const TimeOfDayConvertor().fromJson(json['start'] as String?),
      end: const TimeOfDayConvertor().fromJson(json['end'] as String?),
    );

Map<String, dynamic> _$TimeIntervalToJson(TimeInterval instance) =>
    <String, dynamic>{
      'start': const TimeOfDayConvertor().toJson(instance.start),
      'end': const TimeOfDayConvertor().toJson(instance.end),
    };
