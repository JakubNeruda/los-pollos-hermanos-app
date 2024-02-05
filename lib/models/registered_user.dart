import 'package:json_annotation/json_annotation.dart';

import 'food_order.dart';

part 'registered_user.g.dart';

@JsonSerializable()
class RegisteredUser {
  final String? id;
  final String firstName;
  final String surname;
  final String email;
  final String phoneNumber;
  final List<String> addresses;
  final List<String> coupons;
  final List<String> orders;
  @JsonKey(fromJson: FoodOrder.fromJson, toJson: foodOrderToJson)
  final FoodOrder openOrder;

  const RegisteredUser({
    this.id,
    required this.firstName,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.addresses,
    required this.coupons,
    required this.orders,
    required this.openOrder,
  });

  static Map<String, dynamic> foodOrderToJson(FoodOrder foodOrder) =>
      foodOrder.toJson();

  factory RegisteredUser.fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserFromJson(json);

  Map<String, dynamic> toJson() => _$RegisteredUserToJson(this);
}
