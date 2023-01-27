class SlidersModel {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? slug;
  final String? file;
  final String? file_mobile;
  final String? image;
  final int? index;
  final String? link;

  SlidersModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.slug,
    this.file,
    this.file_mobile,
    this.image,
    this.index,
    this.link,
  });

  factory SlidersModel.fromJson(Map<String, dynamic> json) {
    return SlidersModel(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      name: json['name'],
      slug: json['slug'],
      file: json['file'],
      file_mobile: json['file_mobile'],
      image: json['image'],
      index: json['index'],
      link: json['link'],
    );
  }
}
