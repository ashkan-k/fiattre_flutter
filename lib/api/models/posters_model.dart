class PostersModel {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? image;
  final String? link;
  final int? index;
  final String? location;

  PostersModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.link,
    this.index,
    this.location,
  });

  factory PostersModel.fromJson(Map<String, dynamic> json) {
    return PostersModel(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      image: json['image'],
      link: json['link'],
      index: json['index'],
      location: json['location'],
    );
  }
}
