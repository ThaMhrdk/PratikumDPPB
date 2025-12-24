class PostModel {
  const PostModel({
    required this.id,
    required this.title,
    required this.author,
    required this.article,
    this.image,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String title;
  final String author;
  final String article;
  final String? image;
  final String? imageUrl;
  final String? createdAt;
  final String? updatedAt;

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: (json['id'] ?? 0) as int,
      title: (json['title'] ?? '') as String,
      author: (json['author'] ?? '') as String,
      article: (json['article'] ?? '') as String,
      image: json['image'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'author': author,
    'article': article,
    'image': image,
    'image_url': imageUrl,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  PostModel copyWith({
    int? id,
    String? title,
    String? author,
    String? article,
    String? image,
    String? imageUrl,
    String? createdAt,
    String? updatedAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      article: article ?? this.article,
      image: image ?? this.image,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
