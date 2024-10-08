import 'package:dartz/dartz.dart';
import 'package:unlockd_assignment/core/error/failure.dart';

import 'package:unlockd_assignment/features/blog_posts/domain/entity/blog_post.dart';

// BlogPostRepository class to define functions
abstract class BlogPostRepository {
  Future<Either<Failure, List<BlogPostEntity>>> getBlogPosts();
}
