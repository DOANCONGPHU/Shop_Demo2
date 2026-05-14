import 'package:json_annotation/json_annotation.dart';
part 'categories.g.dart';
@JsonSerializable()
class Categories {
  final String slug;
  final String name;
  final String url;

  Categories({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return _$CategoriesFromJson(json);
  }
}
