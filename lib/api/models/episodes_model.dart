import 'categories_model.dart';

class EpisodesModel {
  final int? id;
  final String? created_at;
  final String? updated_at;
  final double? imdb_score;
  final int? time;
  final String? title;
  final String? en_title;
  final String? slug;
  final String? episode;
  final String? teacher;
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
  final String? description;
  final List<dynamic>? artists;
  final int? likes_count;
  final int? comments_count;
  final int? view_count;
  final dynamic? category;
  final List<String>? awards_list;

  EpisodesModel({
    this.id,
    this.created_at,
    this.updated_at,
    this.imdb_score,
    this.genre,
    this.time,
    this.title,
    this.en_title,
    this.slug,
    this.episode,
    this.teacher,
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
    this.description,
    this.artists,
    this.likes_count,
    this.comments_count,
    this.view_count,
    this.category,
    this.awards_list,
  });

  factory EpisodesModel.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      json['category'] = CategoriesModel.fromJson(json['category']);
    }
    if (json['awards_list'] != []) {
      json['awards_list'] = List<String>.from(json['awards_list'].map((model)=> model.toString()));
    }

    return EpisodesModel(
      id: json['id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      imdb_score: json['imdb_score'],
      genre: json['genre'],
      time: json['time'],
      title: json['title'],
      en_title: json['en_title'],
      slug: json['slug'],
      episode: json['episode'],
      teacher: json['teacher'],
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
      description: json['description'],
      artists: json['artists'],
      likes_count: json['likes_count'],
      comments_count: json['comments_count'],
      view_count: json['view_count'],
      category: json['category'],
      awards_list: json['awards_list'],
    );
  }
}
