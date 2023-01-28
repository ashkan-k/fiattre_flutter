import 'categories_model.dart';

class EpisodesModel {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final int? imdbScore;
  final String? genre;
  final String? director;
  final String? writer;
  final String? actors;
  final String? country;
  final String? construction_year;
  final String? award;
  final String? type;
  final String? image;
  final String? cover;
  final bool? is_special;
  final bool? is_series;
  final bool? is_suggested;
  final String? video;
  final String? video_mp4;
  final List<dynamic>? artists;
  final int? likes_count;
  final int? comments_count;
  final CategoriesModel? category;

  EpisodesModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.imdbScore,
    this.genre,
    this.director,
    this.writer,
    this.actors,
    this.country,
    this.construction_year,
    this.award,
    this.type,
    this.image,
    this.cover,
    this.is_special,
    this.is_series,
    this.is_suggested,
    this.video,
    this.video_mp4,
    this.artists,
    this.likes_count,
    this.comments_count,
    this.category,
  });

  factory EpisodesModel.fromJson(Map<String, dynamic> json) {
    return EpisodesModel(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      imdbScore: json['imdbScore'],
      genre: json['genre'],
      director: json['director'],
      writer: json['writer'],
      actors: json['actors'],
      country: json['country'],
      construction_year: json['construction_year'],
      award: json['award'],
      type: json['type'],
      image: json['image'],
      cover: json['cover'],
      is_special: json['is_special'],
      is_series: json['is_series'],
      is_suggested: json['is_suggested'],
      video: json['video'],
      video_mp4: json['video_mp4'],
      artists: json['artists'],
      likes_count: json['likes_count'],
      comments_count: json['comments_count'],
      category: json['category'],
    );
  }
}
