import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:los_pollos_hermanos/util/time_of_day_convertor.dart';

part 'time_interval.g.dart';

@JsonSerializable(explicitToJson: true)
class TimeInterval {
  @TimeOfDayConvertor()
  final TimeOfDay start;
  @TimeOfDayConvertor()
  final TimeOfDay end;

  const TimeInterval({required this.start, required this.end});

  factory TimeInterval.fromJson(Map<String, dynamic> json) =>
      _$TimeIntervalFromJson(json);

  Map<String, dynamic> toJson() => _$TimeIntervalToJson(this);
}
