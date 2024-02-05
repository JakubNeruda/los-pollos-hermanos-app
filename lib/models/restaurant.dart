import 'package:json_annotation/json_annotation.dart';
import 'package:los_pollos_hermanos/models/time_interval.dart';

import 'opening_hours.dart';

part 'restaurant.g.dart';

@JsonSerializable(explicitToJson: true)
class Restaurant {
  final String? id;
  final String name;
  final String description;
  final String? telephone;
  final String email;
  final OpeningHours openingHours;

  const Restaurant(
      {this.id,
      required this.name,
      required this.description,
      this.telephone,
      required this.email,
      required this.openingHours});

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  bool isOpened() {
    final opening = todayHours();
    final int hour = DateTime.now().hour;
    final int minute = DateTime.now().minute;
    if (opening != null) {
      if (hour >= opening.start.hour && hour <= opening.end.hour) {
        if ((hour > opening.start.hour && hour < opening.end.hour) ||
            (minute >= opening.start.minute && hour <= opening.end.minute)) {
          return true;
        }
      }
    }
    return false;
  }

  TimeInterval? todayHours() {
    final opening = openingHours;
    switch (DateTime.now().weekday) {
      case (1):
        return opening.monday;
      case (2):
        return opening.tuesday;
      case (3):
        return opening.wednesday;
      case (4):
        return opening.thursday;
      case (5):
        return opening.friday;
      case (6):
        return opening.saturday;
      case (7):
        return opening.sunday;
    }
    return null;
  }
}
