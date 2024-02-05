import 'package:json_annotation/json_annotation.dart';

import 'menu_item_interface.dart';

part 'category.g.dart';

@JsonSerializable()
class Category implements MenuWidget {
  final String? id;
  @override
  final String name;
  @override
  final String imageURL;
  final List<String> productIDs;

  const Category({
    this.id,
    required this.name,
    required this.imageURL,
    required this.productIDs,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
