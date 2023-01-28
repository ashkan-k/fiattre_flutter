import 'episodes_model.dart';

class CategoriesModel {
  final int? id;
  final String? created_at;
  final String? updated_at;
  final String? name;
  final String? slug;
  final String? image;
  final String? description;
  final int? index;
  final bool? is_hidden;
  final String? location;
  final List<EpisodesModel>? episodes;

  CategoriesModel({
    this.id,
    this.created_at,
    this.updated_at,
    this.name,
    this.slug,
    this.image,
    this.description,
    this.index,
    this.is_hidden,
    this.location,
    this.episodes,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
      description: json['description'],
      index: json['index'],
      is_hidden: json['is_hidden'],
      location: json['location'],
      episodes: json['episodes'],
    );
  }

// CategoriesModel.fromJson(dynamic json) {
//   id = json['id'];
//   created_at = json['created_at'];
//   updated_at = json['updated_at'];
//   name = json['name'];
//   slug = json['slug'];
//   image = json['image'];
//   description = json['description'];
//   index = json['index'];
//   is_hidden = json['is_hidden'];
//   location = json['location'];
// }

// Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);
}

class CategoriesWithEpisodesModel extends CategoriesModel{
  final List<dynamic>? episssodes;

  CategoriesWithEpisodesModel({
    this.episssodes,
  });

  factory CategoriesWithEpisodesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesWithEpisodesModel(
      episssodes: json['episodes'],
    );
  }
}