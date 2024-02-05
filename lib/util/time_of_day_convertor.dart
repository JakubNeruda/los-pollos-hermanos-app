import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class TimeOfDayConvertor implements JsonConverter<TimeOfDay, String?> {
  const TimeOfDayConvertor();

  @override
  fromJson(String? json) {
    final list = json?.split(':');
    return TimeOfDay(
      hour: int.tryParse(list?[0] ?? '') ?? -1,
      minute: int.tryParse(list?[1] ?? '') ?? -1,
    );
  }

  @override
  String? toJson(TimeOfDay tod) {
    return '${tod.hour}:${tod.minute}';
  }
}
