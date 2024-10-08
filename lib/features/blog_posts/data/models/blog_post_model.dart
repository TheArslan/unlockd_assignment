import 'package:unlockd_assignment/features/blog_posts/domain/entity/blog_post.dart';

//  Model class of BlogPostModelentity
class BlogPostModel extends BlogPostEntity {
  const BlogPostModel(
      {required super.id,
      required super.description,
      required super.imageUrl,
      required super.title});
  // Factory constructor to create a BlogPost from a JSON object
  factory BlogPostModel.fromJson(Map<String, dynamic> json) {
    return BlogPostModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }

  // Convert BlogPost instance to JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
    };
  }

  // Convert BlogPost instance to entity
  BlogPostEntity toEntity() => BlogPostEntity(
      id: id, title: title, description: description, imageUrl: imageUrl);
}
