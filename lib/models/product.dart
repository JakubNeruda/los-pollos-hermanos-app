import 'package:json_annotation/json_annotation.dart';
import 'package:los_pollos_hermanos/models/menu_item_interface.dart';

part 'product.g.dart';

@JsonSerializable()
class Product implements MenuWidget {
  final String? id;
  @override
  final String name;
  final String description;
  final double price;
  @override
  final String imageURL;
  final List<String> allergens;

  const Product(
      {this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageURL,
      required this.allergens});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
