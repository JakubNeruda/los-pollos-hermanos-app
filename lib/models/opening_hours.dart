import 'package:json_annotation/json_annotation.dart';
import 'package:los_pollos_hermanos/models/time_interval.dart';

part 'opening_hours.g.dart';

@JsonSerializable(explicitToJson: true)
class OpeningHours {
  final TimeInterval? monday;
  final TimeInterval? tuesday;
  final TimeInterval? wednesday;
  final TimeInterval? thursday;
  final TimeInterval? friday;
  final TimeInterval? saturday;
  final TimeInterval? sunday;

  const OpeningHours(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  factory OpeningHours.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningHoursToJson(this);
}
