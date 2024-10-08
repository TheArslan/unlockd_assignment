import 'package:equatable/equatable.dart';

// BlogPost Entity
class BlogPostEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  const BlogPostEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, description, imageUrl];
}
