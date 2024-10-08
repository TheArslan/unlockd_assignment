import 'package:dartz/dartz.dart';
import 'package:unlockd_assignment/core/error/failure.dart';

import 'package:unlockd_assignment/features/blog_posts/domain/entity/blog_post.dart';
import 'package:unlockd_assignment/features/blog_posts/domain/repositories/blog_post_repository.dart';

// use case to fetch Blog posts
class GetBlogPosts {
  final BlogPostRepository _blogPostEntity;
  GetBlogPosts(this._blogPostEntity);
  Future<Either<Failure, List<BlogPostEntity>>> execute() {
    return _blogPostEntity.getBlogPosts();
  }
}
