
class CategoriesModel {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? slug;
  final String? image;
  final String? description;
  final int? index;
  final bool? isHidden;
  final String? location;

  CategoriesModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.slug,
    this.image,
    this.description,
    this.index,
    this.isHidden,
    this.location,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);
}
