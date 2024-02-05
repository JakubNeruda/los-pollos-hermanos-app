import 'package:json_annotation/json_annotation.dart';

part 'basket_product.g.dart';

@JsonSerializable()
class BasketProduct {
  final String name;
  final double price;
  final int amount;

  const BasketProduct(
      {required this.name, required this.price, required this.amount});

  factory BasketProduct.fromJson(Map<String, dynamic> json) =>
      _$BasketProductFromJson(json);

  Map<String, dynamic> toJson() => _$BasketProductToJson(this);

  BasketProduct copyWith({String? name, double? price, int? amount}) {
    return BasketProduct(
      name: name ?? this.name,
      price: price ?? this.price,
      amount: amount ?? this.amount,
    );
  }
}
