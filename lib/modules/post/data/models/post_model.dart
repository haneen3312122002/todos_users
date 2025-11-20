import 'package:notes_tasks/modules/post/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.title,
    required super.body,
    required super.tags,
    required super.likes,
    required super.dislikes,
    required super.views,
    required super.userId,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    final reactions = map['reactions'] as Map<String, dynamic>?;

    return PostModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      tags: List<String>.from(map['tags'] ?? const []),
      likes: reactions?['likes'] ?? 0,
      dislikes: reactions?['dislikes'] ?? 0,
      views: map['views'] ?? 0,
      userId: map['userId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'tags': tags,
      'reactions': {
        'likes': likes,
        'dislikes': dislikes,
      },
      'views': views,
      'userId': userId,
    };
  }

  PostEntity toEntity() => this;
}
